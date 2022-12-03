import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';

class CardScreenBar extends StatelessWidget {
  final String deck;

  const CardScreenBar({super.key, required this.deck});

  @override
  Widget build(BuildContext context) {
    double proportionate20px = SizeConfig.getProportionateScreenWidth(20);
    double proportionate40px = SizeConfig.getProportionateScreenWidth(40);
    return Padding(
            padding: EdgeInsets.only(
                left: proportionate20px,
                right: proportionate20px,
                top: proportionate20px),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: proportionate40px,
                  width: proportionate40px,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.zero),
                      child: SvgPicture.asset("assets/icons/back_icon.svg",
                          height: SizeConfig.getProportionateScreenHeight(15)),
                      onPressed: () => Navigator.pop(context)),
                ),
                const Spacer(),
                Container(
                    height: SizeConfig.getProportionateScreenWidth(40),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
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
                              fontSize:
                                  SizeConfig.getProportionateScreenHeight(14),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          SvgPicture.asset("assets/icons/monalisa.svg",
                              height:
                                  SizeConfig.getProportionateScreenHeight(25)),
                        ],
                      ),
                    ))
              ],
            ));
  }
}
