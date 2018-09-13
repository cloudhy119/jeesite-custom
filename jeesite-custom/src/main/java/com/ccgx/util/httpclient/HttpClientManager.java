package com.ccgx.util.httpclient;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URISyntaxException;
import java.nio.charset.Charset;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HeaderElement;
import org.apache.http.HeaderElementIterator;
import org.apache.http.HttpException;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.config.ConnectionConfig;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.config.SocketConfig;
import org.apache.http.conn.ConnectionKeepAliveStrategy;
import org.apache.http.conn.routing.HttpRoute;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.cookie.Cookie;
import org.apache.http.cookie.CookieOrigin;
import org.apache.http.cookie.CookieSpec;
import org.apache.http.cookie.CookieSpecProvider;
import org.apache.http.cookie.MalformedCookieException;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.FormBodyPart;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.impl.cookie.BasicClientCookie;
import org.apache.http.impl.cookie.BestMatchSpec;
import org.apache.http.impl.cookie.BestMatchSpecFactory;
import org.apache.http.impl.cookie.BrowserCompatSpec;
import org.apache.http.impl.cookie.BrowserCompatSpecFactory;
import org.apache.http.message.BasicHeaderElementIterator;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.protocol.HttpContext;
import org.apache.http.ssl.SSLContextBuilder;
import org.apache.http.util.EntityUtils;

class QunarAnyTrustStrategy implements TrustStrategy{
	@Override
	public boolean isTrusted(X509Certificate[] chain, String authType) throws CertificateException {
		return true;
	}
}
/**
 * @author huangyun
 *
 */
class MyKeepAliveStrategy implements ConnectionKeepAliveStrategy {
	@Override
	public long getKeepAliveDuration(HttpResponse response, HttpContext context) {
		// Honor 'keep-alive' header
        HeaderElementIterator it = new BasicHeaderElementIterator(
                response.headerIterator(HTTP.CONN_KEEP_ALIVE));
        while (it.hasNext()) {
            HeaderElement he = it.nextElement();
            String param = he.getName();
            String value = he.getValue();
            if (value != null && param.equalsIgnoreCase("timeout")) {
                try {
                    return Long.parseLong(value) * 1000;
                } catch(NumberFormatException ignore) {
                }
            }
        }
        HttpHost target = (HttpHost) context.getAttribute(
                HttpClientContext.HTTP_TARGET_HOST);
        if ("www.naughty-server.com".equalsIgnoreCase(target.getHostName())) {
            // Keep alive for 5 seconds only
            return 5 * 1000;
        } else {
            // otherwise keep alive for 30 seconds
            return 20 * 1000;
        }
	}
}

public class HttpClientManager {

	private static final Log log= LogFactory.getLog(HttpClientManager.class);
	private static int bufferSize= 1024;
	private ConnectionConfig connConfig;
	private SocketConfig socketConfig;
	private ConnectionSocketFactory plainSF;
	private KeyStore trustStore;
	private SSLConnectionSocketFactory sslsf;
	private SSLContextBuilder sslContext;
	private Registry<ConnectionSocketFactory> registry;
	private PoolingHttpClientConnectionManager connManager;
//	private volatile HttpClient client;
	private volatile BasicCookieStore cookieStore;
	private RequestConfig requestConfig;
	private HttpClient client;
	
	public static String defaultEncoding= "UTF-8";
	
	private static volatile HttpClientManager instance;
	
	CookieSpecProvider easySpecProvider = new CookieSpecProvider() {  
	    public CookieSpec create(HttpContext context) {  
        return new BrowserCompatSpec() { 
			public void validate(Cookie cookie, CookieOrigin origin)  
				throws MalformedCookieException {  
				
				}
			};  
	    }  
	};
	
	private HttpClientManager(){
		connConfig = ConnectionConfig.custom().setCharset(Charset.forName(defaultEncoding)).build();
		socketConfig = SocketConfig.custom().setSoKeepAlive(true).setSoTimeout(20000).build();
		RegistryBuilder<ConnectionSocketFactory> registryBuilder = RegistryBuilder.<ConnectionSocketFactory>create();
		plainSF = new PlainConnectionSocketFactory();
		registryBuilder.register("http", plainSF);
		try {
			trustStore = KeyStore.getInstance(KeyStore.getDefaultType());
			sslContext = new SSLContextBuilder();
			sslContext.loadTrustMaterial(null, new TrustStrategy() {
                @Override
                public boolean isTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {
                    return true;
                }
            });
			sslsf = new SSLConnectionSocketFactory(sslContext.build(), new String[]{"SSLv2Hello", "SSLv3", "TLSv1", "TLSv1.1"}, null, NoopHostnameVerifier.INSTANCE);
			registryBuilder.register("https", sslsf);
		} catch (KeyStoreException e) {
			throw new RuntimeException(e);
		} catch (KeyManagementException e) {
			throw new RuntimeException(e);
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException(e);
		}
		registry = registryBuilder.build();
		connManager = new PoolingHttpClientConnectionManager(registry);
		connManager.setDefaultConnectionConfig(connConfig);
		connManager.setDefaultSocketConfig(socketConfig);
		connManager.setMaxTotal(400);
		HttpHost localhost = new HttpHost("quv.trade.qunar.com", 80);
		connManager.setMaxPerRoute(new HttpRoute(localhost), 200);
		connManager.setDefaultMaxPerRoute(100);
		cookieStore = new BasicCookieStore();
		Registry<CookieSpecProvider> cookieReg = RegistryBuilder.<CookieSpecProvider>create()  
				.register(CookieSpecs.BEST_MATCH,  
						new BestMatchSpecFactory())  
				.register(CookieSpecs.BROWSER_COMPATIBILITY,  
						new BrowserCompatSpecFactory())  
				.register("mySpec", easySpecProvider)  
				.build(); 
		requestConfig = RequestConfig.custom().setSocketTimeout(8000)
				.setCircularRedirectsAllowed(true).setConnectTimeout(6000)
				.setCookieSpec("mySpec")
				.build();
		client = HttpClientBuilder.create()
				.setDefaultCookieSpecRegistry(cookieReg)
				.setDefaultRequestConfig(requestConfig)
				.setDefaultCookieStore(cookieStore)
				.setConnectionManager(connManager)
				.setKeepAliveStrategy(new MyKeepAliveStrategy()).build();
		new IdleConnectionMonitorThread(connManager).start();
	}
	
	public static HttpClientManager getInstance(){
		if (HttpClientManager.instance == null){
			instance = new HttpClientManager();
		}
		return instance;
	}
	

	protected static List<NameValuePair> paramsConverter(Map<String, String> params){
		List<NameValuePair> nvps = new LinkedList<NameValuePair>();
		Set<Entry<String, String>> paramsSet= params.entrySet();
		for (Entry<String, String> paramEntry : paramsSet) {
			nvps.add(new BasicNameValuePair(paramEntry.getKey(), paramEntry.getValue()));
		}
		return nvps;
	}

	public static String readStream(HttpResponse response, String encoding){
		try {
			InputStream in = response!=null ? response.getEntity().getContent() : null;
			if (in == null){
				return null;
			}
			InputStreamReader inReader= null;
			if (encoding == null){
				inReader= new InputStreamReader(in, defaultEncoding);
			}else{
				inReader= new InputStreamReader(in, encoding);
			}
			char[] buffer= new char[bufferSize];
			int readLen= 0;
			StringBuffer sb= new StringBuffer();
			while((readLen= inReader.read(buffer))!=-1){
				sb.append(buffer, 0, readLen);
			}
			inReader.close();
			return sb.toString();
		} catch (IOException e) {
			log.error("", e);
		} finally {
			try {
				EntityUtils.consume(response.getEntity());
			} catch (IOException e) {
				log.error(e);
			}
		}
		return null;
	}

	public InputStream doGet(String url, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response= this.doGet(url, null, httpContext);
		return response!=null ? response.getEntity().getContent() : null;
	}

	public String doGetForString(String url, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response= this.doGet(url, null, httpContext);
		return HttpClientManager.readStream(response, null);
	}
	public String doGetForString(String url, String encoding, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response= this.doGet(url, null, httpContext);
		return HttpClientManager.readStream(response, encoding);
	}

	public InputStream doGetForStream(String url, Map<String, String> queryParams, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response= this.doGet(url, queryParams, httpContext);
		return response!=null ? response.getEntity().getContent() : null;
	}

	public String doGetForString(String url, Map<String, String> queryParams, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response= this.doGet(url, queryParams, httpContext);
		return HttpClientManager.readStream(response, null);
	}
	public String doGetForString(String url, Map<String, String> headerParams, Map<String, String> queryParams, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response= this.doGet(url, headerParams, queryParams, httpContext);
		return HttpClientManager.readStream(response, null);
	}
	public String doGetForString(String url, Map<String, String> queryParams, String encoding, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response= this.doGet(url, queryParams, httpContext);
		return HttpClientManager.readStream(response, encoding);
	}

	/**
	 * @return
	 * @throws URISyntaxException 
	 * @throws IOException 
	 * @throws ClientProtocolException 
	 */
	public HttpResponse doGet(String url, Map<String, String> queryParams, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpGet gm = new HttpGet();
		URIBuilder builder = new URIBuilder(url);
		if (queryParams!=null && !queryParams.isEmpty()){
			builder.setParameters(HttpClientManager.paramsConverter(queryParams));
		}
		gm.setURI(builder.build());
		gm.setConfig(requestConfig);
		return client.execute(gm, httpContext);
	}
	public HttpResponse doGet(String url, Map<String, String> headerParams, Map<String, String> queryParams, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpGet gm = new HttpGet();
		URIBuilder builder = new URIBuilder(url);
		if (headerParams!=null && !headerParams.isEmpty()){
			for(String key : headerParams.keySet()) {
				gm.addHeader(key, headerParams.get(key));
			}
		}
		if (queryParams!=null && !queryParams.isEmpty()){
			builder.setParameters(HttpClientManager.paramsConverter(queryParams));
		}
		gm.setURI(builder.build());
		gm.setConfig(requestConfig);
		return client.execute(gm, httpContext);
	}

	public InputStream doPostForStream(String url, Map<String, String> queryParams, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException {
		Map<String, String> formParams = null;
		HttpResponse response = this.doPost(url, queryParams, formParams, httpContext);
		return response!=null ? response.getEntity().getContent() : null;
	}

	public String doPostForString(String url, Map<String, String> queryParams, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException {
		Map<String, String> formParams = null;
		HttpResponse response = this.doPost(url, queryParams, formParams, httpContext);
		return HttpClientManager.readStream(response, null);
	}
	public String doPostForString(String url, Map<String, String> queryParams, String encoding, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException {
		Map<String, String> formParams = null;
		HttpResponse response = this.doPost(url, queryParams, formParams, httpContext);
		return HttpClientManager.readStream(response, encoding);
	}
	public InputStream doPostForStream(String url, Map<String, String> queryParams, Map<String, String> formParams, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response = this.doPost(url, queryParams, formParams, httpContext);
		return response!=null ? response.getEntity().getContent() : null;
	}
	public InputStream doPostForStream(String url, Map<String, String> queryParams, List<NameValuePair> nvps, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response = this.doPost(url, queryParams, nvps, httpContext);
		return response!=null ? response.getEntity().getContent() : null;
	}

	public String doPostRetString(String url, Map<String, String> queryParams, Map<String, String> formParams, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response = this.doPost(url, queryParams, formParams, httpContext);
		return HttpClientManager.readStream(response, null);
	}
	public String doPostRetString(String url, Map<String, String> queryParams, Map<String, String> formParams, String encoding, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response = this.doPost(url, queryParams, formParams, httpContext);
		return HttpClientManager.readStream(response, encoding);
	}
	public String doPostRetString(String url, Map<String, String> headerParams, Map<String, String> queryParams, Map<String, String> formParams, String msgBody, String encoding, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response = this.doPost(url, headerParams, queryParams, formParams, msgBody, httpContext);
		return HttpClientManager.readStream(response, encoding);
	}
	public String doPostRetString(String url, Map<String, String> queryParams, Map<String, String> formParams, String msgBody, String encoding, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response = this.doPost(url, null, queryParams, formParams, msgBody, httpContext);
		return HttpClientManager.readStream(response, encoding);
	}
	public String doPostRetString(String url, Map<String, String> queryParams, List<NameValuePair> nvps, String encoding, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpResponse response = this.doPost(url, queryParams, nvps, httpContext);
		return HttpClientManager.readStream(response, encoding);
	}

	/**
	 * @return
	 * @throws URISyntaxException 
	 * @throws IOException 
	 * @throws ClientProtocolException 
	 */
	public HttpResponse doPost(String url, Map<String, String> queryParams, Map<String, String> formParams, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpPost pm = new HttpPost();
		URIBuilder builder = new URIBuilder(url);
		if (queryParams!=null && !queryParams.isEmpty()){
			builder.setParameters(HttpClientManager.paramsConverter(queryParams));
		}
		pm.setURI(builder.build());
		if (formParams!=null && !formParams.isEmpty()){
			pm.setEntity(new UrlEncodedFormEntity(HttpClientManager.paramsConverter(formParams)));
		}
		pm.setConfig(requestConfig);
		return client.execute(pm, httpContext);
	}
	/**
	 * @return
	 * @throws URISyntaxException 
	 * @throws IOException 
	 * @throws ClientProtocolException 
	 */
	public HttpResponse doPost(String url, Map<String, String> queryParams, Map<String, String> formParams, String msgBody, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		return doPost(url, null, queryParams, formParams, msgBody, httpContext);
	}
	/**
	 * @return
	 * @throws URISyntaxException 
	 * @throws IOException 
	 * @throws ClientProtocolException 
	 */
	public HttpResponse doPost(String url, Map<String, String> headerParams, Map<String, String> queryParams, Map<String, String> formParams, String msgBody, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpPost pm = new HttpPost();
		URIBuilder builder = new URIBuilder(url);
		if(headerParams != null && !headerParams.isEmpty()) {
			for(String param : headerParams.keySet()) {
				String value = headerParams.get(param);
				pm.addHeader(param, value);
			}
		}
		if (queryParams!=null && !queryParams.isEmpty()){
			builder.setParameters(HttpClientManager.paramsConverter(queryParams));
		}
		pm.setURI(builder.build());
		if (formParams!=null && !formParams.isEmpty()){
			pm.setEntity(new UrlEncodedFormEntity(HttpClientManager.paramsConverter(formParams)));
		}
		StringEntity entity = new StringEntity(msgBody, defaultEncoding);
		entity.setContentType("text/xml;charset=UTF-8");  
		entity.setContentEncoding(defaultEncoding);
		pm.setEntity(entity);
		pm.setConfig(requestConfig);
		return client.execute(pm, httpContext);
	}
	public HttpResponse doPost(String url, Map<String, String> queryParams, List<NameValuePair> nvps, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpPost pm = new HttpPost();
		URIBuilder builder = new URIBuilder(url);
		if (queryParams!=null && !queryParams.isEmpty()){
			builder.setParameters(HttpClientManager.paramsConverter(queryParams));
		}
		pm.setURI(builder.build());
		if (nvps!=null && !nvps.isEmpty()){
			pm.setEntity(new UrlEncodedFormEntity(nvps));
		}
		pm.setConfig(requestConfig);
		return client.execute(pm, httpContext);
	}

	/**
	 * @return
	 * @throws URISyntaxException 
	 * @throws ClientProtocolException 
	 * @throws HttpException
	 * @throws IOException
	 */
	public HttpResponse multipartPost(String url, Map<String, String> queryParams, List<FormBodyPart> formParts, HttpContext httpContext) throws URISyntaxException, ClientProtocolException, IOException{
		HttpPost pm= new HttpPost();
		URIBuilder builder = new URIBuilder(url);
		if (queryParams!=null && !queryParams.isEmpty()){
			builder.setParameters(HttpClientManager.paramsConverter(queryParams));
		}
		pm.setURI(builder.build());
		if (formParts!=null && !formParts.isEmpty()){
			MultipartEntityBuilder entityBuilder = MultipartEntityBuilder.create();
			entityBuilder = entityBuilder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
			for (FormBodyPart formPart : formParts) {
				entityBuilder = entityBuilder.addPart(formPart.getName(), formPart.getBody());
			}
			pm.setEntity(entityBuilder.build());
		}
		pm.setConfig(requestConfig);
		return client.execute(pm, httpContext);
	}

	/**
	 * @return
	 */
	public Map<String, Cookie> getCookie(String domain, Integer port, String path, Boolean useSecure){
		if (domain == null){
			return null;
		}
		if (port==null){
			port= 80;
		}
		if (path==null){
			path="/";
		}
		if (useSecure==null){
			useSecure= false;
		}
		List<Cookie> cookies = cookieStore.getCookies();
		if (cookies==null || cookies.isEmpty()){
			return null;
		}

		CookieOrigin origin= new CookieOrigin(domain, port, path, useSecure);
		BestMatchSpec cookieSpec = new BestMatchSpec();
		Map<String, Cookie> retVal= new HashMap<String, Cookie>();
		for (Cookie cookie : cookies) {
			if(cookieSpec.match(cookie, origin)){
				retVal.put(cookie.getName(), cookie);				
			}
		}
		return retVal;
	}

	/**
	 */
	public boolean setCookie(Map<String, String> cookies, String domain, String path, Boolean useSecure){
		synchronized (cookieStore) {
			if (domain==null){
				return false;
			}
			if (path==null){
				path= "/";
			}
			if (useSecure==null){
				useSecure= false;
			}
			if (cookies==null || cookies.isEmpty()){
				return true;
			}
			Set<Entry<String, String>> set= cookies.entrySet();
			String key= null;
			String value= null;
			for (Entry<String, String> entry : set) {
				key= entry.getKey();
				value = entry.getValue();
				if (key==null || key.isEmpty() || value==null || value.isEmpty()){
					throw new IllegalArgumentException("cookies key and value both can not be empty");
				}
				BasicClientCookie cookie= new BasicClientCookie(key, value);
				cookie.setDomain(domain);
				cookie.setPath(path);
				cookie.setSecure(useSecure);
				cookieStore.addCookie(cookie);
			}
			return true;
		}
	}
	
	public void addCookies(List<BasicClientCookie> cookies) {
		if(cookies != null && !cookies.isEmpty()) {
			for(BasicClientCookie cookie : cookies) {
				cookieStore.addCookie(cookie);
			}
		}
	}
	
	public BasicCookieStore getCookieStore() {
		return cookieStore;
	}

	/**
	 */
	public boolean setCookie(String key, String value, String domain, String path, Boolean useSecure){
		Map<String, String> cookies= new HashMap<String, String>();
		cookies.put(key, value);
		return setCookie(cookies, domain, path, useSecure);
	}
	
	/**
	 * 发起httpget请求获取页面内容，并判断请求是否成功，包括判断http结果以及根据关键字判断页面是否正确
	 * @param url
	 * @param keyword 页面获取成功时，页面内容必然包含的keyword，用以判断返回页面是否正确
	 * @param result
	 * @return
	 */
	public boolean httpGet(String url, String keyword, String encoding, Map<String, String> result) {
		boolean succ = true;
		HttpClientContext httpContext = HttpClientContext.create();
		String html = null;
		try {
			html = HttpClientManager.getInstance().doGetForString(url, encoding, httpContext);
			if(!html.contains(keyword)) //页面不包含关键词，获取的页面不正确
				succ = false;
		} catch (Exception e) { //http异常，获取失败
			log.error("", e);
			succ = false;
		}
		if(succ)
			result.put("html", html);
		return succ;
	}
	
}
