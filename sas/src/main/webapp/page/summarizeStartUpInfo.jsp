<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>应用概况</title>
		<link href="../css/css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../resources/jquery.min.js"></script>
		<script src="../resources/paindex.js"></script>
		<script src="../resources/jquery.select-1.3.6.js"></script>
		<script src="../resources/Tab.js"></script>
		<script type="text/javascript" src="../resources/getParameter.js"></script>
		<script type="text/javascript" src="../resources/index.js"></script>
		<script type="text/javascript" src="../resources/check.js"></script>
		<script type="text/javascript" language="javascript" src="../resources/highcharts.js"></script>
		<script type="text/javascript">
			var productid = getParameter("productid");
			var platformid = getParameter("platformid");
			var cid = getParameter("liid");
			var timeflag=1;
			
			function closeID(){
				if (confirm("移除启动应用次数仪表，此快捷仪表将不在本页面中显示，您依然可以在“启动次数”页面查看启动次数的详细信息，确认移除？")) {
					window.parent.addclose(cid);
				}
			}
			var startbarModel;

			function initStartUpSearch() {
				startverify(timeflag);
			}

			function startverify(tmpflag) {
				var vtimecc = Math.random();
				var url=basePath+'servlet/TenddataStartTimeInfoServlet';
				var params = {
					starttime:"",
					endtime:"",
					timeflag:timeflag,
					productid:productid,
					platformid:platformid,
					serviceCode:'1753',
					versionid:"",
			        partnerid:"",
					timecc:vtimecc
				};
				$.getJSON(url, params, startcallback);
			}

			function setthwidth(id, ftdt) {
				var tdt = $("#" + id + " .tdtxtwidth");
				for(var i = 0; i < tdt.length; ) {
					for(var j = 0; j < ftdt.length; j++) {
						jQuery(tdt[i]).width($(tdt[i]).parent().parent().parent().parent().parent().parent().width() * ftdt[j]);
						i++;
					}
				}
			}

			function ptrbg(e) {
				$("#" + e.data.id).addClass("bgbulle");
				$("#" + e.data.id).mouseout(function() {
					$("#" + e.data.id).removeClass("bgbulle");
				});
			}

			function fnreader(info) {
				return "<div class='tdtxtwidth'>" + info + "</div>";
			}

			function ctrbg(e) {
				if(!$('#' + e.data.id).hasClass('cbgbulle')) {
					$('#' + e.data.id).parent().children().removeClass('cbgbulle');
					$('#' + e.data.id).removeClass('bgbulle').addClass('cbgbulle');
				} else {
					$('#' + e.data.id).removeClass('cbgbulle');
				}
			}

			function highlight(id) {
				var nTrs = $('#' + id + ' tbody tr');
				for(var i = 0; i < nTrs.length; i++) {
					nTrs[i].id = id + "tr" + i;
					$('#' + id + 'tr' + i).unbind("mouseover", ptrbg);
					$('#' + id + 'tr' + i).unbind("click", ctrbg);
					$('#' + id + 'tr' + i).bind("mouseover", {
						id : id + "tr" + i
					}, ptrbg);
					$('#' + id + 'tr' + i).bind("click", {
						id : id + "tr" + i
					}, ctrbg);
				}
				f = initwidth(id);
				setdivwidth(f);
			}

			function setdivwidth(fc) {
				if(fc == null) {
					return;
				}
				var tdtxt = $(".tdtxtwidth");
				var parwidth = $(tdtxt[0]).parent().parent().parent().parent().parent().parent().width();
				//alert($(tdtxt[0]).parent().parent().parent().parent().parent().parent().parent().parent().attr('id'));
				if(parwidth != null && parwidth != 0) {
					for(var i = 0; i < tdtxt.length; i++) {
						$(tdtxt[i]).width(0);
						var newwidth = parwidth * ((fc[i] * 5) / 7);
						$(tdtxt[i]).width(newwidth);
					}
				}
			}

			function initwidth(id) {
				var tdtxt = $(".tdtxtwidth");
				var initf = tdtxt;
				for(var i = 0; i < tdtxt.length; i++) {
					var tdtitle = $(tdtxt[i]).html();
					$(tdtxt[i]).attr('title', tdtitle)
					$(tdtxt[i]).css({
						"min-width" : "24px"
					});
					if(id == 'example') {
						initf[i] = ($(tdtxt[i]).width() / $(tdtxt[i]).parent().parent().parent().parent().parent().parent().width());
					} else {
						initf[i] = ($(tdtxt[i]).parent().width() / $(tdtxt[i]).parent().parent().parent().parent().parent().parent().width());
					}
				}
				return initf;
			}

			var oaw, naw;
			var f = null;

			function kfgd() {
				var srtop = document.documentElement.scrollTop;
				if($.browser.safari) {
					srtop = window.pageYOffset;
				}
				var innerHeights = document.documentElement.clientHeight;
				if($.browser.safari) {
					innerHeights = window.innerHeight;
				}
				$("#fkicon").css({
					top : srtop + (innerHeights / 2)
				});
				window.onscroll = kfgd;
				window.onload = kfgd;
			}


			$(document).ready(function() {
				oaw = window.innerWidth;

				//自适应浏览器宽高
				var winWidths = 0;
				function findDimensions()//函数：获取尺寸
				{
					//获取窗口宽度
					if(window.innerWidth) {
						winWidths = window.innerWidth;
						naw = winWidths;
					} else if((document.body) && (document.body.clientWidth)) {
						winWidths = document.body.clientWidth;
						winWidths = winWidths + 15;
					}
					//通过深入Document内部对body进行检测，获取窗口大小
					//if (document.documentElement  &&   document.documentElement.clientWidth){
					//  winWidths = document.documentElement.clientWidth;
					//  }
					if(winWidths < 265) {
						winWidths = 265;
					}
					winWidths = winWidths - 226;
					/* if(winWidths>1140)
					winWidths=1140;
					if($.browser.safari){winWidths = winWidths+110}*/
					//结果输出至两个文本框
					$("#right").css({
						width : winWidths
					});
					//根据窗口大小显示多少文字
					setdivwidth(f);
					//	根据窗口大小显示多少文字结束
				}

				findDimensions();
				window.onresize = findDimensions;
				window.onscroll = kfgd;

			});
			function startcallback(data) {
				startbarModel = data.data1753;
				setpiegrid();
				parent.SetCwinHeight("poptthrfrom");
			}

			function setpiegrid() {
				var info,vcategories,seccategories;
				
				if(startbarModel!=null&&startbarModel!=""){
					info = startbarModel.data0041Categorie;
					vcategories = startbarModel.data0041;
					seccategories=startbarModel.data1057;
				}
				
				vcategories=changeStrToJson(vcategories);
				
				var chartColumn = new Highcharts.Chart({
					chart : {
						renderTo : "1753",
						defaultSeriesType : 'bar',
						backgroundColor : '#f3f4f9',
						marginTop:20
					},
					title : {
						text : ''
					},
					tooltip : {
						formatter : function() {
							return this.series.name +':'+ this.y;
						}
					},
					xAxis : [{
						categories : info,
						title : {
							text : null
						}
					},{
						categories : seccategories,
						title : {
							text : null
						},
						labels: {
							formatter: function() {
								return this.value +'%';
							}
						},
						opposite: true
					}],
					yAxis : {
						min : 0,
						title : {
							text : null
						}
					},
					credits : {
						enabled : false
					},
					legend : {
						enabled : false
					},
					plotOptions : {
						bar : {
							pointWidth:15,
							dataLabels : {
								enabled : true,
								formatter : function() {
									return '' + this.y;
								}
							}
						},
						scatter : {
							marker : {
								enabled : false
							}
						}
					},
					series : [{
						name : "日启动次数",
						legendIndex : 0,
						xAxis:0,
						data : vcategories
					},{
						name : "日启动次数",
						legendIndex : 2,
						xAxis:1,
						type: 'scatter',
						data : vcategories
					}]
				});
			}

			function setHrefInfo() {
				parent.setHref('webpage/StartTimeInfo.jsp');
			}
			
			function selectTimeFlag(){
				$('#1753').html('<div class="login"><img src="../images/loading.gif" height="25px"></img><br>正在加载统计数据...</div>');
				timeflag=$("#date").val();
				startverify(timeflag);
			}
		</script>
	</head>
	<body onload="initStartUpSearch();">
		<div class="title2">
			<strong class="l"><a href="javascript:void(0);" onclick="setHrefInfo();">用户启动应用次数...</a></strong>
			<span class="r"><a href="javascript:void(0);" class="colse" onclick="closeID()"></a></span>
            <div class="bottunDiv r" style="margin-top:8px">
             <select name="选择日期" id="date" title="选择日期" class="df" onchange="selectTimeFlag();">
                 <option value="0">今日</option>
                 <option value="1" selected="selected">昨日</option>
                 <option value="7">7日</option>
             </select>
         </div>
		</div>
		<div class="textbox" style="height:313px">
			<div id="1753" style="height:312px">
				<div class="login">
					<img src="../images/loading.gif" height="25px"></img>
					<br>
					正在加载统计数据...
				</div>
			</div>
		</div>
	</body>
</html>