import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:introduction_screen/introduction_screen.dart";

import "package:feel_the_art/theme/theme.dart";
import "package:feel_the_art/components/background.dart";
import "package:feel_the_art/services/account_service.dart";

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void nextPage() {
    introKey.currentState?.next();
  }

  @override
  Widget build(BuildContext context) {
    AccountService accountInfo = Provider.of<AccountService>(context);

    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.displaySmall?.merge(titleStyle) ?? const TextStyle(),
      bodyTextStyle: whiteText,
      imagePadding: const EdgeInsets.only(top: 40, left: 30),
    );

    return Stack(children: <Widget>[
      BackgroundScreen(bgColor.withOpacity(0.8)),
      IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.transparent,
        pages: [
          PageViewModel(
            image: Image.asset("assets/icons/icon.png"),
            title: "Feel the ART",
            body: "Divertirti e impara tantissime curiosità sul mondo dell'arte, non perdere tempo e prossegui per scoprire le regole del gioco",
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Come si Gioca?",
            body: "Here you can write the description of the page, to explain someting...",
            decoration: pageDecoration,
          )
        ],
        showBackButton: false,
        overrideDone: TextButton(
          onPressed: () => accountInfo.setOnboardOff(),
          child: const Text("Fine"),
        ),
        showSkipButton: true,
        overrideSkip: TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.white),
          onPressed: () => accountInfo.setOnboardOff(),
          child: const Text(
            "Salta",
            style: TextStyle(color: primaryColor),
          ),
        ),
        showNextButton: true,
        overrideNext: TextButton(
          onPressed: () => nextPage(),
          child: const Text("Avanti"),
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeColor: maizeColor,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    ]);
  }
}
