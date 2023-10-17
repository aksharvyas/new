import 'package:admin/responsive.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../controllers/MenuAppController.dart';
import '../../models/deviceInfo.dart';

import 'components/header.dart';
import 'package:flutter_svg/svg.dart';
import 'components/recent_files.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool? a;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(2010, 35),
      ChartData(2011, 28),
      ChartData(2012, 34),
      ChartData(2013, 32),
      ChartData(2014, 40)
    ];
    List<DeviceInfo> demoInfo = [
      DeviceInfo(name: "Total Requestes", activeNo: null),
      DeviceInfo(name: "Today Active Users", activeNo: null),
      DeviceInfo(name: "Today Active Devices", activeNo: null),
      DeviceInfo(name: "Total Device Configured", activeNo: null),
    ];
    final GlobalKey<ScaffoldState> sc = GlobalKey<ScaffoldState>();

    return SafeArea(
        child: Scaffold(
      drawer: SideMenu(),
      key: sc,
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    sc.currentState!.openDrawer();
                  },
                ),
                Text(
                  "DEVICE INFO",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: defaultPadding),
                    ListView.builder(
                      // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      //     maxCrossAxisExtent: 200,
                      //     childAspectRatio: 1.5,
                      //     crossAxisSpacing: 10,
                      //     mainAxisSpacing: 10),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: demoInfo.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        // width:
                                        //     MediaQuery.of(context).size.width *
                                        //         0.4,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            demoInfo[index].name!,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        demoInfo[index].activeNo == null
                                            ? "987654"
                                            : demoInfo[index]
                                                .activeNo
                                                .toString(),
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ACTIVE USERS",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    lineChart(chartData),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "DAILY ACTIVE DEVICES",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    lineChart(chartData)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

Widget lineChart(List<ChartData> dataSource)

{
  return Container(
      width: double.infinity,
      child: SfCartesianChart(series: <ChartSeries>[

        LineSeries<ChartData, int>(
            dataSource: dataSource,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y)
      ]));
}

class ChartData {
  ChartData(this.x, this.y);
  int x;
  double y;
}
