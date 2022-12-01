import 'package:feel_the_art/utils/obj_status.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/account_model.dart';

class ChartWin extends StatefulWidget {
  const ChartWin({Key? key}) : super(key: key);

  @override
  State<ChartWin> createState() => _ChartWinState();
}

class _ChartWinState extends State<ChartWin> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final accountInfo = Provider.of<AccountModel>(context);
    if(accountInfo.status != ObjStatus.error){
      return const Text("Caricamento");
    }
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 5,
          centerSpaceRadius: 0,
          sections: showingSections(accountInfo),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(AccountModel accountInfo) {
    double firstPlace = accountInfo.firstPlaces / accountInfo.totalGames * 100;
    double secondPlace = accountInfo.secondPlaces / accountInfo.totalGames * 100;
    double thirdPlace = accountInfo.thirdPlaces / accountInfo.totalGames * 100;
    double lose = accountInfo.loseGames / accountInfo.totalGames * 100;

    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 18.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 65.0 : 50.0;

      switch (i) {
        case 0:
          return slice(firstPlace, const Color(0xff0293ee), "🥇", radius, fontSize, widgetSize);
        case 1:
          return slice(secondPlace, const Color(0xfff8b250), "🥈", radius, fontSize, widgetSize);
        case 2:
          return slice(thirdPlace, const Color(0xff845bef), "🥉", radius, fontSize, widgetSize);
        case 3:
          return slice(lose, const Color(0xff13d38e), "L", radius, fontSize, widgetSize);
        default:
          throw Exception('Oh no');
      }
    });
  }

  PieChartSectionData slice(double percent, Color color, String badgeContent, double radius, double fontSize, double widgetSize) {
    return PieChartSectionData(
      color: color,
      value: percent,
      title: '${double.parse((percent).toStringAsFixed(1))}%',
      radius: radius,
      titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
      badgePositionPercentageOffset: .98,
      badgeWidget: _Badge(widgetSize, color, badgeContent),
    );
  }
}

class _Badge extends StatelessWidget {
  final double size;
  final Color borderColor;
  final String content;

  _Badge(this.size, this.borderColor, this.content);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Text(content, style: const TextStyle(fontSize: 25)),
      ),
    );
  }
}
