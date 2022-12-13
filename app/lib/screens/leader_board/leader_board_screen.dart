import 'package:feel_the_art/classes/leaderboard.dart';
import 'package:feel_the_art/screens/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:feel_the_art/flutter_flow/flutter_flow_theme.dart';

import '../../model/leaderboard_model.dart';
import '../../utils/theme/size_config.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle position = TextStyle(
        color: Colors.purpleAccent,
        fontWeight: FontWeight.bold,
        fontFamily: 'ElsieSwashCaps',
        fontSize: MediaQuery.of(context).getProportionateScreenWidth(33));
    TextStyle firstPosition = TextStyle(
        color: Colors.amber.shade300,
        fontWeight: FontWeight.bold,
        fontFamily: 'ElsieSwashCaps',
        fontSize: MediaQuery.of(context).getProportionateScreenWidth(38));
    TextStyle secondPosition = TextStyle(
        color: Colors.blueGrey.shade300,
        fontWeight: FontWeight.bold,
        fontFamily: 'ElsieSwashCaps',
        fontSize: MediaQuery.of(context).getProportionateScreenWidth(33));
    TextStyle thirdPosition = TextStyle(
        color: const Color.fromRGBO(205, 127, 50, 1),
        fontWeight: FontWeight.bold,
        fontFamily: 'ElsieSwashCaps',
        fontSize: MediaQuery.of(context).getProportionateScreenWidth(38));

    double avatarSize = MediaQuery.of(context).getProportionateScreenHeight(30);

    return Scaffold(
        body: Column(children: <Widget>[
      Expanded(
        flex: 2,
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                height: 250,
              color: const  Color(0xffdfe2e6),
            ),
            Container(
              width: double.infinity,
              height: 250,
              decoration:const BoxDecoration(
                gradient: LinearGradient(
                  colors: [ Color(0xff8022d5),Color(0xFF9f5CDB) ],
                  stops: [0, 1],
                  begin: AlignmentDirectional(0, -1),
                  end: AlignmentDirectional(0, 1),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'LeaderBoard',
                style: TextStyle(
                  fontFamily: 'ElsieSwashCaps',
                      color: const Color(0x1CF2F3F5),
                      fontSize: MediaQuery.of(context).getProportionateScreenWidth(47),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'LeaderBoard',
                  style: TextStyle(
                    fontFamily: 'ElsieSwashCaps',
                        color: FlutterFlowTheme.of(context).lineColor,
                        fontSize: MediaQuery.of(context).getProportionateScreenWidth(18),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      FutureBuilder(
        future: LeaderBoardModel.fetch(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final leaderboard = snapshot.data as LeaderBoard;
              return
                Expanded(
                flex: 7,
                child:
                Container(
                  width: double.infinity,
                color: const Color(0xffdfe2e6),
                child : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: leaderboard.userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
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
                                        fontFamily: 'Outfit',
                                        color: const Color(0xFF101213),
                                        fontSize: MediaQuery.of(context).getProportionateScreenWidth(16),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                    child: Text(
                                      'Win : ${leaderboard.userList[index].statistics.first}',
                                      style: FlutterFlowTheme.of(context).bodyText1.override(
                                            fontFamily: 'Outfit',
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
                ),),
              );
            }
          }
          return const Text("data");
        },
      )
    ]));
  }
}
