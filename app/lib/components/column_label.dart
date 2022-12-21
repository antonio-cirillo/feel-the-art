import "package:feel_the_art/theme/theme.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "package:feel_the_art/theme/size_config.dart";

class ColumnLabel extends StatelessWidget {
  final String image;
  final String text;
  final Color color;
  final Color separatorColor;
  final Border? border;

  const ColumnLabel(
      {super.key,
      this.color = Colors.white,
      this.separatorColor = bgColor,
      this.border,
      required this.image,
      required this.text});

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).getProportionateScreenWidth(20);
    double px5 = MediaQuery.of(context).getProportionateScreenWidth(5);
    return Container(
        decoration: BoxDecoration(
          color: color,
          border: border,
          borderRadius: BorderRadius.all(Radius.circular(
              MediaQuery.of(context).getProportionateScreenWidth(30))),
        ),
        padding: EdgeInsets.only(
            left: padding,
            right: padding,
            top: MediaQuery.of(context).getProportionateScreenWidth(10),
            bottom: MediaQuery.of(context).getProportionateScreenWidth(10)),
        margin: EdgeInsets.symmetric(horizontal: padding),
        child: Row(
          children: [
            Expanded(
                child: SvgPicture.asset(image,
                    height: MediaQuery.of(context)
                        .getProportionateScreenHeight(50))),
            SizedBox(width: px5 * 2),
            Container(
              height: MediaQuery.of(context).getProportionateScreenHeight(50),
              decoration: BoxDecoration(
                color: separatorColor,
                border: border,
                borderRadius: BorderRadius.all(Radius.circular(
                    MediaQuery.of(context).getProportionateScreenWidth(30))),
              ),
            ),
            SizedBox(width: px5 * 2),
            Expanded(
                flex: 4,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context)
                                .getProportionateScreenHeight(20),
                            fontWeight: FontWeight.w600,
                          ),
                        ))))
          ],
        ));
  }
}
