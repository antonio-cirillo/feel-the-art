import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var r = TextStyle(color: Colors.purpleAccent, fontSize: 34);
    double borderSize = SizeConfig.getProportionateScreenWidth(5);
    double nameSize = SizeConfig.getProportionateScreenWidth(17);
    double avatarSize = SizeConfig.getProportionateScreenHeight(30);
    double scoreSize = SizeConfig.getProportionateScreenWidth(25);
    double positionSize = SizeConfig.getProportionateScreenWidth(17);
    double titleSize = SizeConfig.getProportionateScreenWidth(40);
    double namePlayerPadding = SizeConfig.getProportionateScreenWidth(15);

    return Column(children: <Widget>[
      Expanded(
        flex: 1,
        child: Align(
            alignment: Alignment.center,
            child: RichText(
                text: TextSpan(
                    text: "Leader",
                    style: TextStyle(color: Colors.white, fontSize: titleSize, fontWeight: FontWeight.bold, fontFamily: 'ElsieSwashCaps'),
                    children: [
                  TextSpan(text: " Board", style: TextStyle(color: Colors.pink, fontSize: titleSize, fontWeight: FontWeight.bold, fontFamily: 'ElsieSwashCaps'))
                ]))),
      ),
      Expanded(
          flex: 7,
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff222433),
                          border: Border.all(
                              color: index == 0
                                  ? Colors.amber
                                  : index == 1
                                      ? Colors.grey
                                      : index == 2
                                          ? Colors.brown
                                          : Colors.white,
                              width: borderSize,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(15.0)),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 15.0, right: namePlayerPadding),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: CircleAvatar(
                                        radius: avatarSize,
                                        backgroundImage: NetworkImage('assets/images/card.png'),
                                        /*child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle, image: DecorationImage(image: NetworkImage('assets/images/card.png'), fit: BoxFit.fill)))*/
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Flexible(child: Container()),
                              index == 0
                                  ? Text("🥇", style: r)
                                  : index == 1
                                  ? Text(
                                "🥈",
                                style: r,
                              )
                                  : index == 2
                                  ? Text(
                                "🥉",
                                style: r,
                              )
                                  : Text(index.toString(), style: TextStyle(color: Colors.white, fontSize: positionSize)),
                              Flexible(child: Container()),
                              Padding(
                                padding: EdgeInsets.only(left: namePlayerPadding, right: namePlayerPadding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Nome Giocatore",
                                          style: TextStyle(color: Colors.white, fontSize: nameSize, fontFamily: 'ElsieSwashCaps'),
                                          maxLines: 6,
                                        )),
                                  ],
                                ),
                              ),
                              Text(
                                "56",
                                style: TextStyle(color: Colors.white, fontSize: scoreSize),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0, top: 13.0, right: 10.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }))
    ]);
  }
}
