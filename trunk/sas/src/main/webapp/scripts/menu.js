var prevContext,prevId="Summarize";
function menu(e,mid,mcol){
	var menuaid=jQuery(e).attr("id");
	var menudisplay=$('#'+mid).parent().children("ol").css("display");
	var menuoldisplay=$('#'+mcol).parent().children("ol").css("display");
	if(mid===menuaid){
		jQuery(e).attr("id",mcol);
		if(menudisplay==="block"){
			$("#"+mid+"ol").slideUp();
		}else{
			$("#"+mid+"ol").slideDown();
		}
	}else{
		jQuery(e).attr("id",mid);
		if(menuoldisplay==="block"){
			$("#"+mid+"ol").slideUp();
		}else{
			$("#"+mid+"ol").slideDown();
		}
	}
}
//菜单切换
function switchMenu(obj,url){
	$("#context")[0].src=url;
}

	