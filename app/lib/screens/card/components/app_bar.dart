import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:feel_the_art/utils/theme/colors.dart';
import '../../../utils/theme/size_config.dart';

class CardScreenBar extends StatelessWidget {
  final String deck;

  const CardScreenBar({super.key, required this.deck});

  @override
  Widget build(BuildContext context) {
    double proportionate20px = MediaQuery.of(context).getProportionateScreenWidth(20);
    double proportionate40px = MediaQuery.of(context).getProportionateScreenWidth(40);
    return Padding(
        padding: EdgeInsets.only(left: proportionate20px, right: proportionate20px, top: proportionate20px),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: proportionate40px,
              width: proportionate40px,
              child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: amethystColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.zero),
                  child: SvgPicture.asset("assets/icons/back_icon.svg", height: MediaQuery.of(context).getProportionateScreenHeight(15)),
                  onPressed: () => Navigator.pop(context)),
            ),
            const Spacer(),
            Container(
                height: MediaQuery.of(context).getProportionateScreenWidth(40),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        deck,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).getProportionateScreenHeight(14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset("assets/icons/monalisa.svg", height: MediaQuery.of(context).getProportionateScreenHeight(25)),
                    ],
                  ),
                ))
          ],
        ));
  }
}
