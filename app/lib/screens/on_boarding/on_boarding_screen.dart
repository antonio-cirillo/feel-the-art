import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:feel_the_art/utils/theme/colors.dart';
import 'package:provider/provider.dart';
import '../../utils/request/storage_request.dart';
import '../loading/components/background.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  static const bodyStyle = TextStyle(fontSize: 19.0);

  static const pageDecoration = PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
    bodyTextStyle: bodyStyle,
    imageFlex: 3,
    bodyFlex: 2,
    bodyAlignment: Alignment.topCenter,
    imageAlignment: Alignment.bottomCenter,
    bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    titlePadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
    pageColor: Colors.transparent,
    imagePadding: EdgeInsets.only(top: 100),
  );

  List<PageViewModel> _buildPages() {
    return [
      PageViewModel(
          image: Image.asset("assets/icons/icon.png", width: 300),
          title: 'Feel the ART',
          body: 'Instead of having to buy an entire share, invest any amount you want.',
          decoration: pageDecoration),
      PageViewModel(title: 'Title of first page', body: 'Here you can write the description of the page, to explain someting...', decoration: pageDecoration)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final sr = Provider.of<StorageRequest>(context);

    return Stack(children: <Widget>[
      Container(color: amethystColor),
      const LoadingScreenBackground(),
      IntroductionScreen(
        globalBackgroundColor: Colors.transparent,
        pages: _buildPages(),
        onDone: () {
          sr.setOnBoard(false);
        },
        showBackButton: false,
        showSkipButton: true,
        showNextButton: false,
        skip: const Text('Salta', style: TextStyle(color: Colors.white)),
        skipStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(princessPerfumeColor),
          shadowColor: MaterialStateProperty.all(Colors.black),
        ),
        done: const Text('Continua', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
        doneStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(robinEggBlueColor),
          shadowColor: MaterialStateProperty.all(Colors.black),
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
