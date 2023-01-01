import "package:flutter/material.dart";

import "package:feel_the_art/theme/theme.dart";
import "package:feel_the_art/services/leaderboard_service.dart";
import 'package:feel_the_art/screens/loading/loading_screen.dart';
import 'package:feel_the_art/components/text/text_with_border.dart';
import 'package:feel_the_art/screens/leader_board/_parts/leader_board_card.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: TextWithBorder(
              "Classifica",
              Colors.white,
              primaryColor,
              style: Theme.of(context).textTheme.displayMedium?.merge(titleStyle),
            ),
          ),
        ),
        FutureBuilder(
          future: LeaderBoardService.fetch(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final leaderboard = snapshot.data as LeaderBoardService;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      physics: const BouncingScrollPhysics(),
                      itemCount: leaderboard.userList.length,
                      itemBuilder: (BuildContext context, int index) => LeaderBoardCard(user: leaderboard.userList[index], pos: index+1),
                    ),
                  ),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Text("No Connection");
            }
            return const Text("data");
          },
        )
      ],
    );
  }
}
