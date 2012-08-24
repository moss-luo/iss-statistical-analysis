$(function(){
	initChart("column",true);
});

function changeType(selfObj, str){
	$("#chartdiv").html("");
	changeCSS(selfObj,"twoo");
	
	if(str=="饼形图"){
		mackPie();
	}else if(str=="柱形图"){
		initChart("column",false);
	}else{
		initChart("column",true);
	}
	
}

function initChart(type,isHorizontal){
	
	// SERIAL CHART
	chart = new AmCharts.AmSerialChart();
	chart.dataProvider = chartData;
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
	graph.type = type;
	graph.lineAlpha = 0;
	graph.fillAlphas = 0.8;
	
	
	chart.addGraph(graph);
	
	chart.write("chartdiv");
	
}

function mackPie(){
	// PIE CHART
    chart = new AmCharts.AmPieChart();

    chart.dataProvider = chartData;
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