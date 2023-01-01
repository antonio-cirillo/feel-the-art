import 'package:flutter/material.dart';

import 'package:feel_the_art/theme/theme.dart';
import 'package:feel_the_art/theme/size_config.dart';
import 'package:feel_the_art/models/account/user.dart';
import 'package:feel_the_art/components/user/_parts/avatar_img.dart';
import 'package:feel_the_art/flutter_flow/flutter_flow_theme.dart';

class LeaderBoardCard extends StatelessWidget {
  final User user;
  final int pos;

  const LeaderBoardCard({Key? key, required this.user, required this.pos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextStyle> positionStyle = [
      const TextStyle(color: Colors.purpleAccent),
      const TextStyle(color: maizeColor),
      TextStyle(color: Colors.blueGrey.shade300),
      const TextStyle(color: Color.fromRGBO(205, 127, 50, 1)),
    ];

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [containerShadow],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          AvatarImg(user.avatar.get, 80),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 65,
            decoration: BoxDecoration(
              color: primaryColor,
              border: Border.all(color: bgColor, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
          ),
          Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  user.personaInfo.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Container(
                child: Text(
                  "Vittorie: ${user.statistics.first}",
                  style: Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(color: Color(0xff8022d5))),
                ),
              ),
            ],
          ),
          Expanded(
            child: Text((pos).toString(),
                style: Theme.of(context).textTheme.headlineLarge?.merge(titleStyle).merge(positionStyle[pos >= positionStyle.length ? 0 : pos]),
                textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
