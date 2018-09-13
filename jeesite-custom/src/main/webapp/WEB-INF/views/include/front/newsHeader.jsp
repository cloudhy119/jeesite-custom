<%@ page contentType="text/html;charset=UTF-8"%>
<c:if test="${headType eq '1'}">
	<%@include file="/WEB-INF/views/standard/info/front/standardHead.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			navSelect(1);
		});
	</script>
</c:if>
<c:if test="${headType eq '2'}">
	<%@include file="/WEB-INF/views/standard/info/front/standardAseanHead.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			if("${category.parent.name}" != ""){
				if("${category.parent.name}" == "资讯中心"){
					navSelect(1);
				}else if("${category.parent.name}" == "东盟市场"){
					navSelect(3);
				}else if("${category.parent.name}" == "热点专题"){
					navSelect(4);
				}else if("${category.name}" == "研究成果"){
					navSelect(5);
				}
			}
		});
	</script>
</c:if>
<c:if test="${headType eq '3'}">
	<%@include file="/WEB-INF/views/ccgx/jiliang/front/measureHead.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			var url = window.location.href;
			//alert("=="+url);
			if(url.indexOf("6fd2bd02038a4afeb59a5ebc8500901b") >= 0){
				navSelect(1);//通知公告
			}
			if(url.indexOf("6a2dbc618f6d494ea1bc9fb6c5bdda0d") >= 0){
				navSelect(2);//计量动态
			}
			if(url.indexOf("145001a559d542439bd848aeff4b6445") >= 0){
				navSelect(3);//计量法律法规
			}
			if(url.indexOf("0a589b50ca3240e29b903ee306c4c789") >= 0){
				navSelect(5);//联系我们
			}
		});
	</script>
</c:if>
<c:if test="${headType eq '4'}">
	<%@include file="/WEB-INF/views/ccgx/tejian/front/tjStandardHead.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			var url = window.location.href;
			if(url.indexOf("6ea80c3b55754bb08ad385c46f65f249") >= 0){
				navSelect(0);//东盟动态新闻
			}
			if(url.indexOf("fe7ebda92ac444b6bb69be344348ed89") >= 0){
				navSelect(1);//通知公告
			}
			if(url.indexOf("559624c3eb3f4ce6ae4962d4d847f861") >= 0){
				navSelect(3);//监管体系
			}
			if(url.indexOf("d1754ce0839c47569f4ea45ecf4f14f0") >= 0
					|| url.indexOf("2f4fe47082144a618a8022c80fc00ae8") >= 0
					|| url.indexOf("d6837e89a8f74ad08e94da65ef92a693") >= 0){
				navSelect(4);//服务能力
			}
			if(url.indexOf("bcfafed622594b8fba2c926c2b4b8a46") >= 0){
				navSelect(5);//网上报检
			}
			if(url.indexOf("6c3f5309258f4911b3d97505157cc429") >= 0
					|| url.indexOf("0acc870d1020443b856d7af206390176") >= 0
					|| url.indexOf("bcec401490fe4fd1bc09c9eff622d889") >= 0
					|| url.indexOf("654b3deac91c483382ddca96dcc12bff") >= 0
		    ){
				navSelect(6);//留言咨询
			}
			/*
			alert("${category.parent.name}");
			if("${category.parent.name}" != ""){
				if("${category.parent.name}" == "东盟动态新闻"){
					navSelect(0);
				}else if("${category.parent.name}" == "通知公告"){
					navSelect(1);
				}else if("${category.parent.name}" == "监管体系"){
					navSelect(3);
				}
				else if("${category.parent.name}" == "服务能力"){
					navSelect(4);
				}
				else if("${category.parent.name}" == "网上报检"){
					navSelect(5);
				}
				else if("${category.parent.name}" == "留言咨询"){
					navSelect(6);
				}
			}*/
		});
	</script>
</c:if>

<c:if test="${headType eq '6'}">
	<%@include file="/WEB-INF/views/standard/tbt/front/stdTbtFrontHead.jsp"%> 
	<script type="text/javascript">
		$(document).ready(function() {
			navSelect(1);
		});
	</script>
</c:if>

<c:if test="${headType eq '7'}">
	<%@include file="/WEB-INF/views/quality/datainfo/front/zjhead.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			var url = window.location.href;
			if(url.indexOf("47e97740c1c84135b8b21c2f04a5ceeb") >= 0){
				navSelect(1);//新闻动态
			}
			if(url.indexOf("d59aefe74b46419d8fe319fba2ec61ab") >= 0 ){
				navSelect(2);//通知公告
			}
			if(url.indexOf("a69e613479f047cb8b15e3e42266f762") >= 0){
				navSelect(3);//质检信息
			}
			if(url.indexOf("080259eda55845a1843a07b2f8f0c51c") >= 0){
				navSelect(5);//机构信息
			}
			if(url.indexOf("43a8640aa94240bbb431e14ae34d3231") >= 0){
				navSelect(6);//技术服务
			}
			if(url.indexOf("43a8640aa94240bbb431e14ae34d3232") >= 0){
				navSelect(4);//技术标准
			}
			
			
		});
	</script>
</c:if>

<c:if test="${headType eq '8'}">
	<%@include file="/WEB-INF/views/ccgx/goodscode/goodscode/front/goodscodehead.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			var url = window.location.href;
			//alert("=="+url);
			if(url.indexOf("f4533bf169f84740b3937bc606b9cbcb") >= 0){
				navSelect(1);//新闻动态
			}
			if(url.indexOf("853ccddc90b947c192a4c35274a23106") >= 0 ){
				navSelect(2);//通知公告
			}
			if(url.indexOf("145001a559d542439bd848aeff4b6445") >= 0){
				navSelect(3);//产品展示
			}
			if(url.indexOf("453b985ccfed44f0be824e850f936dff") >= 0){
				navSelect(5);//专题播报
			}
			if(url.indexOf("c80b912210b34b60916a4640eb4255f3") >= 0){
				navSelect(6);//资料下载
			}
			if(url.indexOf("031825835ee94af9bc4aa9e832575ff3") >= 0){
				navSelect(6);//技术与标准
			}
			if(url.indexOf("c80b912210b34b60916a4640eb4255f3") >= 0){
				navSelect(8);//综合服务
			}

		});
	</script>
</c:if>