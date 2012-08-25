$(function(){
	$("#0104").html(initTable());
});

function  initTable(){
	var context;
	context = '<table cellpadding="0px" cellspacing="0px" width="100%" height="100%" border="0" id="gridSummarizeBean" class="table_style1"><thead><tr>';
	
	for(var i=0;i<titleData.length;i++){
		context+='<th rowspan="1" colspan="1" style="width: 75px;">'
		context+='<div class="tdtxtwidth" style="width: 100px; min-width: 24px;" title="'+titleData[i]+'">'+titleData[i]+'</div>'
		context+='</th>'
	}
	context+='</tr></thead><tbody>';
	for(var a=0;a<viewData.length;a++){
		var view = viewData[a];
		var isOdd = a % 2;
		var odd;
		if(isOdd == 0){
			odd = "even";
		}else{
			odd = "odd";
		}
		context+='<tr id="gridSummarizeBeantr0" class="'+odd+' " onmouseover="changeTableCss(this,1)" onmouseout="changeTableCss(this,0)">';
		for(var b = 0;b<view.length;b++){
			context+='<td  style="width: 75px;">'+view[b]+'</td>';
		}
		context+='</tr>'
	}
	context+='</tbody></table>';
	
	return context;
	

}

function changeTableCss(obj,flag){
	if(flag==1){
		if(obj.className.trim() == "odd"){
			obj.className = "odd bgbulle";
		}else{
			obj.className = "even bgbulle";
		}
	}else{
		if(obj.className.trim() == "odd bgbulle" ){
			obj.className = "odd";
		}else{
			obj.className = "even";
		}
	}
}
