import "package:feel_the_art/models/leaderboard.dart";
import "package:feel_the_art/theme/theme_flutter_flow.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:multiavatar/multiavatar.dart";

import "package:feel_the_art/components/background.dart";
import "package:feel_the_art/theme/theme.dart";
import "package:feel_the_art/theme/size_config.dart";
import "package:feel_the_art/services/leaderboard_service.dart";

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle position = TextStyle(
        color: Colors.purpleAccent,
        fontWeight: FontWeight.bold,
        fontFamily: "ElsieSwashCaps",
        fontSize: MediaQuery.of(context).getProportionateScreenWidth(33));
    TextStyle firstPosition = TextStyle(
        color: Colors.amber.shade300,
        fontWeight: FontWeight.bold,
        fontFamily: "ElsieSwashCaps",
        fontSize: MediaQuery.of(context).getProportionateScreenWidth(38));
    TextStyle secondPosition = TextStyle(
        color: Colors.blueGrey.shade300,
        fontWeight: FontWeight.bold,
        fontFamily: "ElsieSwashCaps",
        fontSize: MediaQuery.of(context).getProportionateScreenWidth(33));
    TextStyle thirdPosition = TextStyle(
        color: const Color.fromRGBO(205, 127, 50, 1),
        fontWeight: FontWeight.bold,
        fontFamily: "ElsieSwashCaps",
        fontSize: MediaQuery.of(context).getProportionateScreenWidth(38));

    double avatarSize = MediaQuery.of(context).getProportionateScreenHeight(30);

    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Stack(
                    children: [
                      Text(
                        "Classifica",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 5
                            ..color = bgColor,
                          fontFamily: "ElsieSwashCaps",
                        ),
                      ),
                      const Text("Classifica", style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w600, fontFamily: "ElsieSwashCaps"))
                    ],
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: LeaderBoardService.fetch(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    final leaderboard = snapshot.data as LeaderBoard;
                    return Expanded(
                      flex: 6,
                      child: Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          itemCount: leaderboard.userList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color(0x25000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: CircleAvatar(
                                          radius: avatarSize,
                                          child: SvgPicture.string(multiavatar(leaderboard.userList[index].avatar.get)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 4, 8),
                                      child: Container(
                                        width: 4,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff8022d5),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 16, 12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            index == 0 ? "ooooooooo" : leaderboard.userList[index].personaInfo.name,
                                            style: FlutterFlowTheme.of(context).title2.override(
                                                fontFamily: "Outfit",
                                                color: const Color(0xFF101213),
                                                fontSize: MediaQuery.of(context).getProportionateScreenWidth(16),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                            child: Text(
                                              "Win : ${leaderboard.userList[index].statistics.first}",
                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                    fontFamily: "Outfit",
                                                    color: const Color(0xff8022d5),
                                                    fontSize: MediaQuery.of(context).getProportionateScreenWidth(14),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 20),
                                            child: index == 0
                                                ? Text((index + 1).toString(), style: firstPosition)
                                                : index == 1
                                                    ? Text((index + 1).toString(), style: secondPosition)
                                                    : index == 2
                                                        ? Text((index + 1).toString(), style: thirdPosition)
                                                        : Text(
                                                            (index + 1).toString(),
                                                            style: position,
                                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return const Text("No Connection");
                }
                return const Text("data");
              },
            )
          ],
        ),
      ),
    ]);
  }
}
