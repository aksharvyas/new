import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class BarChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

   List<BarChartGroupData>? rawBarGroups;
   List<BarChartGroupData>? showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 423, 10);
    final barGroup2 = makeGroupData(1, 430, 110);
    final barGroup3 = makeGroupData(2, 435, 30);
    final barGroup4 = makeGroupData(3, 385, 40);
    final barGroup5 = makeGroupData(4, 200, 50);
    final barGroup6 = makeGroupData(5, 290, 60);
    final barGroup7 = makeGroupData(6, 307, 80);
    final barGroup8 = makeGroupData(0, 423, 10);
    final barGroup9 = makeGroupData(1, 430, 110);
    final barGroup10 = makeGroupData(2, 435, 30);
    final barGroup11 = makeGroupData(2, 435, 30);
    final barGroup12 = makeGroupData(2, 435, 30);

    // final barGroup1 = makeGroupData(0, 100, 0);
    // final barGroup2 = makeGroupData(1, 200, 0);
    // final barGroup3 = makeGroupData(2, 100, 0);
    // final barGroup4 = makeGroupData(3, 10, 0);
    // final barGroup5 = makeGroupData(4, 200, 0);
    // final barGroup6 = makeGroupData(5, 290, 0);
    // final barGroup7 = makeGroupData(6, 150, 0);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      // barGroup7,
      // barGroup8,
      // barGroup9,
      // barGroup10,
      // barGroup11,
      // barGroup12,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisSize: MainAxisSize.min,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: <Widget>[
              //     makeTransactionsIcon(),
              //     const SizedBox(
              //       width: 38,
              //     ),
              //     const Text(
              //       'Transactions',
              //       style: TextStyle(color: Colors.white, fontSize: 22),
              //     ),
              //     const SizedBox(
              //       width: 4,
              //     ),
              //     const Text(
              //       'state',
              //       style: TextStyle(color: Color(0xff77839a), fontSize: 16),
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BarChart(
                    BarChartData(
                      maxY: 520,
                      barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.grey,
                            getTooltipItem: (_a, _b, _c, _d) => null,
                          ),
                          touchCallback: (response) {
                            if (response.spot == null) {
                              setState(() {
                                touchedGroupIndex = -1;
                                showingBarGroups = List.of(rawBarGroups!);
                              });
                              return;
                            }
                          },



                            ///
                            // if (response.spot == null) {
                            //   setState(() {
                            //     touchedGroupIndex = -1;
                            //     showingBarGroups = List.of(rawBarGroups);
                            //   });
                            //   return;
                            // }
                            //
                            // touchedGroupIndex = response.spot.touchedBarGroupIndex;
                            //
                            // setState(() {
                            //   if (response.touchInput is PointerExitEvent ||
                            //       response.touchInput is PointerUpEvent) {
                            //     touchedGroupIndex = -1;
                            //     showingBarGroups = List.of(rawBarGroups);
                            //   } else {
                            //     showingBarGroups = List.of(rawBarGroups);
                            //     if (touchedGroupIndex != -1) {
                            //       var sum = 0.0;
                            //       for (var rod in showingBarGroups[touchedGroupIndex].barRods) {
                            //         sum += rod.y;
                            //       }
                            //       final avg =
                            //           sum / showingBarGroups[touchedGroupIndex].barRods.length;
                            //
                            //       showingBarGroups[touchedGroupIndex] =
                            //           showingBarGroups[touchedGroupIndex].copyWith(
                            //             barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                            //               return rod.copyWith(y: avg);
                            //             }).toList(),
                            //           );
                            //     }
                            //   }
                            // });
                          ),
                      titlesData: FlTitlesData(
                          show: true,bottomTitles:

                      SideTitles( showTitles: false) ,
                        // bottomTitles: SideTitles(
                        //   showTitles: true,
                        //   getTextStyles: (value) => const TextStyle(
                        //       color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                        //   margin: 20,
                        //   getTitles: (double value) {
                        //     switch (value.toInt()) {
                        //       case 0:
                        //         return 'Mn';
                        //       case 1:
                        //         return 'Te';
                        //       case 2:
                        //         return 'Wd';
                        //       case 3:
                        //         return 'Tu';
                        //       case 4:
                        //         return 'Fr';
                        //       case 5:
                        //         return 'St';
                        //       case 6:
                        //         return 'Sn';
                        //       default:
                        //         return '';
                        //     }
                        //   },
                        // ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (context, value) => const TextStyle(
                              color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                          margin: 32,
                          reservedSize: 14,
                          getTitles: (value) {
                            if (value == 0) {
                              return '0';
                            } else if (value == 100) {
                              return '100';
                            } else if (value == 200) {
                              return '200';
                            }else if (value == 300) {
                              return '300';
                            }else if (value == 400) {
                              return '400';
                            }else if (value == 500) {
                              return '500';
                            } else {
                              return '';
                            }
                          },
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: showingBarGroups,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}


class BarChartSample3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 20,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                tooltipPadding: const EdgeInsets.all(0),
                tooltipMargin: 8,
                getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                    ) {
                  return BarTooltipItem(
                    rod.y.round().toString(),
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (context, value) => const TextStyle(
                    color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                margin: 20,
                getTitles: (double value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Mn';
                    case 1:
                      return 'Te';
                    case 2:
                      return 'Wd';
                    case 3:
                      return 'Tu';
                    case 4:
                      return 'Fr';
                    case 5:
                      return 'St';
                    case 6:
                      return 'Sn';
                    default:
                      return '';
                  }
                },
              ),
              leftTitles: SideTitles(showTitles: false),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(y: 8, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(y: 14, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(y: 15, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(y: 13, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class BarChartSample4 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample4State();
}

class BarChartSample4State extends State<BarChartSample4> {
  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.66,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              barTouchData: BarTouchData(
                enabled: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,

                  getTextStyles: (context, value) => const TextStyle(color: Color(0xff939393), fontSize: 10),
                  margin: 10,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'Apr';
                      case 1:
                        return 'May';
                      case 2:
                        return 'Jun';
                      case 3:
                        return 'Jul';
                      case 4:
                        return 'Aug';
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(
                      color: Color(
                        0xff939393,
                      ),
                      fontSize: 10),
                  margin: 0,
                ),
              ),
              gridData: FlGridData(
                show: true,
                checkToShowHorizontalLine: (value) => value % 10 == 0,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: const Color(0xffe7e8ec),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              groupsSpace: 4,
              barGroups: getData(),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getData() {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: 17000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 2000000000, dark),
                BarChartRodStackItem(2000000000, 12000000000, normal),
                BarChartRodStackItem(12000000000, 17000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 24000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 13000000000, dark),
                BarChartRodStackItem(13000000000, 14000000000, normal),
                BarChartRodStackItem(14000000000, 24000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 23000000000.5,
              rodStackItems: [
                BarChartRodStackItem(0, 6000000000.5, dark),
                BarChartRodStackItem(6000000000.5, 18000000000, normal),
                BarChartRodStackItem(18000000000, 23000000000.5, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 29000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 9000000000, dark),
                BarChartRodStackItem(9000000000, 15000000000, normal),
                BarChartRodStackItem(15000000000, 29000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 32000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 2000000000.5, dark),
                BarChartRodStackItem(2000000000.5, 17000000000.5, normal),
                BarChartRodStackItem(17000000000.5, 32000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: 31000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 11000000000, dark),
                BarChartRodStackItem(11000000000, 18000000000, normal),
                BarChartRodStackItem(18000000000, 31000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 35000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 14000000000, dark),
                BarChartRodStackItem(14000000000, 27000000000, normal),
                BarChartRodStackItem(27000000000, 35000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 31000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 8000000000, dark),
                BarChartRodStackItem(8000000000, 24000000000, normal),
                BarChartRodStackItem(24000000000, 31000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 15000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 6000000000.5, dark),
                BarChartRodStackItem(6000000000.5, 12000000000.5, normal),
                BarChartRodStackItem(12000000000.5, 15000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 17000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 9000000000, dark),
                BarChartRodStackItem(9000000000, 15000000000, normal),
                BarChartRodStackItem(15000000000, 17000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: 34000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 6000000000, dark),
                BarChartRodStackItem(6000000000, 23000000000, normal),
                BarChartRodStackItem(23000000000, 34000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 32000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 7000000000, dark),
                BarChartRodStackItem(7000000000, 24000000000, normal),
                BarChartRodStackItem(24000000000, 32000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 14000000000.5,
              rodStackItems: [
                BarChartRodStackItem(0, 1000000000.5, dark),
                BarChartRodStackItem(1000000000.5, 12000000000, normal),
                BarChartRodStackItem(12000000000, 14000000000.5, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 20000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 4000000000, dark),
                BarChartRodStackItem(4000000000, 15000000000, normal),
                BarChartRodStackItem(15000000000, 20000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 24000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 4000000000, dark),
                BarChartRodStackItem(4000000000, 15000000000, normal),
                BarChartRodStackItem(15000000000, 24000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: 14000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 1000000000.5, dark),
                BarChartRodStackItem(1000000000.5, 12000000000, normal),
                BarChartRodStackItem(12000000000, 14000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 27000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 7000000000, dark),
                BarChartRodStackItem(7000000000, 25000000000, normal),
                BarChartRodStackItem(25000000000, 27000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 29000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 6000000000, dark),
                BarChartRodStackItem(6000000000, 23000000000, normal),
                BarChartRodStackItem(23000000000, 29000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 16000000000.5,
              rodStackItems: [
                BarChartRodStackItem(0, 9000000000, dark),
                BarChartRodStackItem(9000000000, 15000000000, normal),
                BarChartRodStackItem(15000000000, 16000000000.5, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              y: 15000000000,
              rodStackItems: [
                BarChartRodStackItem(0, 7000000000, dark),
                BarChartRodStackItem(7000000000, 12000000000.5, normal),
                BarChartRodStackItem(12000000000.5, 15000000000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
    ];
  }
}


class BarChartSample5 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample5State();
}

class BarChartSample5State extends State<BarChartSample5> {
  static const double barWidth = 22;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: const Color(0xff020227),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              maxY: 20,
              minY: -20,
              groupsSpace: 12,
              barTouchData: BarTouchData(
                enabled: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                topTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(color: Colors.white, fontSize: 10),
                  margin: 10,
                  rotateAngle: 0,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'Mon';
                      case 1:
                        return 'Tue';
                      case 2:
                        return 'Wed';
                      case 3:
                        return 'Thu';
                      case 4:
                        return 'Fri';
                      case 5:
                        return 'Sat';
                      case 6:
                        return 'Sun';
                      default:
                        return '';
                    }
                  },
                ),
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context ,value) => const TextStyle(color: Colors.white, fontSize: 10),
                  margin: 10,
                  rotateAngle: 0,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'Mon';
                      case 1:
                        return 'Tue';
                      case 2:
                        return 'Wed';
                      case 3:
                        return 'Thu';
                      case 4:
                        return 'Fri';
                      case 5:
                        return 'Sat';
                      case 6:
                        return 'Sun';
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(color: Colors.white, fontSize: 10),
                  rotateAngle: 45,
                  getTitles: (double value) {
                    if (value == 0) {
                      return '0';
                    }
                    return '${value.toInt()}0k';
                  },
                  interval: 5,
                  margin: 8,
                  reservedSize: 30,
                ),
                rightTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(color: Colors.white, fontSize: 10),
                  rotateAngle: 90,
                  getTitles: (double value) {
                    if (value == 0) {
                      return '0';
                    }
                    return '${value.toInt()}0k';
                  },
                  interval: 5,
                  margin: 8,
                  reservedSize: 30,
                ),
              ),
              gridData: FlGridData(
                show: true,
                checkToShowHorizontalLine: (value) => value % 5 == 0,
                getDrawingHorizontalLine: (value) {
                  if (value == 0) {
                    return FlLine(color: const Color(0xff363753), strokeWidth: 3);
                  }
                  return FlLine(
                    color: const Color(0xff2a2747),
                    strokeWidth: 0.8,
                  );
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                      y: 15.1,
                      width: barWidth,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                      rodStackItems: [
                        BarChartRodStackItem(0, 2, const Color(0xff2bdb90)),
                        BarChartRodStackItem(2, 5, const Color(0xffffdd80)),
                        BarChartRodStackItem(5, 7.5, const Color(0xffff4d94)),
                        BarChartRodStackItem(7.5, 15.5, const Color(0xff19bfff)),
                      ],
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      y: -14,
                      width: barWidth,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                      rodStackItems: [
                        BarChartRodStackItem(0, -1.8, const Color(0xff2bdb90)),
                        BarChartRodStackItem(-1.8, -4.5, const Color(0xffffdd80)),
                        BarChartRodStackItem(-4.5, -7.5, const Color(0xffff4d94)),
                        BarChartRodStackItem(-7.5, -14, const Color(0xff19bfff)),
                      ],
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                      y: 13,
                      width: barWidth,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                      rodStackItems: [
                        BarChartRodStackItem(0, 1.5, const Color(0xff2bdb90)),
                        BarChartRodStackItem(1.5, 3.5, const Color(0xffffdd80)),
                        BarChartRodStackItem(3.5, 7, const Color(0xffff4d94)),
                        BarChartRodStackItem(7, 13, const Color(0xff19bfff)),
                      ],
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(
                      y: 13.5,
                      width: barWidth,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                      rodStackItems: [
                        BarChartRodStackItem(0, 1.5, const Color(0xff2bdb90)),
                        BarChartRodStackItem(1.5, 3, const Color(0xffffdd80)),
                        BarChartRodStackItem(3, 7, const Color(0xffff4d94)),
                        BarChartRodStackItem(7, 13.5, const Color(0xff19bfff)),
                      ],
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 4,
                  barRods: [
                    BarChartRodData(
                      y: -18,
                      width: barWidth,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                      rodStackItems: [
                        BarChartRodStackItem(0, -2, const Color(0xff2bdb90)),
                        BarChartRodStackItem(-2, -4, const Color(0xffffdd80)),
                        BarChartRodStackItem(-4, -9, const Color(0xffff4d94)),
                        BarChartRodStackItem(-9, -18, const Color(0xff19bfff)),
                      ],
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 5,
                  barRods: [
                    BarChartRodData(
                      y: -17,
                      width: barWidth,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                      rodStackItems: [
                        BarChartRodStackItem(0, -1.2, const Color(0xff2bdb90)),
                        BarChartRodStackItem(-1.2, -2.7, const Color(0xffffdd80)),
                        BarChartRodStackItem(-2.7, -7, const Color(0xffff4d94)),
                        BarChartRodStackItem(-7, -17, const Color(0xff19bfff)),
                      ],
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 6,
                  barRods: [
                    BarChartRodData(
                      y: 16,
                      width: barWidth,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                      rodStackItems: [
                        BarChartRodStackItem(0, 1.2, const Color(0xff2bdb90)),
                        BarChartRodStackItem(1.2, 6, const Color(0xffffdd80)),
                        BarChartRodStackItem(6, 11, const Color(0xffff4d94)),
                        BarChartRodStackItem(11, 17, const Color(0xff19bfff)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}