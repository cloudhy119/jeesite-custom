<%--
  Created by IntelliJ IDEA.
  User: huangyun
  Date: 2018/05/07
  Time: 12:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>Title</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript" src="${ctxStatic}/js/ccgx.js"></script>
    <script type="text/javascript" src="${ctxStatic}/js/avalon/avalon2.2.6.js"></script>
    <script type="text/javascript">
        //avalon数据绑定
        var vm_checklist = avalon.define({
            $id:"avalon-checklist",
            //etc数据
            etc_ecars:"", etc_ecoils:"", etc_elash:"", etc_ecritical:"", etc_ecounter:"", etc_efault:"",
                    etc_xcars:"",
            //mtc入口数据
            mtc_ecards:"", mtc_ecars:"", mtc_ecoils:"", mtc_enotcashcards:"", mtc_elash:"", mtc_enocard:"", mtc_ecritical:"",
                    mtc_ecounter:"", mtc_efault:"",
            ecards_subresult:"",ecoil_diff:"",
            //mtc出口数据
            mtc_xcards:"", mtc_xmobilecash:"", mtc_xcoils:"", mtc_deliver_tickets:"", mtc_notcash_cars:"", mtc_mobilecash_cars:"",
                    mtc_cashpay:"", mtc_cashpay_noticket:"", mtc_xfreecars:"",
            xspecial_cars:""
            //list: [{ "a": "aa" }, { "a": "bb" }, { "a": "cc" }]
        });
        //jquery管理异步ajax函数，托管的所有函数执行完成后再执行相关操作(ajax回调函数执行过dtd.resolve()后才算完成)
        $(function() {
            //检查是否选择了收费站
            var station = '${station.tsCode}';
            if(!station) {
                top.$.jBox.tip("请先选择收费站！", 'warning');
                return false;
            }
            $.when( //ajax链式处理
                etcECars(), etcXCars(), mtcECarsData(), mtcXCarsData(), deliverTickets()
            ).done(function() { //所有ajax都处理成功后才执行done里边的操作
                //计算入口相差线圈数
                vm_checklist.ecoil_diff = (vm_checklist.mtc_ecounter + vm_checklist.etc_ecounter) -
                        ((vm_checklist.mtc_ecars + vm_checklist.etc_ecars) + (vm_checklist.mtc_elash + vm_checklist.etc_elash) +
                            (vm_checklist.mtc_ecritical + vm_checklist.etc_ecritical) + (vm_checklist.mtc_efault + vm_checklist.etc_efault));
                if(vm_checklist.ecoil_diff != 0) {
                    $("#ecoil_diff").removeClass("YesIcon");
                    $("#ecoil_diff").addClass("WrongIcon");
                }
                $("#ecoil_diff")
                //计算入口发出IC卡数
                vm_checklist.ecards_subresult = (vm_checklist.mtc_ecars + vm_checklist.etc_ecars) - (vm_checklist.mtc_enotcashcards + vm_checklist.etc_ecars) - vm_checklist.mtc_elash - vm_checklist.mtc_enocard - vm_checklist.mtc_ecritical;
                if(vm_checklist.mtc_ecards != vm_checklist.ecards_subresult) {
                    $("#ecards_subresult").removeClass("YesIcon");
                    $("#ecards_subresult").addClass("WrongIcon");
                }
                //计算正常条数、异常条数
                $("#right-total-count").text($("#tableList td.YesIcon").length);
                $("#wrong-total-count").text($("#tableList td.WrongIcon").length);
            }).fail(function() {
                console.log("fail!");
            });
        });
        //------- ETC入口数据处理 -------
        var etcECars = function() {
            var dtd = $.Deferred();
            $.ajax({
                url: "${ctx}/formula/etcECars",
                dataType: "JSON",
                data: {
                    'selectDateStr': $("#selectDateStr").val(),
                    'shiftturn': $("#shiftturn").val()
                },
                success: function(data) {
                    vm_checklist.etc_ecars = data[0]['ACT_CARS'];
                    vm_checklist.etc_ecoils = data[0]['COILS'];
                    vm_checklist.etc_elash = data[0]['LASH'];
                    vm_checklist.etc_ecritical = data[0]['CRITICAL'];
                    vm_checklist.etc_ecounter = data[0]['COUNTER'];
                    vm_checklist.etc_efault = data[0]['FAULT'];
                    dtd.resolve();
                }
            })
            return dtd;
        }
        //------- ETC入口数据处理 end -------
        //------- ETC出口数据处理 -------
        var etcXCars = function() {
            var dtd = $.Deferred();
            $.ajax({
                url: "${ctx}/formula/etcXCars",
                dataType: "JSON",
                data: {
                    'selectDateStr': $("#selectDateStr").val(),
                    'shiftturn': $("#shiftturn").val()
                },
                success: function(data) {
                    vm_checklist.etc_xcars = data[0]['ACT_CARS'];
                    dtd.resolve();
                }
            })
            return dtd;
        }
        //------- ETC出口数据处理 end -------
        //------ MTC入口数据处理 ------
        var mtcECarsData = function() {
            var dtd = $.Deferred();
            $.ajax({
                url: "${ctx}/formula/mtcECarsData",
                dataType: "JSON",
                data: {
                    'selectDateStr': $("#selectDateStr").val(),
                    'shiftturn': $("#shiftturn").val()
                },
                success: function(data) {
                    vm_checklist.mtc_ecards = data[0]['IC_CARDS'];
                    vm_checklist.mtc_ecars = data[0]['ACT_CARS'];
                    vm_checklist.mtc_ecoils = data[0]['COILS'];
                    vm_checklist.mtc_enotcashcards = data[0]['NOCASH_CARDS'];
                    vm_checklist.mtc_elash = data[0]['LASH'];
                    vm_checklist.mtc_enocard = data[0]['NO_CARD'];
                    vm_checklist.mtc_ecritical = data[0]['CRITICAL'];
                    vm_checklist.mtc_ecounter = data[0]['COUNTER'];
                    vm_checklist.mtc_efault = data[0]['FAULT'];
                    dtd.resolve();
                }
            })
            return dtd;
        }
        //------ MTC入口数据处理 end ------
        //------ MTC出口数据处理 ------
        var mtcXCarsData = function() {
            var dtd = $.Deferred();
            $.ajax({
                url: "${ctx}/formula/mtcXCarsData",
                dataType: "JSON",
                data: {
                    'selectDateStr': $("#selectDateStr").val(),
                    'shiftturn': $("#shiftturn").val()
                },
                success: function(data) {
                    vm_checklist.mtc_xcards = data[0]['ACT_CARDS']; //实收卡数
                    vm_checklist.mtc_xmobilecash = data[0]['RECEIVABLE_MOBILE_CASH']; //移动支付
                    vm_checklist.mtc_xcoils = data[0]['COILS'];
                    vm_checklist.mtc_notcash_cars = data[0]['NOT_CASH_CARS'];
                    vm_checklist.mtc_mobilecash_cars = data[0]['MOBILE_CASH_CARS'];
                    vm_checklist.mtc_xfreecars = data[0]['FREE_CARS'];
                    vm_checklist.xspecial_cars = data[0]['SPECIAL_CARS'];
                    vm_checklist.mtc_cashpay = data[0]['CASH_PAY'];
                    vm_checklist.mtc_cashpay_noticket = data[0]['CASH_PAY_NOTICKET']; //现金支付未打票
                    dtd.resolve();
                }
            })
            return dtd;
        }
        //------- 发出票据 -------
        var deliverTickets = function() {
            var dtd = $.Deferred();
            $.ajax({
                url: "${ctx}/formula/deliverTickets",
                dataType: "JSON",
                data: {
                    'selectDateStr': $("#selectDateStr").val(),
                    'shiftturn': $("#shiftturn").val()
                },
                success: function(data) {
                    vm_checklist.mtc_deliver_tickets = data[0]['DELIVER_TICKETS']; //发出卡数
                    dtd.resolve();
                }
            })
            return dtd;
        }
        //------- 发出票据 end -------
        //------ MTC出口数据处理 end ------
    </script>
    <style type="text/css">
        .ms-controller{visibility:hidden;}<%-- 解决avalon扫描完成之前源码闪动的问题 --%>
    </style>
</head>
<body>
    <div class="formWrap">
        <form action="${ctx}/formula/chklist" id="searchForm" role="form" class="form-inline">
        	<div class="form-top clearfix">
	            <h1 class="form-title">数据核对情况</h1>
            </div>

            <div ms-controller="avalon-checklist" class="form-main ms-controller">
            <table width="100%" class="table table-bordered-none">
                <tbody>
                <tr>
                    <td><label>日期：</label>
                        <input id="selectDateStr" name="selectDateStr" type="text" maxlength="20" class="input-small Wdate " style="cursor:pointer"
                               value="<fmt:formatDate value="${duty.stTime}" pattern="yyyy-MM-dd"/>"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,maxDate:'%y-%M-%d'});" autocomplete="off"/>
                       <label style="margin-left:30px;">班次：</label>
                       <select id="shiftturn" name="shiftturn">
                           <option value="1" <c:if test="${duty.shiftturn == 1}">selected="selected"</c:if>>1</option>
                           <option value="2" <c:if test="${duty.shiftturn == 2}">selected="selected"</c:if>>2</option>
                           <option value="3" <c:if test="${duty.shiftturn == 3}">selected="selected"</c:if>>3</option>
                           <option value="4" <c:if test="${duty.shiftturn == 4}">selected="selected"</c:if>>4</option>
                       </select>
                       <input id="btnSubmit" class="btn btn-primary" type="submit" value="校验" style="margin-left:10px;" />
                    </td>
                    <td style="text-align: right;">
                    	当前数据：<span>正常&nbsp;<i class="num green" id="right-total-count"></i>&nbsp;条</span>   <span style="margin-left:30px;">异常&nbsp;<i class="num red" id="wrong-total-count"></i>&nbsp;条</span>
					</td>
                </tr>
                </tbody>
            </table>
            <table width="100%" border="1" class="table table-bordered table-hover table-striped" id="tableList">
                <thead>
                    <th align="center" valign="middle">分类</th>
                    <th align="center" valign="middle" colspan="3">核对公式</th>
                    <th align="center" valign="middle">校验结果</th>
                </thead>
                <tbody>
                     <tr>
                         <td rowspan="2" valign="middle" style="text-align:center;background-color:#fff;">核对ETC车辆</td>
                         <td valign="middle">完整性验证查询所有班次入口车辆数<i class="num green">{{etc_ecars}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">各班次ETC专用工号《入口车辆报告单》的车辆数<i class="num green">{{etc_ecars}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">完整性验证查询所有班次出口车辆数<i class="num green">{{etc_xcars}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">各班次ETC专用工号《出口车辆报告单》的车辆数<i class="num green">{{etc_xcars}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <!--
                     <tr style="background-color:#fef0ef;color:#d74f30">
                         <td valign="middle">完整性验证查询所有班次出口车辆数<i class="num green">{{@etc_xcars}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">各班次ETC专用工号《出口车辆报告单》的车辆数<i class="num green">{{@etc_xcars}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result WrongIcon"></td>
                     </tr>
                     -->
                     <tr>
                         <td rowspan="16" valign="middle" style="text-align:center;background-color:#fff;">核对收费班报表</td>
                         <td valign="middle">入口发出IC卡数<i class="num green">{{mtc_ecards}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">《入口车辆报告单》中的车辆合计数<i class="num green">{{mtc_ecars + etc_ecars}}</i>-非现金卡数<i class="num green">{{mtc_enotcashcards + etc_ecars}}</i>
                                -未领IC卡的冲卡车<i class="num green">{{mtc_elash}}</i>-未领IC卡的紧急车<i class="num green">{{mtc_ecritical}}</i>-未发券卡的节假日车<i class="num green">{{mtc_enocard}}</i>
                                =<i class="num green">{{ecards_subresult}}</i>
                         </td>
                         <td valign="middle" style="text-align:center;" id="ecards_subresult" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">《入口车辆报告单》中的入口发出IC卡数<i class="num green">{{mtc_ecards}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">【IC卡管理系统】生成的入口发出IC卡数<i class="num green">{{mtc_ecards}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">入口班报车辆数<i class="num green">{{mtc_ecars + etc_ecars}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">当班所有入口收费员《入口车辆报告单》车辆总数<i class="num green">{{mtc_ecars + etc_ecars}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">入口线圈数<i class="num green">{{mtc_ecoils + etc_ecoils}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">入口车辆总数<i class="num green">{{mtc_ecoils + etc_ecoils}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">入口相差线圈数<i class="num green">{{ecoil_diff}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">计数器统计数<i class="num green">{{mtc_ecounter + etc_ecounter}}</i>-（正常车辆合计车辆数<i class="num green">{{mtc_ecars + etc_ecars}}</i>
                             +冲卡车<i class="num green">{{mtc_elash + etc_elash}}</i>+紧急车<i class="num green">{{mtc_ecritical + etc_ecritical}}</i> + 设备故障<i class="num green">{{mtc_efault + etc_efault}}</i>）= <i class="num green">{{ecoil_diff}}</i>
                         </td>
                         <td valign="middle" style="text-align:center;" id="ecoil_diff" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">《出口车辆报告单》内的实收卡数<i class="num green">{{mtc_xcards}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">【IC卡管理系统】生成的出口车道交回合计数<i class="num green">{{mtc_xcards}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">《出口车辆报告单》内合计栏数据<i class="num green">{{mtc_xcoils + etc_xcars}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">实收卡数+非现金栏合计车辆数+《出口特殊车辆报告单》的无卡、未交回IC卡的冲卡车、非现金卡<i class="num green">{{mtc_xcoils + etc_xcars}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">《出口车辆报告单》内发出收据份数<i class="num green">{{mtc_deliver_tickets}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">《出口车道票据核销单》收据份数-废票数<i class="num green">{{mtc_deliver_tickets}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">《出口车辆报告单》内发出收据份数<i class="num green">{{mtc_deliver_tickets}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">收费车辆数-0费额收费车-非现金卡车-冲卡未使用票据的车辆-紧急车-无款收费车-现金支付未打票车+非当次处理次数+其他补票<i class="num green">{{mtc_deliver_tickets}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">《出口车辆报告单-移动支付》<i class="num green">{{mtc_xmobilecash}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">《出口车道票据核销单》移动支付栏的金额<i class="num green">{{mtc_xmobilecash}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">《出口车辆班报表》车辆数<i class="num green">{{mtc_xcoils}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">当班所有出口收费员《出口车辆报告单》车辆总数<i class="num green">{{mtc_xcoils}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">出口相差线圈数</td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">线圈统计合计栏-（正常车辆合计数+出口特殊车辆收、免合计数）</td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">《出口特殊车辆班报表》的特殊车辆数<i class="num green">{{xspecial_cars}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">当班所有出口收费员《出口特殊车辆报告单》车辆数<i class="num green">{{xspecial_cars}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">《出口免费车辆班报表》<i class="num green">{{mtc_xfreecars}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">当班所有出口收费员《出口免费车辆报告单》车辆总数<i class="num green">{{mtc_xfreecars}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">《出口票款核销单》收据份数<i class="num green">{{mtc_deliver_tickets}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">《出口车辆班报表》发出收据份数<i class="num green">{{mtc_deliver_tickets}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                     <tr>
                         <td valign="middle">《出口票款核销单》通行费合计金额<i class="num green">{{mtc_cashpay + mtc_xmobilecash - mtc_cashpay_noticket}}</i></td>
                         <td valign="middle" style="text-align:center;">=</td>
                         <td valign="middle">《出口车辆班报表》应收金额、实收金额<i class="num green">{{mtc_cashpay + mtc_xmobilecash}}</i>-现金支付未打票收费额<i class="num green">{{mtc_cashpay_noticket}}</i>=<i class="num green">{{mtc_cashpay + mtc_xmobilecash - mtc_cashpay_noticket}}</i></td>
                         <td valign="middle" style="text-align:center;" class="result YesIcon"></td>
                     </tr>
                </tbody>
            </table>
            <!-- 弹框 start-->
           	<div id="informDiv">
            	<div class="TipDivArrow"></div>
				<table id="informTable" border="1" class="table table-bordered">
            		<thead>
						<tr>
							<th>班次</th>
							<th>《出口车辆报告单》内的实收卡数</th>
							<th>收费员实际回收的IC卡数</th>
							<th>校验结果</th>
						</tr>
					</thead>
					<tbody>
	                     <tr>
	                         <td valign="middle">班次1</td>
	                         <td valign="middle">291</td>
	                         <td valign="middle">291</td>
	                         <td valign="middle" style="text-align:center;"><i class="WrongIcon"></i></td>
	                     </tr>	
	                     <tr>
	                         <td valign="middle">班次2</td>
	                         <td valign="middle">3850</td>
	                         <td valign="middle">3850</td>
	                         <td valign="middle" style="text-align:center;"><i class="YesIcon"></i></td>
	                     </tr>	
	                     <tr>
	                         <td valign="middle">班次3</td>
	                         <td valign="middle">4510</td>
	                         <td valign="middle">4510</td>
	                         <td valign="middle" style="text-align:center;"><i class="YesIcon"></i></td>
	                     </tr>	
	                     <tr>
	                         <td valign="middle">班次4</td>
	                         <td valign="middle">520</td>
	                         <td valign="middle">520</td>
	                         <td valign="middle" style="text-align:center;"><i class="YesIcon"></i></td>
	                     </tr>					
					</tbody>
            	</table>
            </div>
            <!-- 弹框 end -->
            </div>
        </form>
    </div>
    <script type="text/javascript">
		$(document).ready(function() {
			$('.result').hover(
				function() {
					$('#informDiv').fadeIn('slow');
				}
			);

			$('.result').mousemove(function(e) {
				/**var top = e.pageY + 5;
				var left = e.pageX - 5;**/
				var top = e.pageY + 15;
				var right = 30;
				$('#informDiv').css({
					'top': top + 'px',
					'right': right + 'px'
				});
			});

			$('.result').mouseout(function() {
				$('#informDiv').hide();
			});

		});
	</script>
</body>
</html>
