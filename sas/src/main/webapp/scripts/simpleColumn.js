var chart;
var match,time,type="新增应用";

AmCharts.ready(function () {
	initChart(type);
});

function initChart(tag){
	
    $("#chartdiv").html("");
	
	// SERIAL CHART
    chart = new AmCharts.AmSerialChart();
    chart.dataProvider = chartData;
    chart.categoryField = "country";
    chart.startDuration = 1;
	
    // AXES
    // category
    var categoryAxis = chart.categoryAxis;
    categoryAxis.gridPosition = "start";

    // GRAPH
    var graph = new AmCharts.AmGraph();
    graph.valueField = "visits";
    graph.balloonText = "[[category]]--"+tag+": [[value]]";
    graph.type = "line";
    graph.lineAlpha = 1;
    graph.fillAlphas = 0.3;
    graph.fillColors = "#0D2B54"
	graph.bullet = "round";
    graph.bulletSize = 5;
    graph.lineThickness = 2;
    chart.addGraph(graph);
    
    // CURSOR
    var chartCursor = new AmCharts.ChartCursor();
    chartCursor.cursorPosition = "mouse";
    chartCursor.categoryBalloonDateFormat = "JJ:NN, DD MMMM";
    chart.addChartCursor(chartCursor);
    
    chart.write("chartdiv");

}


function tagsLine(selfObj, str) {
	match = str;
	
	changeCSS(selfObj,"twoo");
	
	matchLine("新增应用",str);
}

function  tagLine(showContent, selfObj, linekey) {
	time = linekey;
	changeCSS(selfObj,"twooLine");
	
	$("#chartdiv").html("");
	initChart(type);
}

function tagsChType(selfObj, flag,linekey) {
	type=flag;
	
	changeCSS(selfObj,"twooChType");
	
	$("#chartdiv").html("");

	initChart(type);
}

/**
 * tag:
 */
function matchLine(tag,str){
	$("#chartdiv").html("");
	
	// SERIAL CHART
    chart = new AmCharts.AmSerialChart();
    chart.dataProvider = chartData;
    chart.categoryField = "country";
    chart.startDuration = 1;
	
    // AXES
    // category
    var categoryAxis = chart.categoryAxis;
    categoryAxis.gridPosition = "start";

    // GRAPH
    var graph = new AmCharts.AmGraph();
    graph.valueField = "visits";
    graph.balloonText = "[[category]]--"+tag+": [[value]]";
    graph.type = "line";
    graph.lineAlpha = 1;
    graph.fillAlphas = 0.3;
    graph.fillColors = "#0D2B54"
	graph.bullet = "round";
    graph.bulletSize = 5;
    graph.lineThickness = 2;
    chart.addGraph(graph);
    
    // CURSOR
    var chartCursor = new AmCharts.ChartCursor();
    chartCursor.cursorPosition = "mouse";
    chartCursor.categoryBalloonDateFormat = "JJ:NN, DD MMMM";
    chart.addChartCursor(chartCursor);
	
    // GRAPH
    var graph2 = new AmCharts.AmGraph();
	graph2.type = "line";
    graph2.title = str;
    graph2.valueField = "average";
    graph2.lineThickness = 2;
    graph2.bullet = "round";
    graph.bulletSize = 5;
    graph2.balloonText = "[[category]]--"+str+": [[value]]";
    graph2.lineAlpha = 1;
    graph2.lineColor = "#d1cf2a";
    graph2.fillAlphas = 0.3; 
    graph2.lineThickness = 2;
    chart.addGraph(graph2);
    
    
    chart.write("chartdiv");
}