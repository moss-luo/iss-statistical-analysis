function changeCSS(selfObj,id){
	// 操作标签
	var tag = document.getElementById(id).getElementsByTagName("li");
	var taglength = tag.length;
	for( i = 0; i < taglength; i++) {
		tag[i].className = "";
	}
	selfObj.parentNode.className = "hover";
}