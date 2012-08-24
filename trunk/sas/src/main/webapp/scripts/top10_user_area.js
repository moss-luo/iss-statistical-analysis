var chartType = "条形图";
$(function(){
	initChart(true,chartData);
});

function changeType(selfObj, str){
	$("#chartdiv").html("");
	changeCSS(selfObj,"twoo");
	
	chartType = str;
	
	if(chartType=="饼形图"){
		mackPie(chartData);
	}else if(chartType=="柱形图"){
		initChart(false,chartData);
	}else{
		initChart(true,chartData);
	}
	
}

function initChart(isHorizontal,data){
	
	// SERIAL CHART
	chart = new AmCharts.AmSerialChart();
	chart.dataProvider = data;
	chart.categoryField = "country";
	chart.startDuration = 1;
	chart.rotate = isHorizontal;  // the following two lines makes chart 3D
	// chart.depth3D = 20;
	// chart.angle = 30;
	
	// AXES
	// category
	var categoryAxis = chart.categoryAxis;
	categoryAxis.gridPosition = "start";
	
	// GRAPH
	var graph = new AmCharts.AmGraph();
	graph.fillColors = "#0D2B54"
	graph.valueField = "visits";
	graph.balloonText = "[[category]]: [[value]]";
	graph.type = "column";
	graph.lineAlpha = 0;
	graph.fillAlphas = 0.8;
	
	
	chart.addGraph(graph);
	
	chart.write("chartdiv");
	
}

function mackPie(data){
	// PIE CHART
    chart = new AmCharts.AmPieChart();

    chart.dataProvider = data;
    chart.titleField = "country";
    chart.valueField = "visits";
    chart.sequencedAnimation = true;
    chart.startEffect = "elastic";
    chart.innerRadius = "30%";
    chart.startDuration = 2;
    chart.labelRadius = 15;

    // the following two lines makes the chart 3D
    chart.depth3D = 10;
    chart.angle = 15;

    // WRITE                                 
    chart.write("chartdiv");
}

function selectTimeFlag(){
	//$('#1753').html('<div class="login"><img src="../images/loading.gif" height="25px"></img><br>正在加载统计数据...</div>');
	//timeflag=$("#date").val();

	$("#chartdiv").html("");
	
	if(chartType=="饼形图"){
		mackPie(chartData2);
	}else if(chartType=="柱形图"){
		initChart(false,chartData2);
	}else{
		initChart(true,chartData2);
	}
	

}