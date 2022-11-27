import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/size_config.dart';

class ColumnLabel extends StatelessWidget {
  final String image;
  final String text;

  const ColumnLabel({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    double padding = SizeConfig.getProportionateScreenWidth(20);
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.getProportionateScreenWidth(30))),
        ),
        padding: EdgeInsets.fromLTRB(
          padding,
          SizeConfig.getProportionateScreenWidth(5),
          padding,
          SizeConfig.getProportionateScreenWidth(5),
        ),
        margin: EdgeInsets.symmetric(horizontal: padding, vertical: SizeConfig.getProportionateScreenWidth(5)),
        child: Row(
          children: [
            Expanded(child: SvgPicture.asset(image, height: SizeConfig.getProportionateScreenHeight(50))),
            SizedBox(width: SizeConfig.getProportionateScreenWidth(5)),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: SizeConfig.getProportionateScreenHeight(20),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
