import 'package:feel_the_art/theme/size_config.dart';
import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  final int time;
  final TextStyle textStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w600, fontSize: 28);

  const InformationScreen({super.key, required this.time});

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
            const Spacer(flex: 3),
            Expanded(
                flex: 3,
                child: Align(
                    alignment: Alignment.topCenter,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text((time > 9) ? '00:$time' : '00:0$time',
                            style: textStyle)))),
            const Spacer(flex: 3),
          ],
        ));
  }
}
