

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>gfan-地区分布</title>
<script type="text/javascript" src="../js/timeflag.js"></script>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js2/User_Area/User_Area.js"></script>
<link type="text/css" rel="stylesheet" href="../css/User_Area.css">
</head>

<body onload="initSearch();">
<!--头部开始 !-->



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
  <script type="text/javascript"> var backrurl="webpage/User_Area.jsp"; </script>
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
      
		  <div class="nav r" style="padding-right:40px"><font><a href="http://dev.gfan.com/Aspx/DevApp/LoginUser.aspx?url=webpage/User_Area.jsp">登录</a></font>|<font><a href="http://dev.gfan.com/Aspx/DevApp/RegDev_Main.aspx?url=webpage/User_Area.jsp">注册</a></font></div>
	  
      
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
<!--头部结束 !-->
<!--内容开始 !-->
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
			<div class="maintop">
            	<div class="l margin_right">
                	<a class="bottun5 l hover" href="javascript:void(0);">中国地区</a>
                    <a class="bottun7 l" href="User_Country.jsp"><font>全球分布</font></a>
                </div>
                

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="../css/css.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript"> var registertime="2011-12-25"; </script>
	<script src="../js/index.js"></script>
	<script src="../js/My97DatePickerBeta/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="../js/jquery.dataTables.js"></script>
	<script src="../js/jquery.select-1.3.6.js"></script>
	<script>
		var productid,clickflag=0,todaytime;
		$(document).ready(function(){
			var tmptimeflag=30;
			if(tmptimeflag==0){
				document.getElementById("start").innerHTML=getToday();
				document.getElementById("middle").innerHTML="";
				document.getElementById("end").innerHTML="";
			}else if(tmptimeflag==1){
				document.getElementById("start").innerHTML=getDateAgo(1);
				document.getElementById("middle").innerHTML="";
				document.getElementById("end").innerHTML="";
			}else if(tmptimeflag==7){
				document.getElementById("middle").innerHTML="~";
				document.getElementById("start").innerHTML=getDateAgo(7);
				document.getElementById("end").innerHTML=getToday();
			}else if(tmptimeflag==30){
				document.getElementById("middle").innerHTML="~";
				document.getElementById("start").innerHTML=getDateAgo(30);
				document.getElementById("end").innerHTML=getToday();
			}else if(tmptimeflag==99){
				document.getElementById("middle").innerHTML="~";
				if(registertime){
						var diff=DateDiff(getToday(),registertime,365);
						if(diff==false){
							document.getElementById("start").innerHTML=getDateAgo(365);
						}else{
							document.getElementById("start").innerHTML=strTOStr(registertime);
						}
				}else{
						document.getElementById("start").innerHTML=getDateAgo(365);
				}
				document.getElementById("end").innerHTML=getToday();
			}else if(tmptimeflag==6){
				document.getElementById("middle").innerHTML="~";
				document.getElementById("start").innerHTML="null";
				document.getElementById("end").innerHTML="null";
			} 			
			todaytime=document.getElementById("end").innerHTML;
		}); 
		
		function saveTime(vtf){
			var starttime = document.getElementById("start").innerHTML;
			var endtime = document.getElementById("end").innerHTML;
			var url=basePath+'servlet/TenddataSaveServlet';
			vtimecc=Math.random();
			var params = {
		         starttime:starttime,
				 endtime:endtime,
				 timeflag:vtimeflag,
		         timecc:vtimecc
			};
			$.getJSON(url,params,callback);
		}
		
		function callback(){
		}
		
		function searchTimeFlag(vtf){
			vlineName="不对比";
			vdayStartUp="不对比";
			var obj=document.getElementById("contraststarttime");
			if(obj!=null&&obj!=""){
				document.getElementById("contraststarttime").innerHTML="";
				document.getElementById("contrastmiddle").innerHTML="请选择日期";
				document.getElementById("contrastendtime").innerHTML="";
			}
			var obj2=document.getElementById("contraststarttimeSec");
			if(obj2!=null&&obj2!=""){
				document.getElementById("contraststarttimeSec").innerHTML="";
				document.getElementById("contrastmiddleSec").innerHTML="请选择日期";
				document.getElementById("contrastendtimeSec").innerHTML="";
			}
			if(vtf!=6){
				document.getElementById("middle").innerHTML="~";
			    document.getElementById("end").innerHTML=getToday();
				if(vtf==0){
					document.getElementById("start").innerHTML=getToday();
					document.getElementById("middle").innerHTML="";
					document.getElementById("end").innerHTML="";
				}else if(vtf==1){
					document.getElementById("start").innerHTML=getDateAgo(1);
					document.getElementById("middle").innerHTML="";
					document.getElementById("end").innerHTML="";
				}else if(vtf==7){
					document.getElementById("start").innerHTML=getDateAgo(7);
				}else if(vtf==30){
					document.getElementById("start").innerHTML=getDateAgo(30);
				}else if(vtf==99){
					if(registertime!=null&&registertime!=""){
						var diff=DateDiff(getToday(),registertime,365);
						if(diff==false){
							document.getElementById("start").innerHTML=getDateAgo(365);
						}else{
							document.getElementById("start").innerHTML=strTOStr(registertime);
						}
					}else{
						document.getElementById("start").innerHTML=getDateAgo(365);
					}
				}
				document.getElementById("datamessage").style.display="none";
				
				timet('time','timecolse');
				document.getElementById("startTime").value="";
				document.getElementById("endTime").value="";
				verify(vtf);
			}else{
				var s=document.getElementById("startTime").value;
				var e=document.getElementById("endTime").value;
				if(s==null||s==""||e==null||e==""){
					document.getElementById("datamessage").style.display="block";
				}else{
					document.getElementById("start").innerHTML=s;
					document.getElementById("end").innerHTML=e;
					document.getElementById("datamessage").style.display="none";
					var diff=DateDiff(e,s,365);
					if(diff==false){
						verify(99);
					}else{
						timet('time','timecolse');
						verify(vtf);
					}
				}
			}
			saveTime(vtf);
		}
		
		function selectMonthf(){
			document.getElementById("middle").innerHTML="~";
			var date = new Date();
			var tmpval=$("#selectMonth").val();
			var strYear = tmpval.split('-')[0];
			var month=tmpval.split('-')[1];
			var daysInMonth = new Array([0],[31],[28],[31],[30],[31],[30],[31],[31],[30],[31],[30],[31]);
			if(parseInt(strYear)%4 == 0 && parseInt(strYear)%100 != 0){   
		        daysInMonth[2] = 29;   
		    }   
		    if(parseInt(month)==-1){
				month=1;
		    }
		    var endday=daysInMonth[month];
		    var startvalue=strYear+"-"+month+"-01";
		    var endvalue=strYear+"-"+month+"-"+endday;
		    document.getElementById("start").innerHTML=startvalue;
			document.getElementById("end").innerHTML=endvalue;
			starttime=startvalue;
			endtime=endvalue;
			document.getElementById("datamessage").style.display="none";
			timet('time','timecolse');
			verify(6);
		}
		
		
		function getMonths(){
			if(clickflag==0){
				document.getElementById("selectMonth").options.length = 0;
				var url=basePath+"servlet/ProductServlet";
				var timecc=Math.random();
				var params={
					servertype:7,
					timecc:timecc
				}
				$.get(url,params,callBackMonths);
			}
			
		}
		
		function callBackMonths(data){
			if(data!=null&&data!=""){
				var array=data.split(",");
				for(var i=0;i<array.length;i++){
					$("#selectMonth").append("<option value='"+array[i]+"' id='"+array[i]+"'>"+array[i].split('-')[1]+"月</option>");
				}
				clickflag=clickflag+1;
			}
		}
		
		function closeWin(){
			document.getElementById("datamessage").style.display="none";
		}
		
		function refresh(data){
				registertime=data;
			}
	</script>
</head>
<body>
	<div class="relative l" style="z-index:99">
    	<a class="time" href="javascript:void(0);" onclick="timet('time','timecolse');closeWin();"><span><font id="start"></font><font id="middle" style="margin:0 5px;">请选择日期</font><font id="end"></font></span></a>
        <div class="timetxt" id="time" style="width:300px; left:0">
        	<span>
        		<a href="javascript:void(0)" id="aid1" onclick="searchTimeFlag(0);" style="margin-left:0px">今日</a>|<a href="javascript:void(0)" id="aid2" onclick="searchTimeFlag(1);">昨日</a>|<a href="javascript:void(0)" id="aid3" class="on_choose" onclick="searchTimeFlag(7);">近7日</a>|<a href="javascript:void(0)" id="aid4" onclick="searchTimeFlag(30);">近30日</a> | 
				<select id="selectMonth"  onchange="selectMonthf();">
					<option value="-1" disabled="true">月份</option>
				</select> |  
				<a href="javascript:void(0)" id="aid5" onclick="searchTimeFlag(99);">全部</a> </span>

            <p>自定<input type="text" id="startTime" name="startTime" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-M-dd',minDate:'2011-12-25',maxDate:'#F{$dp.$D(\'endTime\')||\'%y-%M-%d\'}'})"/>
			到<input type="text" id="endTime" name="endTime"class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-M-dd',minDate:'#F{$dp.$D(\'startTime\')||\'2011-12-25\'}',maxDate:'%y-%M-%d'})"/></p>
            <span style="display:block"><small id="datamessage" style="display: none; margin-left: 30px;" class="l">日期不能为空</small><a href="#"class="timecolse r" onclick="closeWin();"><img src="../images/no.jpg" width="14" height="12" /></a><a href="javascript:void(0);"  onclick="searchTimeFlag(6);" id="aidyes" class="r"><img src="../images/yes.jpg" width="16" height="12" /></a> </span>
		</div>
    </div>
</body>
</html>

				 <!--筛选框-->
		   			

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script src="../js/index.js"></script>
	<script src="../js/jquery.select-1.3.6.js"></script>
	<script type="text/javascript"> var basePath="http://tongji.gfan.com:80/"; </script>
	<script>
		var versions="";
		var partners="";
		var allversions="";
		var partnerNames="";
	
		function selectChose(){
			$("#version").html('');
			$("#partner").html('');
			versions="";
			partners="";
			partnerNames="";
			if(versions!=""&&partners!=""){
				document.getElementById("showVersion").style.display="block";
				var tmppartnerNames=setNameFont(partnerNames);
				var tmpversions=setNameFont(versions);
				$("#selectVersion").html("<font>版本：</font>"+tmpversions+"<br/><font>渠道：</font>"+tmppartnerNames);     
			}else if(versions!=""&&partners==""){
				document.getElementById("showVersion").style.display="block";
				var tmpversions=setNameFont(versions);
				$("#selectVersion").html("<font>版本：</font>"+tmpversions);     
			}else if(versions==""&&partners!=""){
				document.getElementById("showVersion").style.display="block";
				var tmppartnerNames="";
				tmppartnerNames=setNameFont(partnerNames);
				$("#selectVersion").html("<font>渠道：</font>"+tmppartnerNames);     
			}else{
				document.getElementById("showVersion").style.display="none";
			}
			
			choseVersion();
			chosePartner();
			
		}
		
		function setNameFont(str){
			var tmppartnerNames="";
				
			if(str){
				var tmpinfo=str.split(",");
				for(var i=0;i<tmpinfo.length;i++){
					tmppartnerNames=tmppartnerNames+"<font>"+tmpinfo[i]+"</font>";
				}
			}
			return tmppartnerNames;
		}
		
		//获取版本列表
		function choseVersion(){
			var checkValue=$("#productTxt").val();
			var checkpValue=$("#productList").val();
			var url=basePath+'servlet/TenddataChoseVersionServlet';
			var vtimecc=Math.random();
			var params = {
				 productid:checkValue,
        		 platformid:checkpValue,
				serviceCode:"9996",
				timecc:vtimecc
			};
			$.getJSON(url,params,setVersions);
		}
		
		function setVersions(data){
			var versionarray=data.data9996;
			for(var i=0;i<versionarray.length;i++){
				$("#version").append('<a href="javascript:void(0);" id="'+versionarray[i].value+'" onclick="changeVersionStyle(\''+versionarray[i].value+'\')">'+versionarray[i].value+'</a>');
				allversions=allversions+versionarray[i].value+",";
			}
			if(allversions!=null&&allversions!=""){
				allversions=allversions.substring(0,allversions.length-1);
			}
			
			if(versions!=""){
				var tmpversions=versions.split(',');
				if(tmpversions){
					for(var k=0;k<tmpversions.length;k++){
						if(tmpversions[k]){
							changeVersionStyle(tmpversions[k]);
						}
					}
				} 
			}
		}
		//选择版本时改变样式
		function changeVersionStyle(version){
			if(document.getElementById(version).className=="border"){
				document.getElementById(version).className="";
			}else{
				document.getElementById(version).className="border";
			}
			document.getElementById("yorversion").className="r";
		}
		//获取渠道列表
		function chosePartner(){
			var checkValue=$("#productTxt").val();
			var checkpValue=$("#productList").val();
			var url=basePath+'servlet/TenddataChosePartnerServlet';
			var vtimecc=Math.random();
			var params = {
				productid:checkValue,
        		platformid:checkpValue,
				serviceCode:"9995",
				timecc:vtimecc
			};
			$.getJSON(url,params,setPartners);
		}
		
		function setPartners(data){
			var partnerArray=data.data9995;
			for(var i=0;i<partnerArray.length;i++){
				$("#partner").append('<a href="javascript:void(0);" id="'+partnerArray[i].key+'"onclick="changePartnerStyle(\''+partnerArray[i].key+'\')">'+partnerArray[i].value+'</a>');
			}
			
			if(partners!=""){
				var tmppartners=partners.split(',');
				if(tmppartners){
					for(var k=0;k<tmppartners.length;k++){
						if(tmppartners[k]){
							changeVersionStyle(tmppartners[k]);
						}
					}
				} 
			}
		}
		//选择渠道时候改变样式
		function changePartnerStyle(partner){
			if(document.getElementById(partner).className=="border"){
				document.getElementById(partner).className="";
			}else{
				document.getElementById(partner).className="border";
			}
			document.getElementById("yorpartner").className="r";
		}
		//是否选择筛选
		function yorchose(id){
			if(id==1){
				$("#yorversion").addClass("brde");
				$("#version a").removeClass("border");
			}else{
				$("#yorpartner").addClass("brde");
				$("#partner a").removeClass("border");
			}
		}
		//选择钩时，获取版本号、渠道号
		function commitVersionPartner(){
			versions="";
			partners="";
			partnerNames="";
			var tagversion = document.getElementById("version").getElementsByTagName("a");
			for(i=0; i<tagversion.length; i++){
				if(tagversion[i].className =="border"){
					versions=versions+tagversion[i].id+",";
				}
			}
			var tagpartner = document.getElementById("partner").getElementsByTagName("a");
			for(i=0; i<tagpartner.length; i++){
				if(tagpartner[i].className =="border"){
					partners=partners+tagpartner[i].id+",";
					partnerNames=partnerNames+tagpartner[i].innerHTML+",";
				}
			}
			if(versions!=null&&versions!=""){
				versions=versions.substring(0,versions.length-1);
			}
			if(partners!=null&&partners!=""){
				partners=partners.substring(0,partners.length-1);
				partnerNames=partnerNames.substring(0,partnerNames.length-1);
			}
			
			if(versions!=""&&partners!=""){
				document.getElementById("showVersion").style.display="block";
				var tmppartnerNames=setNameFont(partnerNames);
				var tmpversions=setNameFont(versions);
				$("#selectVersion").html("<font>版本：</font>"+tmpversions+"<br/><font>渠道：</font>"+tmppartnerNames);     
			}else if(versions!=""&&partners==""){
				document.getElementById("showVersion").style.display="block";
				var tmpversions=setNameFont(versions);
				$("#selectVersion").html("<font>版本：</font>"+tmpversions);     
			}else if(versions==""&&partners!=""){
				document.getElementById("showVersion").style.display="block";
				var tmppartnerNames="";
				tmppartnerNames=setNameFont(partnerNames);
				$("#selectVersion").html("<font>渠道：</font>"+tmppartnerNames);     
			}else{
				document.getElementById("showVersion").style.display="none";
			}
			saveInfo();
			chose();
		}
		
		function noVersionPartner(){
			if(document.getElementById("showVersion").style.display=="none"){
				$("#version a").removeClass("border");
				$("#partner a").removeClass("border");
			}
		}
		
		function saveInfo(){
			var url=basePath+'servlet/TenddataSaveChoseServlet';
			vtimecc=Math.random();
			//alert(partnerNames);
			var params = {
		         versions:versions,
				 partners:partners,
				 partnerNames:partnerNames,
		         timecc:vtimecc
			};
			$.getJSON(url,params,callback);
		}
		
		function callback(){
			
		}
		
	</script>
</head>
<body>
	 <div class="relative r" style=" z-index:99">
                <a class="time" href="javascript:void(0);" onclick="timet('Sieve','Sievecolse');"><span class="timenews"><div class="timenews"><font id="start"></font><font id="middle" style="margin:0 5px;">筛选</font><font id="end"></font></div></span></a>
                <div class="timetxt" id="Sieve" style="width:300px; right:0">
                	<div class="brdediv"><font class="l">版本：</font><a href="javascript:void(0);" id="yorversion" onclick="yorchose(1)"class="r">不筛选</a> <div class="clear"></div></div>
                    <div id="version" class="Sievexx">
                    	
                    </div>
                    <div class="brdediv"><font class="l">渠道：</font><a href="javascript:void(0);" id="yorpartner" onclick="yorchose(2);" class="r">不筛选</a> <div class="clear"></div></div>
                    <div id="partner" class="Sievexx">
                    	
                    </div>
                	<span style="display:block"><small id="datamessage" style="display: none; margin-left: 30px;" class="l">日期不能为空</small><a href="javascript:void(0);" onclick="noVersionPartner();"class="Sievecolse r"><img src="../images/no.jpg" width="14" height="12" /></a> <a href="javascript:void(0)" onclick="commitVersionPartner();"  class="Sievecolse r"><img src="../images/yes.jpg" width="16" height="12" /></a></span>  
                </div>
    </div>
    
			<div class="clear"></div>
			<!--删选出的版本展示框-->
			<div id="showVersion" class="sx" style="display:none">
            <span class="sxtop"></span>
            <div id="selectVersion"></div>
            <span><font></font></span>
            </div>
</body>
</html>

            </div>
        	<div class="title">
            	<strong class="l">TOP10省市分布</strong>
                <span class="r">
                  <!--对比功能-->
					

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="../css/css.css" rel="stylesheet" type="text/css" />
	<script>
		function tagsLine(str){
			vlineName=str;
			document.getElementById("datamessage2").style.display="none";
			if(str!="不对比"){
				var datestart=document.getElementById("start").innerHTML;
				document.getElementById("contrastmiddle").innerHTML="~";
				document.getElementById("contrastendtime").innerHTML=getToday();
				var contrastStartTime;
				if(str=="前一天"){
					contrastStartTime=getDateAgo2(datestart,1);
				}else if(str=="上周同期"){
					contrastStartTime=getDateAgo2(datestart,7);
				}else if(str=="上月同期"){
					contrastStartTime=getDateAgo2(datestart,30);
				}else if(str=="自定义"){
					var tmptime=document.getElementById("contrasttime").value;
					if(tmptime==null||tmptime==""){
						document.getElementById("datamessage2").style.display="block";
					}else{
						document.getElementById("datamessage2").style.display="none";
						contrastStartTime=tmptime;
					}
				}
				var datediff=30;
				switch(vtimeflag){
					case 0:
						datediff=0;
						break;
					case 1:
						datediff=0;
						break;
					case 7:
						datediff=7;
						break;
					case 30:
						datediff=30;
						break;
					case 99:
						datediff=365;
						break;
					case 6:
						var starttime = document.getElementById("start").innerHTML;
						var endtime = document.getElementById("end").innerHTML;
						var cdy=DateDifflong(endtime,starttime);
						datediff=cdy;
						break;
				}
				
				if(document.getElementById("datamessage2").style.display=="block"){
					document.getElementById("contraststarttime").innerHTML="";
					document.getElementById("contrastmiddle").innerHTML="请选择日期";
					document.getElementById("contrastendtime").innerHTML="";
				}else{
					var contrastEndTime=getContrastEndTime(contrastStartTime,datediff);
					document.getElementById("contraststarttime").innerHTML=contrastStartTime;
					document.getElementById("contrastendtime").innerHTML=contrastEndTime;
					timet('time2','timecolse2');
					setDIYContrastLine(contrastStartTime,contrastEndTime);
				}
			}else{
				document.getElementById("contraststarttime").innerHTML="";
				document.getElementById("contrastmiddle").innerHTML="请选择日期";
				document.getElementById("contrastendtime").innerHTML="";
				timet('time2','timecolse2');
				setLine(vlistKey);
			}
		}
		
		function closeWin(){
			document.getElementById("datamessage2").style.display="none";
		}
	</script>
</head>
<body>
            <div class="relative r" style="z-index:98">
		    	<a class="time" href="javascript:void(0);" onclick="timet('time2','timecolse2');">
		    		<span>
		    			<font id="contraststarttime" style="color:#666"></font>
						<font id="contrastmiddle" style="margin:0 5px; font-size:12px; color:#666">请选择日期</font>
						<font id="contrastendtime" style="color:#666"></font>
					</span>
				</a>
		        <div class="timetxt" id="time2" style="width:200px; right:0; top:31px">
		        	<span>
				    	<!--<a  href="javascript:void(0);" onclick="tagsLine('前一天')">上一天</a> 
						|--> <div class="l"><a href="javascript:void(0);" onclick="tagsLine('上周同期')">上周</a> 
						| <a href="javascript:void(0);" onclick="tagsLine('上月同期')">上月</a>
						| <a href="javascript:void(0);" onclick="tagsLine('不对比')">不对比</a></div>
                        <font class="relative r" style="top:5px"><a onClick="sever('serverhelp1','serverhelpcl1');" href="javascript:void(0)"><img width="11" height="13" src="../images/wenhao.jpg"/></a>
                         <div class="server" id="serverhelp1" style="width:420px; top:15px; right:-10px;">
                       <div class="ser_title">
                           <b class="l" style=" line-height:38px;">对比说明</b>
                           <a class="r" id="serverhelpcl1" href="#this"><img src="../images/server_close.gif" /></a>
                       </div>
                       <div class="ser_txt">
                           <dl>
                               <dt style="height:45px">
                               	时段对比提供对同一项指标在不同日期段内数据表现做对比的功能。您可以自由选择对比数据的起始日，系统会自动按照被对比数据的日期周期来选择同样长的一个时间段做数据对比，从而保证可比性。
                               </dt>
                               <dd>
                               	<font style="width:30px">上周</font><small>以被对比数据起始日的上周同期作为起始日做对比。</small>
                                </dd>
                               <dt>
                               	<font style="width:30px">上月</font><small>以被对比数据起始日的上月同日作为起始日做对比。</small>
                                                               </dt>
                           </dl>
                       </div>
                	</div></font>
				    </span>
				    <p>自定对比起始日<input type="text" id="contrasttime" name="contrasttime" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-M-dd',minDate:'2011-12-25',maxDate:'#F{$dp.$D(\'endTime\')||\'%y-%M-%d\'}'})"/></p>
				    <span style="display:block">
				    	<small class="l" style="display: none; margin-left: 30px;" id="datamessage2">日期不能为空</small>
				        <a onClick="closeWin();" class="timecolse2 r" href="javascript:void(0)"><img width="14" height="12" src="../images/no.jpg"/></a>
				        <a class="r" id="aidyes" onClick="tagsLine('自定义');" href="javascript:void(0);"><img width="16" height="12" src="../images/yes.jpg"/></a>
				    </span>
				</div>
		    </div>
            <div class="r selectlble">对比时段：</div>
</body>
</html>

                </span>
				
       	  </div>
            <div class="textbox">
            <ul class="bottunDiv" id="tags">
                	<li class="hover"><a href="javascript:void(0);" class="bottun3" onClick="selectTag('tagContent0',this,0)">新增用户</a></li>
                    <li><a href="javascript:void(0);" class="bottun" onClick="selectTag('tagContent1',this,1)"><font>活跃用户</font></a></li>
					<li><a href="javascript:void(0);" class="bottun2" onClick="selectTag('tagContent2',this,2)"><font>启动次数</font></a></li>
              </ul>
                <div class="table" id="tagContent0">
                	<div id="000102" style="width:100%; height:400px;">
                	<div class="login">
							<img src="../images/loading.gif" height="25px"></img>
							<br>
							正在加载统计数据...
						</div>
                	</div>
                </div>
                
                <div class="table displaynone" id="tagContent1">
                	<div id="000205" style="width:100%; height:400px;">
                	<div class="login">
							<img src="../images/loading.gif" height="25px"></img>
							<br>
							正在加载统计数据...
							</br>
						</div>
                	</div>
                </div>
				
				  <div class="table displaynone" id="tagContent2">
                	<div id="000302" style="width:100%; height:400px;">
                	<div class="login">
							<img src="../images/loading.gif" height="25px"></img>
							<br>
							正在加载统计数据...
							</br>
						</div>
                	</div>
                </div>
            </div>
        </div>
		
		<div class="box">
        	<div class="contentbox l">
            	<div class="title">
            		<strong class="l">国际化</strong>
        			<span class="r"></span>
              </div>
                <div class="textbox">
                	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_style2">
  						<tr>
  							<td class="left border_none">国际用户比例</td>
  							<td class="center border_none"><strong id=105112></strong></td>
  						</tr>
  					</table>
                </div>
            </div>
            <div class="contentbox r">
            	<div class="title">
            		<strong class="l">5大省市占比</strong>
                	<span class="r"></span>
       		  </div>
                <div class="textbox">
                	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_style2">
  						<tr>
  							<td class="left border_none">TOP5省市用户</td>
  							<td class="center border_none"><strong id=101112></strong></td>
  						</tr>
  					</table>
                </div>
            </div>
            <div class="clear"></div>
        </div>
        
    <div class="boxmax">
        	<div class="title">
            	<strong class="l">省市明细</strong>
                <span class="relative r">
                	<a href="javascript:void(0)" class="bottun4 hover" onclick="exportInfoExcel();"><font>导出Excel</font></a>
                    <a href="javascript:void(0)" class="bottun4" onclick="sever('server1','server1cl');"><font>?</font></a>
                	<div class="server" id="server1" style="width:420px;">
                       <div class="ser_title">
                           <b class="l">数据指标说明</b>
                           <a class="r" id="server1cl" href="#this"><img src="../images/server_close.gif" /></a>
                       </div>
                       
                                <style>
								.ser_txt font{
									width:90px
								}
								</style>
                       <div class="ser_txt">
                           <dl>
                               <dt>
                               	<font>新增用户</font><small>来自该地区的新增加应用使用者。</small>                               </dt>
                               <dd>
                               	<font>启动次数</font><small>来自该地区的用户对应用使用的次数。</small>
                                </dd>
                               <dt>
                               	<font>用户比例</font><small>来自这个地区的用户占全部用户的比例。</small>                               </dt>
                               <dd>
                               	<font>国际用户比例</font><small>在选定时间内有使用应用的用户。</small>
                                </dd>
                               <dt>
                               	<font>Top5省市用户</font><small>前5大用户省市地区占全部用户量的比例。</small>
                                                               </dt>
                           </dl>
                       </div>
                	</div>
                </span>
   	  		</div>
               <div id="0420" class="dynamic">
               <div class="textbox">
               <div class="login">
							<img src="../images/loading.gif" height="25px"></img>
							<br>
							正在加载统计数据...
							</br>
						</div></div>
               </div>
    </div>
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
</body>