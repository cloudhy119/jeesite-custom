<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Insert title here</title>
<link rel="Stylesheet" href="${ctxStatic}/css/bootstrap.min.css" />
<link rel="Stylesheet" href="${ctxStatic}/css/custom.css" />
<!--[if lt IE 9]>
  <script src="${ctxStatic}/js/respond.js"></script>
<![endif]-->
<script src="${ctxStatic}/js/echarts.common.min.js"></script>
</head>
<body>
<div class="adminIndex">
<div class="container-fluid">
	<div class="row">
	<div class="main1">
		<div class="main1-contact col-lg-4 col-md-4 col-sm-6 col-xs-6">
			<div class="main1-list">
				<div class="main1-pic"><img src="${ctxStatic}/images/icon1.png" /></div>
				<div class="main-txt">
					<em>1235</em>
					<p>今日入口车辆</p>
				</div>
			</div>
		</div>
		<div class="main1-contact col-lg-4 col-md-4 col-sm-6 col-xs-6">
			<div class="main1-list">
				<div class="main1-pic"><img src="${ctxStatic}/images/icon2.png" /></div>
				<div class="main-txt">
					<em>1129</em>
					<p>今日出口车辆</p>
				</div>
			</div>
		</div>
		<div class="main1-contact col-lg-4 col-md-4 col-sm-6 col-xs-6">
			<div class="main1-list">
				<div class="main1-pic"><img src="${ctxStatic}/images/icon3.png" /></div>
				<div class="main-txt">
					<em>52,369</em>
					<p>昨日收费金额</p>
				</div>
			</div>
		</div>
		<div class="main1-contact col-lg-4 col-md-4 col-sm-6 col-xs-6">
			<div class="main1-list">
				<div class="main1-pic"><img src="${ctxStatic}/images/icon4.png" /></div>
				<div class="main-txt">
					<em>49,568</em>
					<p>今日收费金额</p>
				</div>
			</div>
		</div>
		<div class="main1-contact col-lg-4 col-md-4 col-sm-6 col-xs-6">
			<div class="main1-list">
				<div class="main1-pic"><img src="${ctxStatic}/images/icon5.png" /></div>
				<div class="main-txt">
					<em>1520,369</em>
					<p>上月收费金额</p>
				</div>
			</div>
		</div>
		<div class="main1-contact col-lg-4 col-md-4 col-sm-6 col-xs-6">
			<div class="main1-list">
				<div class="main1-pic"><img src="${ctxStatic}/images/icon6.png" /></div>
				<div class="main-txt">
					<em>1542,348</em>
					<p>本月收费金额</p>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	<div class="container-fluid">
	<div class="row">
	<div class="main2">
		<div class="main2-contact">
			<h2>我的报表</h2>
			<div class="main2-list col-lg-2 col-md-2 col-sm-4 col-xs-4">
				<a href="javascript:;">
					<i><img src="${ctxStatic}/images/icon7.png" /></i>
					<p>出口车辆报告单</p>
				</a>
			</div>
			<div class="main2-list col-lg-2 col-md-2 col-sm-4 col-xs-4">
				<a href="javascript:;">
					<i><img src="${ctxStatic}/images/icon8.png" /></i>
					<p>入口车辆报告单</p>
				</a>
			</div>
			<div class="main2-list col-lg-2 col-md-2 col-sm-4 col-xs-4">
				<a href="javascript:;">
					<i><img src="${ctxStatic}/images/icon9.png" /></i>
					<p>入口车辆班报表</p>
				</a>
			</div>
			<div class="main2-list col-lg-2 col-md-2 col-sm-4 col-xs-4">
				<a href="javascript:;">
					<i><img src="${ctxStatic}/images/icon10.png" /></i>
					<p>出口车辆班报表</p>
				</a>
			</div>
			<div class="main2-list col-lg-2 col-md-2 col-sm-4 col-xs-4">
				<a href="javascript:;">
					<i><img src="${ctxStatic}/images/icon11.png" /></i>
					<p>日报表</p>
				</a>
			</div>
			<div class="main2-list col-lg-2 col-md-2 col-sm-4 col-xs-4">
				<a href="javascript:;">
					<i><img src="${ctxStatic}/images/icon12.png" /></i>
					<p>月报表</p>
				</a>
			</div>
		</div>
	</div>
	</div>
	</div>
	<div class="container-fluid">
	<div class="row">
	<div class="main3 col-md-6">
		<div class="main3-contact">
			<h3>最近<em>24</em>小时收费站出口车流量变化趋势</h3>
			<div id="chart1" class="chart"></div>
			<script>
				var dom = document.getElementById("chart1");
				var myChart1 = echarts.init(dom);
				var app = {};
				option = null;
				option = {
					title: {
						text: ''
					},
					tooltip: {
						trigger: 'axis',
					},
					legend: {
						data: ['出口车流量', '入口车流量', '入口/出口比率']
					},
					xAxis: [{
						type: 'category',
						data: ['17日2点', '17日4点', '17日6点', '17日8点', '17日10点', '17日12点', '17日14点', '17日16点', '17日18点', '17日20点', '17日22点', '17日24点'],
						axisPointer: {
							type: 'shadow'
						}
					}],
					yAxis: [{
							type: 'value',
							name: '数值',
							min: 0,
							max: 360000,
							interval: 90000,
							axisLabel: {
								formatter: '{value}'
							}
						},
						{
							type: 'value',
							name: '比率',
							min: 0,
							max: 3.2,
							interval: 0.8,
							axisLabel: {
								formatter: '{value}'
							}
						}
					],
					series: [{
							name: '入口车流量',
							type: 'bar',
							itemStyle: {
								normal: {
									color: '#38a2d9'
								}
							},
							data: [80000, 150000, 256000, 180000, 300000, 220000, 110000, 260000, 310000, 290000, 194000, 246000],
						},
						{
							name: '出口车流量',
							type: 'bar',
							itemStyle: {
								normal: {
									color: '#66dfe2'
								}
							},
							data: [160000, 59000, 265100, 305410, 194520, 165410, 175000, 182000, 286700, 188000, 200050, 236540]
						},
						{
							name: '入口/出口比率',
							type: 'line',
							itemStyle: {
								normal: {
									color: '#1e282c'
								}
							},
							yAxisIndex: 1,
							data: [0.2, 1.2, 1.6, 1.9, 0.8, 2.4, 1.6, 2.3, 2.0, 1.8, 1.3, 2.1]
						}
					]
				};;
				if(option && typeof option === "object") {
					myChart1.setOption(option, true);
					window.addEventListener("resize", function() {
						myChart1.resize();
					});
				}
			</script>
		</div>
	</div>
	<div class="main4 col-md-6">
		<div class="main4-contact">
			<h3>收费额排名<em>TOP7</em></h3>
			<div id="chart2" class="chart"></div>
			<script>
				var dom = document.getElementById("chart2");
				var myChart2 = echarts.init(dom);
				var app = {};
				option = null;
				option = {
					title: {
						text: ''
					},
					tooltip: {
						trigger: 'axis',
					},
					grid: {
						left: '3%',
						right: '4%',
						bottom: '3%',
						containLabel: true
					},
					xAxis: [{
						type: 'category',
						boundaryGap: false,
						data: ['罗口村', '桂湘站', '南宁站', '二塘站', '黔桂六寨', '安吉站', '高岭站']
					}],
					yAxis: [{
						type: 'value'
					}],
					series: [{
						type: 'line',
						stack: '总量',
						areaStyle: {
							normal: {}
						},
						itemStyle: {
							normal: {
								color: '#4893c0'
							}
						},
						data: [10000000, 16000000, 11000000, 12000000, 16000000, 16000000, 20000000]
					}]
				};;
				if(option && typeof option === "object") {
					myChart2.setOption(option, true);
					window.addEventListener("resize", function() {
						myChart2.resize();
					});
				}
			</script>
		</div>
	</div>
	</div>
	</div>
	</div>
</body>
</html>