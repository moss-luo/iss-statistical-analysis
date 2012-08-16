var chart;

            var chartData = [{
                country: "01:00",
                visits: 4025
            }, {
                country: "02:00",
                visits: 2882
            }, {
                country: "03:00",
                visits: 4809
            }, {
                country: "04:00",
                visits: 3322
            }, {
                country: "05:00",
                visits: 5122
            }, {
                country: "06:00",
                visits: 3114
            }, {
                country: "07:00",
                visits: 2984
            }, {
                country: "08:00",
                visits: 5711
            }, {
                country: "09:00",
                visits: 1665
            }, {
                country: "10:00",
                visits: 3580
            }, {
                country: "11:00",
                visits: 4443
            }, {
                country: "12:00",
                visits: 2441
            }, {
                country: "13:00",
                visits: 1395
            }, {
                country: "14:00",
                visits: 3386
            }, {
                country: "15:00",
                visits: 2384
            }, {
                country: "16:00",
                visits: 3338
            }, {
                country: "17:00",
                visits: 2984
            }, {
                country: "18:00",
                visits: 5711
            }, {
                country: "19:00",
                visits: 1665
            }, {
                country: "20:00",
                visits: 3580
            }, {
                country: "21:00",
                visits: 4443
            }, {
                country: "22:00",
                visits: 2441
            }, {
                country: "23:00",
                visits: 1395
            }];


            AmCharts.ready(function () {
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
                graph.balloonText = "[[category]]--新增用户: [[value]]";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 0.8;
                graph.fillColors = "#0D2B54"
                chart.addGraph(graph);

                chart.write("chartdiv");
            });