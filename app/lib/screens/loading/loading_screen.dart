import 'package:feel_the_art/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/account_model.dart';
import '../../model/game_card_model.dart';
import '../../utils/size_config.dart';
import '../menu/menu_screen.dart';
import 'components/background.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    goToMenu();
  }

  void goToMenu() async {
    await Future.delayed(const Duration(seconds: 2), () {
      AccountModel accountModel = AccountModel('GIGI');
      GameCardModel();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MultiProvider(providers: [
                  ChangeNotifierProvider(create: (ctx) => accountModel)
                ], child: const SafeArea(child: MenuScreen()))),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      const LoadingScreenBackground(),
      Align(
        alignment: Alignment.center,
        child: SizedBox(
            height: SizeConfig.screenHeight * 0.4,
            width: SizeConfig.screenWidth * 0.7,
            child: Column(children: <Widget>[
              Expanded(flex: 3, child: Image.asset("assets/icons/icon.png")),
              const Expanded(
                  flex: 1,
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Feel the ART",
                        style: TextStyle(
                            fontFamily: 'ElsieSwashCaps',
                            fontSize: 48,
                            color: Colors.white),
                      ))),
              const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(yellowColor))
            ])),
      )
    ]));
  }
}
