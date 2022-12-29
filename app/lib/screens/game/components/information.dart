import 'package:feel_the_art/theme/size_config.dart';
import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  final int point;
  final int time;
  final TextStyle textStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w600, fontSize: 28);

  const InformationScreen({super.key, required this.point, required this.time});

  @override
  Widget build(BuildContext context) {
    double verticalPadding =
        MediaQuery.of(context).getProportionateScreenHeight(10);
    double horizontalPadding =
        MediaQuery.of(context).getProportionateScreenHeight(20);
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text((time > 9) ? '00:$time' : '00:0$time',
                            style: textStyle)))),
            const Spacer(flex: 4),
            Expanded(
                flex: 3,
                child: Align(
                    alignment: Alignment.topRight,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('$point', style: textStyle))))
          ],
        ));
  }
}
