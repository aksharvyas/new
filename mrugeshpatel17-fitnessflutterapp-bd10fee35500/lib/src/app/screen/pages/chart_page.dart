import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<LiveData> chartData = [
    LiveData('', 0),
    LiveData('', 0),
    LiveData('', 0),
    LiveData('', 0),
    // LiveData('', 54),
    // LiveData('', 41),
    // LiveData('', 58),
    // LiveData('', 51),
    // LiveData(8, 98),
    // LiveData(9, 41),
    // LiveData(10, 53),
    // LiveData(11, 72),
    // LiveData(12, 86),
    // LiveData(13, 52),
    // LiveData(14, 94),
    // LiveData(15, 92),
    // LiveData(16, 86),
    // LiveData(17, 72),
    // LiveData(18, 94)
  ];
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {


    // chartData = getChartData();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body:            SfCartesianChart(

                series: <LineSeries<LiveData, String >>[
          LineSeries<LiveData, String>(
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            dataSource: chartData,
            color: const Color.fromRGBO(192, 108, 132, 1),
            xValueMapper: (LiveData sales, _) => sales.time,
             yValueMapper: (LiveData sales, _) => sales.speed,
          ),

        ],

                primaryXAxis: CategoryAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 1,
                    title: AxisTitle(text: 'Time (seconds)')),
                primaryYAxis: NumericAxis(
                    axisLine: AxisLine(width: 0),
                    majorTickLines: MajorTickLines(size: 0),
                    title: AxisTitle(text: 'Internet speed (Mbps)')))));
  }


  void updateDataSource(Timer timer) async{


    chartData.add((LiveData(DateFormat('kk:mm:ss').format(DateTime.now()), (math.Random().nextInt(60) + 30))));

    if(chartData.length!=0 || chartData.length!=1 ) {

      chartData.removeAt(0);
    }
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);

    print("chartdata" + jsonEncode(chartData));
    setState(() {

    });
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final String time;
  final int speed;
  Map toJson() => {
        'time': time,
        'speed': speed,
      };
}
