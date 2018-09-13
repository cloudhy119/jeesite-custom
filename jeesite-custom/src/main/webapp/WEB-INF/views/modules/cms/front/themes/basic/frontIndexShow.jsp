<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/front/quote.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<title>数据展示</title>
	</head>

	<body>
		<header class="data-header clearfix">
			<div class="logo pull-left">
				中国-东盟标准计量质量特检认证认可信息服务系统数据中心
			</div>
		</header>
		<div class="container-fluid">
			<div class="row">
				<div class="data-menu">
					<ul>
						<li>
							<p>
								<a href="#"><i><img src="${ctxStatic}/img-data/menu_icon2.png"/></i>平台质监大数据</a>
							</p>
							<ul class="sub-menu">
								<li>
									<a href="#">标准服务系统</a>
								</li>
								<li>
									<a href="#">东盟标准系统</a>
								</li>
								<li>
									<a href="#">物品编码系统</a>
								</li>
							</ul>
						</li>
						<li>
							<p>
								<a href="#"><i><img src="${ctxStatic}/img-data/menu_icon3.png"/></i>各系统数据统计</a>
								<p>
									<ul class="sub-menu">
										<li>
											<a href="#">计量服务系统</a>
										</li>
										<li>
											<a href="#">特检服务系统</a>
										</li>
										<li>
											<a href="#">质检服务系统</a>
										</li>
									</ul>
						</li>
					</ul>
				</div>
				<div class="data-main">
					<div class="data1">
						<table>
							<tbody>
								<tr>
									<th><em>当前总量</em></th>
									<td valign="top">
										<dl>
											<dt><img src="${ctxStatic}/img-data/icon1.png"/></dt>
											<dd>
												<b>48981</b>
												<p>标准</p>
											</dd>
										</dl>
									</td>
									<td valign="top">
										<dl>
											<dt><img src="${ctxStatic}/img-data/icon2.png"/></dt>
											<dd>
												<b>1547</b>
												<p>法律法规</p>
											</dd>
										</dl>
									</td>
									<td valign="top">
										<dl>
											<dt><img src="${ctxStatic}/img-data/icon3.png"/></dt>
											<dd>
												<b>8921</b>
												<p>规范性文件</p>
											</dd>
										</dl>
									</td>
									<td valign="top">
										<dl>
											<dt><img src="${ctxStatic}/img-data/icon3.png"/></dt>
											<dd>
												<b>2354</b>
												<p>新闻</p>
											</dd>
										</dl>
									</td>
									<td valign="top">
										<dl>
											<dt><img src="${ctxStatic}/img-data/icon5.png"/></dt>
											<dd>
												<b>354</b>
												<p>公告</p>
											</dd>
										</dl>
									</td>
								</tr>
								<tr>
									<th><em>本月新增</em></th>
									<td valign="top">
										<dl>
											<dt><img src="${ctxStatic}/img-data/icon6.png"/></dt>
											<dd>
												<b>66</b>
												<p>标准</p>
											</dd>
										</dl>
									</td>
									<td valign="top">
										<dl>
											<dt><img src="${ctxStatic}/img-data/icon7.png"/></dt>
											<dd>
												<b>65</b>
												<p>法律法规</p>
											</dd>
										</dl>
									</td>
									<td valign="top">
										<dl>
											<dt><img src="${ctxStatic}/img-data/icon8.png"/></dt>
											<dd>
												<b>26</b>
												<p>规范性文件</p>
											</dd>
										</dl>
									</td>
									<td valign="top">
										<dl>
											<dt><img src="${ctxStatic}/img-data/icon9.png"/></dt>
											<dd>
												<b>19</b>
												<p>新闻</p>
											</dd>
										</dl>
									</td>
									<td valign="top">
										<dl>
											<dt><img src="${ctxStatic}/img-data/icon10.png"/></dt>
											<dd>
												<b>48</b>
												<p>公告</p>
											</dd>
										</dl>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="data2">
						<table>
							<tbody>
								<tr>
									<td valign="top">
										<div class="data-title">各业务数据当前总量</div>
										<div class="data2-con clearfix">
											<ul>
												<li>
													<label>标准信息</label>
													<em class="bgcol1">753</em>
												</li>
												<li>
													<label>物品编码</label>
													<em class="bgcol2">36</em>
												</li>
												<li>
													<label>计量信息</label>
													<em class="bgcol3">48</em>
												</li>
												<li>
													<label>特检信息</label>
													<em class="bgcol4">39</em>
												</li>
												<li>
													<label>质检信息</label>
													<em class="bgcol5">26</em>
												</li>
												<li>
													<label>TBT通报</label>
													<em class="bgcol6">22</em>
												</li>
											</ul>
										</div>
									</td>
									<td valign="top">
										<div class="data-title">各业务数据本月新增</div>
										<div class="data2-con clearfix">
											<ul>
												<li>
													<label>标准信息</label>
													<em class="bgcol1">9</em>
												</li>
												<li>
													<label>物品编码</label>
													<em class="bgcol2">24</em>
												</li>
												<li>
													<label>计量信息</label>
													<em class="bgcol3">11</em>
												</li>
												<li>
													<label>特检信息</label>
													<em class="bgcol4">6</em>
												</li>
												<li>
													<label>质检信息</label>
													<em class="bgcol5">27</em>
												</li>
												<li>
													<label>TBT通报</label>
													<em class="bgcol6">19</em>
												</li>
											</ul>
										</div>
									</td>
									<td rowspan="2" valign="top">
										<div class="data-title">分布情况</div>
										<div class="data4">
											<img src="${ctxStatic}/img-data/001.png" />
										</div>
									</td>
								</tr>
								<tr>
									<td valign="top" colspan="2">
										<div class="map">
											<img src="${ctxStatic}/img-data/005.jpg" />
										</div>										
									</td>
								</tr>
								<tr>
									<td valign="top">
										<ul class="data3">
											<li>
												<div class="data-title">有效</div>
												<div class="data3-con clearfix">
													<div class="data3-num">
														<p><img src="${ctxStatic}/img-data/002.png"/></p>
														<p>当前</p>
													</div>
													<div class="data3-num">
														<p><img src="${ctxStatic}/img-data/003.png"/></p>
														<p>本月</p>
													</div>
												</div>
											</li>
											<li>
												<div class="data-title">草案</div>
												<div class="data3-con clearfix">
													<div class="data3-num">
														<p><img src="${ctxStatic}/img-data/004.png"/></p>
														<p>当前</p>
													</div>
													<div class="data3-num">
														<p><img src="${ctxStatic}/img-data/005.png"/></p>
														<p>本月</p>
													</div>
												</div>
											</li>
										</ul>
									</td>
									<td valign="top">
										<ul class="data3">
											<li>
												<div class="data-title">未生效</div>
												<div class="data3-con clearfix">
													<div class="data3-num">
														<p><img src="${ctxStatic}/img-data/006.png"/></p>
														<p>当前</p>
													</div>
													<div class="data3-num">
														<p><img src="${ctxStatic}/img-data/007.png"/></p>
														<p>本月</p>
													</div>
												</div>
											</li>
											<li>
												<div class="data-title">作废</div>
												<div class="data3-con clearfix">
													<div class="data3-num">
														<p><img src="${ctxStatic}/img-data/008.png"/></p>
														<p>当前</p>
													</div>
													<div class="data3-num">
														<p><img src="${ctxStatic}/img-data/009.png"/></p>
														<p>本月</p>
													</div>
												</div>
											</li>
										</ul>
									</td>
									<td valign="top">
										<div class="data-title">热点词</div>
										<div class="data5-con clearfix">
											<table>
												<tr>
													<td align="center">计量</td>
													<td align="center">质量认可认证</td>
												</tr>
												<tr>
													<td align="center" colspan="2" class="font18">标准信息</td>
												</tr>
												<tr>
													<td align="center">物品编码</td>
													<td align="center">东盟-中国东盟信息</td>
												</tr>
											</table>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</body>

</html>