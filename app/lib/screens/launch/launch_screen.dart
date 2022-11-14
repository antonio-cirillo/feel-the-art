import 'package:feel_the_art/screens/login/login_screen.dart';
import 'package:feel_the_art/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreen();
}

class _LaunchScreen extends State<LaunchScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  static const bodyStyle = TextStyle(fontSize: 19.0);

  static const pageDecoration = PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
    bodyTextStyle: bodyStyle,
    bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    pageColor: Colors.white,
    imagePadding: EdgeInsets.zero,
  );

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  List<PageViewModel> _buildPages() {
    return [
      PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('test.jpeg'),
          decoration: pageDecoration),
      PageViewModel(
          title: "Title of first page",
          body:
              "Here you can write the description of the page, to explain someting...",
          decoration: pageDecoration)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: _buildPages(),
      onDone: () => _onIntroEnd(context),
      showBackButton: false,
      showSkipButton: true,
      showNextButton: false,
      skip: const Text("Skip", style: TextStyle(color: kPrimaryColor)),
      done: const Text("Done",
          style: TextStyle(fontWeight: FontWeight.w600, color: kPrimaryColor)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeColor: kPrimaryColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
