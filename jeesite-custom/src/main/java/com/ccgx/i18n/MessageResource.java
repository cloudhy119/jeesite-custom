package com.ccgx.i18n;

import java.text.MessageFormat;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.context.support.AbstractMessageSource;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.ResourceLoader;

import com.ccgx.i18n.entity.I18nResource;
import com.ccgx.i18n.service.I18nResourceService;
import com.thinkgem.jeesite.common.utils.StringUtils;

/**
 * @author huangyun
 */
public class MessageResource extends AbstractMessageSource implements ResourceLoaderAware {

	@SuppressWarnings("unused")
	private ResourceLoader resourceLoader;
	@Autowired
	private I18nResourceService i18nResourceService;
	
	private String defaultLocale;

	/**
	 * Map切分字符
	 */
	protected final String MAP_SPLIT_CODE = "|";
	private final ConcurrentMap<String, ConcurrentMap<String, String>> cachedProperties =
			new ConcurrentHashMap<String, ConcurrentMap<String, String>>();

	public MessageResource() {
		/*
		 * messageSource加载时，注解的I18nResourceService的bean还没有被初始化，此时执行reload会空指针。
		 * 改在MessageSourceInitializing类中调用reload方法，项目加载完成时才去执行
		 */
//		reload();
	}
	
	public void reload() {
		List<I18nResource> resources = i18nResourceService.findList(new I18nResource());
		for (I18nResource item : resources) {
			String locale = item.getLang();
			String key = item.getName();
			String text = item.getText();
			
			ConcurrentMap<String, String> properties = getCachedProperties().get(locale);
			if(properties == null) {
				properties = new ConcurrentHashMap<String, String>();
				ConcurrentMap<String, String> oldProperties = getCachedProperties().putIfAbsent(locale, properties);
				if(oldProperties != null) {
					properties = oldProperties;
				}
			}
			properties.put(key, text);
		}
	}

	/**
	 * 
	 * 描述：TODO
	 * 
	 * @param code
	 * @param locale
	 *            本地化语言
	 * @return
	 */
	private String getText(String code, Locale locale) {
		String resourceText = code; //如果没有匹配值则返回code
		ConcurrentMap<String, String> properties = getCachedProperties().get(locale.toString());
		if(properties == null) {
			properties = getCachedProperties().get(defaultLocale); //取默认语言
		}
		if(properties != null) {
			String text = properties.get(code);
			if(StringUtils.isNotBlank(text)) {
				resourceText = text;
			}
		}
		return resourceText;
	}

	@Override
	public void setResourceLoader(ResourceLoader resourceLoader) {
		this.resourceLoader = (resourceLoader != null ? resourceLoader : new DefaultResourceLoader());
	}

	@Override
	protected MessageFormat resolveCode(String code, Locale locale) {
		String msg = getText(code, locale);
		MessageFormat result = createMessageFormat(msg, locale);
		return result;
	}

	@Override
	protected String resolveCodeWithoutArguments(String code, Locale locale) {
		String result = getText(code, locale);
		return result;
	}

	public String getDefaultLocale() {
		return defaultLocale;
	}

	public void setDefaultLocale(String defaultLocale) {
		this.defaultLocale = defaultLocale;
	}

	public ConcurrentMap<String, ConcurrentMap<String, String>> getCachedProperties() {
		return cachedProperties;
	}
}
