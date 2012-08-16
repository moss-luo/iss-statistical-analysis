

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>gfan-应用概况</title>
<script type="text/javascript" src="../js/timeflag.js"></script>
<script type="text/javascript" src="../js/getParameter.js"></script>
<script type="text/javascript" src="../js/util.js"></script>
<script type="text/javascript" src="../js2/summarizejs/summarize.js"></script>
<script src="../js/Tab.js"></script>
</head>

<body onload="initSearch();">



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../css/css.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon" />
<script type="text/javascript"> var basePath="http://tongji.gfan.com:80/"; </script>
<script type="text/javascript"> var username="Demo"; </script>
<script type="text/javascript" language="javascript" src="../js/check.js"></script>
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/highcharts.js"></script>
<script type="text/javascript" language="javascript" src="../js/jquery.dataTables.js"></script>
  <script type="text/javascript"> var backrurl="webpage/Summarize.jsp"; </script>
<script src="../js/jquery.select-1.3.6.js"></script>
<script type="text/javascript">
	var sevenTimeFlag=1,thrTimeFlag=1;
	var pagename="";
	var datatimeflag;
	var checkplatform=0;
	var backgroundColorinfo='#fff';
	function vselSearch(productid,platformid){
		var dateFlag=30;
		vtimeflag=dateFlag;
		var tmptimecc=Math.random();
		var url=basePath+"servlet/ProductOptionServlet";
		if(productid!=null&&productid!=""&&platformid!=null&&platformid!=""){
			var params = {
				servertype:1,
				vproductid:productid,
				vplatformid:platformid,
				vtmptimecc:tmptimecc
			};
		}else{
			var params = {
				servertype:0,
				vtmptimecc:tmptimecc
			};
		}
		$.getJSON(url,params,initcallback);
	}
	
	function selSearch(){
		var dateFlag=30;
		vtimeflag=dateFlag;
		var tmptimecc=Math.random();
		var url=basePath+"servlet/ProductOptionServlet";
		var params = {
				servertype:0,
				vtmptimecc:tmptimecc
			};
		$.getJSON(url,params,initcallback);
	}
	
	
	function initcallback(data){
				var productlist=data.productList;
				var platformlist=data.platformlist;
				var productid=data.productid;
				var platformid=data.platformid;
				$("#productTxt option").remove();
				$("#productTxt").append("<option value='-1'>全部应用</option>");
				if(username=="Demo"){
					if(productlist!=null){
						for(var i=0;i<productlist.length;i++){
							if(productlist[i].productname=="脑筋急转弯高难版"){
								$("#productTxt").append("<option value='"+productlist[i].productid+"'>演示应用</option>");
							}
						}
					}
				}else{
					if(productlist!=null){
						for(var i=0;i<productlist.length;i++){
							$("#productTxt").append("<option value='"+productlist[i].productid+"'>"+productlist[i].productname+"</option>");
						}
					}
				}
				$("#productTxt option[value='"+productid+"']").attr('selected',true); 
				$("#productTxt").sSelect();
				//添加下拉列表事件
				$("#productTxt").change(function()  
				{  
					var tmptimecc=Math.random();
				    try{
			    	 	destroy();
			    	} 
					catch(e){
					} 
					 var checkValue=$("#productTxt").val(); 
					 if(checkValue!=-1){
					 	 var url=basePath+"servlet/ProductOptionServlet";
						 var params = {
							         servertype:1,
							         vproductid:checkValue,
							         vplatformid:platformid,
							         vtmptimecc:tmptimecc
							    };
						$.getJSON(url,params,selectcallback);
					 }else{
						window.location.href = basePath + "webpage/AllProductSurveyInfo.jsp";
					 }					
				});
				setPlatformOption(platformlist,platformid);
				//verify(vtimeflag);	
	}
	
	function selectcallback(data){
				var productlist=data.productList;
				var platformlist=data.platformlist;
				var productid=data.productid;
				var platformid=data.platformid;
				setPlatformOption(platformlist,platformid);
				
	}
	
	var topvplatforms="",topvplatformsName="";
			function setPlatformOption(platformlist,platformid){
				topvplatforms="";
				topvplatformsName="";
				$("#productList option").remove();
				if(platformlist!=null){
					checkplatform=0;
					for(var i=0;i<platformlist.length;i++){
						if(platformlist[i].platform==2){
							checkplatform=1
						}
						$("#productList").append("<option value='"+platformlist[i].platform+"'>"+platformlist[i].platformname+"</option>");
						if(pagename!='访问页面'){
						if(i==0){
								topvplatforms=topvplatforms+platformlist[i].platform;
								topvplatformsName=topvplatformsName+platformlist[i].platformname;
							}else{
								topvplatforms=topvplatforms+","+platformlist[i].platform;
								topvplatformsName=topvplatformsName+"+"+platformlist[i].platformname;
							
						}
						}
					}
					checkbreakli();
					if(pagename!='访问页面'){
						if(platformlist.length>1){
							$("#productList").append("<option value='3'>"+topvplatformsName+"</option>");
						}
					}
				}
				$("#productList option[value='"+platformid+"']").attr('selected',true); 
				$("#productList").sSelect();
				//changeLeftDisplay(platformid)
				//添加下拉列表事件
				if(platformid.indexOf(",")!=-1){
					 	vplatforms=topvplatforms;
					 	vplatformtype=1;
					 }else{
					 	vplatforms="";
					 	vplatformtype=0;
					 }
				selectRegisterTime();
				selectChose();
				$("#productList").change(function()  
				{  
					var tmptimecc=Math.random();
					try{ 
						destroy();
					} 
					catch(e){
					} 
					 var checkValue=$("#productTxt").val();
					 var checkpValue=$("#productList").val(); 
					 if(checkpValue.indexOf(",")!=-1){
					 	vplatforms=topvplatforms;
					 	vplatformtype=1;
					 }else{
					 	vplatforms="";
					 	vplatformtype=0;
					 }
					 var url=basePath+"servlet/ProductOptionServlet";
					 var params = {
						         servertype:1,
						         vproductid:checkValue,
						         vplatformid:checkpValue,
						         vtmptimecc:tmptimecc
						    };
					$.getJSON(url,params,optioncallback);
				});
			}
			
			function optioncallback(data){
				selectRegisterTime();
			}
			
			function selectRegisterTime(){
				timecc=Math.random();
				var checkValue=$("#productTxt").val();
				var checkpValue=$("#productList").val();
				var url=basePath+"servlet/ProductServlet";
				var params={
					servertype:8,
					productid:checkValue,
		         	platformid:checkpValue,
		         	platforms:vplatforms,
					timecc:timecc
				}
				$.get(url,params,registerback);
			}
			
			function registerback(data){
				var datas=data.split(",");
				refresh(datas[0]);
				sevenTimeFlag=parseInt(datas[1]);
				thrTimeFlag=parseInt(datas[2]);
				verify(vtimeflag);
			}
			
			function logout(){
				var vtimecc=Math.random();
				var url=basePath+"servlet/UserLoginServlet";
				var params = {
					servertype:1,
					timcc:vtimecc
				};
				$.get(url,params,logcallback);
			}
			
			function logcallback(data){
				delCookie("talkdataCookieEmail");
		   		delCookie("talkdataCookiePassWord");
		   		delCookie("talkdataCookieCheck");
				window.location.href="http://dev.gfan.com/Aspx/DevApp/LoginUser.aspx";
			}
			
			function insertfeedback(){
 				 var vtimecc=Math.random();
				 var url=basePath+"servlet/FeedBackServlet?timecc="+vtimecc;
			 	 var feedbackinfo=$("#feedbackinfo").val();
			 	 var vproductid=$("#productTxt").val();
			 	 var vpagename=pagename;
				 if(feedbackinfo==null||feedbackinfo==""){
				 	alert("请输入反馈内容");
				 }else{
				 	var params={
				 	 	feedbackinfo:feedbackinfo,
				 	 	productid:vproductid,
				 	 	pagename:vpagename
				 	 };
				 	 $.get(url,params,feedbackcallback);		
				 }
 			}
 			
 			function feedbackcallback(data){
 				if(data=="1"){
 					alert("反馈提交成功");
					document.getElementById("fktxt").style.display="none";
					document.getElementById("xy").style.display="none";
 				}else{
 					alert("反馈提交失败");
 				}
 			}
			
//弹出窗口插件
function feedback(txt,bg,colse){
	document.getElementById("feedbackinfo").value="";
		var txt=txt;
		var bg=bg;
		var sHeight=document.body.clientHeight;
		var dheight=document.documentElement.clientHeight;
		var srctop=document.documentElement.scrollTop;
		if($.browser.safari){
			srctop=window.pageYOffset;
		}
		$(".xy").css({"height":dheight});
		dheight=(dheight - $("#"+txt).height())/2;
		$("#"+txt).show();
		$("#"+bg).show();
		$("#"+txt).css({"top":( srctop+ dheight) + "px"});
		$("#"+bg).css({"top":(srctop ) + "px"});
		window.onscroll =function scall(){
			var srctop=document.documentElement.scrollTop;
		if($.browser.safari){
			srctop=window.pageYOffset;
		}
			$("#"+txt).css({"top":(srctop+ dheight) + "px"});
			$("#"+bg).css({"top":(srctop) + "px"});
			
		$("#fkicon").css({
			top : srctop + (innerHeights / 2)
		});
 			window.onscroll = scall;
			window.onresize = scall;
			window.onload = scall;
		}
		$("."+colse).click(function(){
		$("#"+txt).hide();
		$("#"+bg).hide();
		})
}	
	
function backreg(){
	window.location.href = basePath + "register.jsp";
}


			function oldUserLogin(){
 				 var vtimecc=Math.random();
				 var url=basePath+"servlet/UserLoginServlet?timecc="+vtimecc;
			 	 var params={
			 	 	url:backrurl,
			 	 	servertype:99
			 	 };
			 	 $.get(url,params,oldLogincallback);	
 			}
 			
 			function oldLogincallback(data){
 				window.location.href=basePath+backrurl;
 			}
			
</script>
</head>
<!--头部开始 !-->
<div class="web">
<div style="position:absolute; right:0px; top:0px; z-index:1">

	<img src="../images/demo.png" />

</div>
<!-- 新反馈功能!-->
	<div id="fkicon"><img border=0 onclick="feedback('fktxt','xy','fkcolse')" src="../images/help.png" /></div>
<div class="xytxt" id="fktxt" style="width:600px; margin-left:-300px;">
		<div class="xytitle"><h1>请输入您的反馈信息：</h1><a href="javascript:void(0);" class="fkcolse r"><img src="../images/close.gif" /></a></div>
        <ul>
            <li><textarea id="feedbackinfo" name="feedbackinfo" style="width:590px; padding-left:10px; margin:10px 0; height:200px; border:1px solid #dedede;"></textarea></li>
            <li><a href="javascript:void(0);" class="submitto fkcolse"   style="margin-left:10px; display:inline;  float:right"><font>取消</font></a><a class="submitto" onclick="insertfeedback();" style="float:right"><font>提交</font></a></li>
    	</ul>	
</div>
<!-- 新反馈功能结束!-->

<div  class="top">
	<div class="header">
		<div class="logo l"><a href="http://tongji.gfan.com:80/webpage/Summarize.jsp"><img src="../images/logo.jpg" alt="gfan" title="gfan"  /></a></div>
      
		  <div class="nav r" style="padding-right:40px"><font><a href="http://dev.gfan.com/Aspx/DevApp/LoginUser.aspx?url=webpage/Summarize.jsp">登录</a></font>|<font><a href="http://dev.gfan.com/Aspx/DevApp/RegDev_Main.aspx?url=webpage/Summarize.jsp">注册</a></font></div>
	  
      
    </div>
    <div class="toptitle">
    	<div class="l">
        	<span><strong>
        	 
        	  	<a href="javascript:void(0);" >产品中心</a>
        	
        	</strong><img src="../images/title_jt.jpg" /></span>
                <select name="../images/input_list_top.gif" id="productTxt" title="产品名称" style="z-index:999;">
    	  			<option>产品名称</option>
   	  			</select>
            <span><img src="../images/title_jt.jpg" /></span>
            	<select name="../images/input_list_top.gif" id="productList"  title="平台" style="z-index:999">
    	  			<option>Android</option>
   	  			</select>
        </div><a href="../document_center/statistics.jsp" target="_blank" class="r">开发指南</a>
    </div>
</div>
<div id="minweb">
<script src="../js/index.js"></script>
<!--头部结束 !-->
<link type="text/css" rel="stylesheet" href="../css/Summarize.css" />
<div class="main">
	
     

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript"> var basePath="http://tongji.gfan.com:80/"; </script>
</head>
<script type="text/javascript">

function checkbreakli(){

}
</script>
<div class="menu l">
    	<ul>
		  <li style="border:none;"><a href="http://tongji.gfan.com:80/webpage/Summarize.jsp" id="Summarize" class="Summarize"><span><font>应用概况</font></span></a></li>
          <li><a href="#this" id="User" onclick="menu(this,'User','Userclose')" class="more_icon User"><span><font>用户和使用</font></span></a>
                <ol id="Userol">
					<li><a href="http://tongji.gfan.com:80/webpage/ftrendstat.jsp" id="ftrendstat" class="ftrendstat">新增和启动</a></li>
					<li class="news"><a href="http://tongji.gfan.com:80/webpage/ActiveAnalysis.jsp" id="ActiveAnalysis" class="ActiveAnalysis">活跃分析</a></li>
					<li class="news"><a href="http://tongji.gfan.com:80/webpage/User_Time.jsp" id="User_Time" class="User_Time">时段分析</a></li>
                    <li class="news"><a href="http://tongji.gfan.com:80/webpage/User_Country.jsp" id="User_Area"  class="User_Area">地区分布</a></li>
                    <li><a href="http://tongji.gfan.com:80/webpage/VersionInfo.jsp" id="VersionInfo" class="VersionInfo">版本分布</a></li>
                    <li><a href="http://tongji.gfan.com:80/webpage/User_DeviceType.jsp" id="User_DeviceType" class="User_DeviceType">设备机型</a></li>
                    <li><a href="http://tongji.gfan.com:80/webpage/IspinInfo.jsp" id="IspinInfo" class="IspinInfo">运营商和网络</a></li>
                    <li><a href="http://tongji.gfan.com:80/webpage/User_Error.jsp" id="User_Error" class="User_Error">错误报告</a></li>
                    <!--<li><a href="http://tongji.gfan.com:80/webpage/User_PrisonBreak.jsp" id="User_PrisonBreak" class="User_PrisonBreak">越狱破解</a></li>-->
                </ol>	
          </li>
			<li><a href="#this" onclick="menu(this,'Channel','Channelclose')" id="Channel" class="more_icon Channel"><span><font>渠道统计</font></span></a>
				<ol id="Channelol">
                	<li><a href="http://tongji.gfan.com:80/webpage/PartnerData.jsp" id="PartnerData" class="PartnerData">渠道数据</a></li>
                </ol>
            </li>
          <li><a href="#this" onclick="menu(this,'ParticipateIn','ParticipateInclose')" id="ParticipateIn" class="more_icon ParticipateIn" ><span><font>参与和留存</font></span></a>
          		<ol id="ParticipateInol" >
					<li class="news"><a href="http://tongji.gfan.com:80/webpage/UserKeepInfo.jsp" id="ParticipateIn_Retain" class="ParticipateIn_Retain">用户留存</a></li>
                    <li><a href="http://tongji.gfan.com:80/webpage/FirstDayKeepInfo.jsp" id="FirstDayKeepInfo" class="FirstDayKeepInfo">留存率</a></li>
                    <li><a href="http://tongji.gfan.com:80/webpage/UserRetainInfo.jsp" id="UserRetainInfo" class="UserRetainInfo">用户回访</a></li>
                    <li><a href="http://tongji.gfan.com:80/webpage/StartTimeInfo.jsp" id="StartTimeInfo" class="StartTimeInfo">日启动次数</a></li>
                    <li class="news"><a href="http://tongji.gfan.com:80/webpage/Use_Interval.jsp" id="Use_Interval" class="Use_Interval">使用间隔</a></li>
                    <li><a href="http://tongji.gfan.com:80/webpage/UseTimeInfo.jsp" id="UseTimeInfo" class="UseTimeInfo">使用时长</a></li>
                    <li><a href="http://tongji.gfan.com:80/webpage/PageInfo.jsp" id="PageInfo" class="PageInfo">页面访问</a></li>
                </ol>
          </li>
          <li class="news1"><a href="http://tongji.gfan.com:80/webpage/CustomEvent.jsp" id="CustomEvent" class="CustomEvent"><span><font>事件和转化</font></span></a></li>
          <!--<li><a href="Domain.jsp" id="Domain" class="Domain"><span><font>行业数据</font></span></a></li>-->
		  <li><a href="http://tongji.gfan.com:80/webpage/FeedbackBySDK.jsp" id="FeedbackBy" class="FeedbackBy"><span><font>用户反馈</font></span></a></li>
		  </ul>
    </div>
    
<div class="content l" id="right">
    	<div class="boxmax">
        	<div class="title">
            	<strong class="l">近日概况</strong>
                <span class="relative r">
                    <a href="javascript:void(0)" class="bottun4" onclick="sever('server1','server1cl');"><font>?</font></a>
                	<div class="server" id="server1" style="width:620px;">
                       <div class="ser_title">
                           <b class="l">数据指标说明</b>
                           <a class="r" href="#this" id="server1cl"><img src="../images/server_close.gif" /></a>
                       </div>
                       
                                <style>
								.ser_txt font{
									width:95px
								}
								</style>
                       <div class="ser_txt">
                           <dl>
                               <dt>
                               	<font>新增用户</font>
                                <small>新增加的应用使用者（按设备），重安装应用不会重复计量。</small>                               </dt>
                               <dd>
                               	<font>活跃用户</font>
                                <small>当日，有使用应用（至少启动一次）的用户。</small>
                                </dd>
                               <dt>
                               	<font>新用户占比</font>
                                <small>活跃用户中包含了新增用户和积累下的老用户，此比例为新增用户在其中所占的比率。</small>                               </dt>
                               <dd>
                               	<font>启动次数</font>
                                <small>当日，应用被开启的次数。</small>
                                </dd>
                               <dt>
                               	<font>人均启动</font>
                                <small>当日，用户平均使用应用多少次。</small>                               </dt>
                               <dd>
                               	<font>平均使用时长</font><small>用户平均单次使用应用多长时间。</small>
                                </dd>
                               <dt>
                               	<font>日活跃率</font><small>当日的活跃用户占累计用户比例。</small>                               </dt>
                               <dd>
                               	<font>累计用户总数</font><small>使用TalkingData以来统计到的用户量总值。</small>
                                </dd>
                               <dt>
                               	<font>一次性用户（%）</font><small>自新增日后再没有使用过应用的用户和他们占累计用户的比例。</small>                               </dt>
                               <dd>
                               	<font>启动总数</font><small>使用TalkingData以来应用被开启的总次数。</small>
                                </dd>
                               <dt>
                               	<font>每日人均启动</font><small>用户在一日中平均使用应用多少次。</small>                               </dt>
                               <dd>
                               	<font>周活跃（%）</font><small>最近一周（不含今日）的活跃用户数和这些用户占累计用户比率。</small>
                                </dd>
                               <dt>
                               	<font>月活跃（%）</font><small>最近一个月（按30日计，不含今日）的活跃用户数和这些用户占累计用户比率。</small>                               </dt>
                               <dd>
                               	<font>月留存率</font><small>一个月前那一天的新增用户中在最近一周还有使用应用的用户比率。</small>
                                                               </dd>
                           </dl>
                       </div>
                	</div>
                </span>
        	</div>
            <div class="textbox"  id=0104>
                <div class="login">
                <img src="../images/loading.gif" height="25px"></img><br>
            	正在加载统计数据...
                </div>
            </div>
        </div>
        
        <div class="box">
        	<div class="contentbox l">
            	<div class="title">
            		<strong class="l">应用摘要</strong>
        			<span class="r"></span>
                </div>
                <div class="textbox" id="0105">
                	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_style2">
  						<tr>
  							<td class="left border_none">累计用户总数</td>
  							<td class="center border_none"><strong  id="900510"></strong></td>
  						</tr>
  						<tr>
  							<td class="left">一次性用户（%）</td>
  							<td class="center"><strong id="000713">--<font style="font-size:15px;">(--)</font></strong></td>
  						</tr>
                        <tr>
  							<td class="left">启动（总数 | 每日人均）</td>
  							<td class="center"><strong><font id="000322"></font>|<font id="100122" style="font-size:15px"></font></strong></td>
  						</tr>
  					</table>
                </div>
            </div>
            <div class="contentbox r">
            	<div class="title">
            		<strong class="l">活跃概况</strong>
                	<span class="r"></span>
        		</div>
                <div class="textbox" id=0106>
                	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_style2">
  						<tr>
  							<td class="left border_none">周活跃（%）</td>
  							<td class="center border_none"><strong id="000814"></strong>（<strong id="100314" style="font-size:15px"></strong>）</td>
  						</tr>
  						<tr>
  							<td class="left">月活跃（%）</td>
  							<td class="center"><strong id="000914"></strong>（<strong id="100414" style="font-size:15px"></strong>）</td>
  						</tr>
                        <tr>
  							<td class="left">月留存率</td>
  							<td class="center"><strong id="100514"></strong></td>
  						</tr>
  					</table>
                </div>
            </div>
            <div class="clear"></div>
        </div>
        
         <div class="boxmax">
        	<div class="title">
            	<strong class="l"><a href="User_Time.jsp" id="timefx">时段分析...</a></strong>
                <span class="r">
                    <div class="bottunDiv l">
                    <div class="l selectlble">对比：</div>
                    <ul class="l" id="twoo">
                        <li class="hover"><a href="javascript:void(0);" id="tab1" class="bottun3" onClick="tagsLine(this,'不对比')">不对比</a></li>
                        <li><a href="javascript:void(0);" id="tab2" class="bottun" onClick="tagsLine(this,'前一天')">前一天</a></li>
                        <li><a href="javascript:void(0);" id="tab3" class="bottun" onClick="tagsLine(this,'上周同期')">上周同期</a></li>
                        <li><a href="javascript:void(0);" id="tab4" class="bottun2" onClick="tagsLine(this,'上月同期')"><font>上月同期</font></a></li>
                    </ul>
                    </div>
                </span>
        	</div>
            <div class="textbox">
            <div>
                <ul class="bottunDiv l" id="twooLine">
                	<li class="hover"><a href="javascript:void(0);" id="tab5" class="bottun3" onClick="tagLine('two_0',this,0)">今日</a></li>
                    <li><a href="javascript:void(0);" class="bottun2" id="tab6" onClick="tagLine('two_1',this,1)"><font>昨日</font></a></li>
                </ul>
                <ul class="bottunDiv l" id="twooChType">
                	<li class="hover"><a href="javascript:void(0);" id="tab7" class="bottun3" onclick="tagsChType(this,1);">新增用户</a></li>
                    <li><a href="javascript:void(0);" class="bottun2" id="tab8" onclick="tagsChType(this,2);"><font>启动次数</font></a></li>
                </ul>
                <div class="ipcright_top r">
                
                </div>
                <div class="clear"></div></div>
                <div class="table" id="two_0">
                	<div id="containerLine0" style="width: 100%; height: 200px; margin: 0 auto;">
		            		<div class="login">
                                <img src="../images/loading.gif" height="25px"></img><br>
                                正在加载统计数据...
                            </div>
                	</div>
                </div>
                
                <div class="table displaynone" id="two_1">
                	<div id="containerLine1" style="width: 100%; height: 200px; margin: 0 auto">
                	<div class="login">
							<img src="../images/loading.gif" height="25px"></img>
							<br>
							正在加载统计数据...
						</div></div>
                </div>
                
            </div>
        </div>  
        
        <div class="boxmax">
        	<div class="title">
            	<strong class="l"><a href="ftrendstat.jsp" id="30days">30日数据趋势...</a></strong>
                <span class="r">
                </span>
        	</div>
            <div class="textbox">
                <ul class="bottunDiv" id="tagsthrday">
                	<li class="hover"><a href="javascript:void(0);" id="tab9" class="bottun3" onClick="selectthrdayTag('tagContentthrday0',this,0)">新增用户</a></li>
                    <li><a href="javascript:void(0);" id="tab10" class="bottun" onClick="selectthrdayTag('tagContentthrday1',this,1)">活跃用户</a></li>
                    <li><a href="javascript:void(0);" id="tab11" class="bottun" onClick="selectthrdayTag('tagContentthrday2',this,2)">平均使用时长</a></li>
                    <li><a href="javascript:void(0);" id="tab12" class="bottun" onClick="selectthrdayTag('tagContentthrday3',this,3)">启动次数</a></li>
                    <li><a href="javascript:void(0);" id="tab13" class="bottun2" onClick="selectthrdayTag('tagContentthrday4',this,4)"><font>累计用户</font></a></li>
                </ul>
                <div class="table" id="tagContentthrday0">
                	<div id=000102  style="width: 100%; height: 200px; margin: 0 auto">
                	<div class="login">
							<img src="../images/loading.gif" height="25px"></img>
							<br>
							正在加载统计数据...
						</div></div>
                </div>
                
                <div class="table displaynone" id="tagContentthrday1">
                	<div id=000202  style="width: 100%; height: 200px; margin: 0 auto">
                	<div class="login">
							<img src="../images/loading.gif" height="25px"></img>
							<br>
							正在加载统计数据...
						</div></div>
                </div>
                
                <div class="table displaynone" id="tagContentthrday2">
                	<div id=100202  style="width: 100%; height: 200px; margin: 0 auto">
                	<div class="login">
							<img src="../images/loading.gif" height="25px"></img>
							<br>
							正在加载统计数据...
						</div></div>
                </div>
                
                <div class="table displaynone" id="tagContentthrday3">
                	<div id=000302  style="width: 100%; height: 200px; margin: 0 auto">
                	<div class="login">
							<img src="../images/loading.gif" height="25px"></img>
							<br>
							正在加载统计数据...
						</div></div>
                </div>
                
                <div class="table displaynone" id="tagContentthrday4">
                	<div id=900502  style="width: 100%; height: 200px; margin: 0 auto">
                	<div class="login">
							<img src="../images/loading.gif" height="25px"></img>
							<br>
							正在加载统计数据...
						</div></div>
                </div>
            </div>
        </div>
        
        <ul class="Esbox" id="Esbox">
        	<!--<li class="contentbox l" id="adtop1"  style="height:353px">
            	<iframe name="poptonefrom" id="poptonefrom" src="" height="353" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="100%" ></iframe>
            </li>
            
            <li class="contentbox r" id="adtop2"  style="height:353px">
            	<iframe name="popttwofrom" id="popttwofrom" src="" height="353" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="100%" ></iframe>
            </li>
            
            <li class="contentbox l"  style="height:353px" id="adtop3">
				<iframe name="poptthrfrom" id="poptthrfrom" src="" frameborder="0" height="353" scrolling="no" marginheight="0" marginwidth="0" width="100%" ></iframe>
            </li>
            <li class="contentbox r"  style="height:353px" id="adtop4">
            	<iframe name="poptfoufrom" id="poptfoufrom" src="" height="353" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" width="100%" ></iframe>
            </li>-->
<div class="clear" id="Esboxli"></div>
        </ul><a href="#this" class="submitto" style="margin-top:20px" onclick="xytt('Addtable','xy','Addcolse')"><font style="font-size:16px; padding-left:30px"><b><strong style="margin-right:10px">+</strong>增加更多快捷仪表</b></font></a>
</div>
<div class="clear"></div>
</div>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
</div>
<div class="copyright" id="copyright">
	
	<div class="footer"><div class="l"> <a href="../document_center/statistics.jsp" id="txtbottom">功能文档</a><a href="javascript:void(0);" onclick="xytt('xytxt','xy','xycolse')">服务条款</a> <a href="../contact.jsp" target="_blank">联系我们</a> </div><div class="r">Power By <a href='http://www.tenddata.com' target="_blank">TalkingData.net</a>© 2010  机锋网 GFan.com | 迈奔公司 mAPPn.inc.版权所有 京ICP证100461</div></div></div>

<div class="xy" id="xy">
	
</div>
<div class="xytxt" id="xytxt" style="width:600px; margin-left:-300px;">
		<div class="xytitle"><h1>机锋统计服务条款</h1><a href="javascript:void(0);" class="xycolse r"><img src="../images/close.gif" /></a></div>
        <div class="xytext" style="padding:15px; margin-top:10px; background:#fff; font-size:12px; font-weight:normal; border:1px solid #dedede;">
        <p><strong>&#8226;</strong> 使用机锋统计数据统计分析服务的个人和公司应保证提供真实的注册信息，确保正确性和完整性，并在信息变更时及时更新相关内容。机锋统计不对因信息不属实而造成的任何损失承担责任。 </p>
        <p><strong>&#8226;</strong> 请妥善保管好您的账户信息，机锋统计不对因账户信息遗失或泄露而造成的损失承担责任。 </p>
        <p><strong>&#8226; </strong>机锋统计数据统计和分析平台保留随时变更平台所提供服务的权利，不保证提供的免费统计分析服务不会中断，对所提供服务的实时性、安全性、准确性不作绝对保证。</p>
        <p><strong>&#8226;</strong> 机锋统计保留系统维护、硬件更新、系统升级的权利，并可能因以上原因造成服务的短时间暂停，不对因服务中断、停止而造成的任何损失承担任何责任。</p>
        <p><strong>&#8226;</strong> 机锋统计会在服务变更和异常时尽量通知到您，但保留在未进行通知的情况下中断服务的权利。</p>
        <p><strong>&#8226;</strong> 机锋统计与您共同所有您的账户中的全部信息。</p>
        <p><strong>&#8226;</strong> 因您违反了有关法律、法规或本协议规定中的任何条款而对机锋统计或任何第三方造成的损失，您同意承担由此造成的一切损害赔偿责任。</p>
        <p><strong>&#8226;</strong> 机锋统计保留随时变更以上协议的权利，您同意接受任何合法的变更条款。</p>
        <p><strong>&#8226;</strong> 您确认使用机锋统计服务，即表示同意以上内容，并同意对使用机锋统计服务可能存在的其他潜在风险自行承担后果。</p>
        </div>
</div>
</div>
<script type="text/javascript">
	mainheight();
	var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
	document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F957618928486c5678fe3773f222f4e52' type='text/javascript'%3E%3C/script%3E"));
</script>
<div class="xytxt" id="Addtable" style="width: 300px; margin-left: -170px;">
		<div class="xytitle"><h1>增加更多快捷仪表</h1><a href="javascript:void(0);" class="Addcolse r"><img src="../images/close.gif" /></a></div>
        <span style="display:block; margin:10px 0 2px 0; font-weight:normal">请选择您想要增加的仪表：</span>
        <div class="xytext" style="padding:15px; background:#fff; font-size:12px; font-weight:normal; border:1px solid #dedede;">
        	<ul id="joinboxTable">
                <li id="litop1"><input id="top1" name="addcheckbox" type="checkbox" title="poptonefrom">Top10 用户地区</li>
                <li id="litop2"><input id="top2" name="addcheckbox" type="checkbox" title="popttwofrom">Top10 渠道来源</li>
                <li id="litop3"><input id="top3" name="addcheckbox" type="checkbox"  title="poptthrfrom">启动次数分布</li>
                <li id="litop4"><input id="top4" name="addcheckbox" type="checkbox" title="poptfoufrom">热门受访页面</li>
                <li id="litop5"><input id="top5" name="addcheckbox" type="checkbox" title="poptfivefrom">Top10 自定义事件</li>
                <li id="litop6"><input id="top6" name="addcheckbox" type="checkbox" title="poptsixfrom">Top10 机型</li>
                <li id="litop7"><input id="top7" name="addcheckbox" type="checkbox" title="poptsevenfrom">Top10 应用报错</li>
                <li id="litop8"><input id="top8" name="addcheckbox" type="checkbox" title="popteightfrom">使用时长分布</li>
                <li id="litop9"><input id="top9" name="addcheckbox" type="checkbox" title="poptnightfrom">热门应用版本</li>
			</ul>
        </div>
        <span style="display:block; margin-top:10px"><a href="javascript:void(0);" class="submitto Addcolse"   style="margin-left:10px; display:inline;  float:right"><font>取消</font></a><a class="submitto" onclick="addtag(1);" style="float:right"><font>确定</font></a></span>
</div>

</body>
</html>

