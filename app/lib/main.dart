import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/loading/loading_screen.dart';
import 'screens/on_boarding/on_boarding_screen.dart';
import 'utils/colors.dart';
import 'utils/size_config.dart';

int? isViewed;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // debugPaintSizeEnabled=true;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Feel the ART',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: kPrimaryColor, fontFamily: 'Hind'),
        home: const FeelTheArt());
  }
}

class FeelTheArt extends StatefulWidget {
  const FeelTheArt({super.key});

  @override
  State<FeelTheArt> createState() => _FeelTheArt();
}

class _FeelTheArt extends State<FeelTheArt> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return isViewed != 0 ? const OnBoardingScreen() : const LoadingScreen();
  }
}
