import "package:flutter/material.dart";

// import 'package:flutter/rendering.dart';
import "package:flutter/services.dart";
import "package:provider/provider.dart";
import "package:device_preview/device_preview.dart";

import "package:feel_the_art/theme/theme.dart";
import "package:feel_the_art/screens/main_screen.dart";
import "package:feel_the_art/services/account_service.dart";
import "package:feel_the_art/services/decks_service.dart" as decklist;

void main() {
  // debugPaintSizeEnabled=true;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(
    // const FeelTheArt(),
    DevicePreview(
      enabled: false,
      builder: (context) => const FeelTheArt(),
    ),
  );
}

class FeelTheArt extends StatelessWidget {
  static final navKey = GlobalKey<NavigatorState>();

  const FeelTheArt({super.key});

  static Route createRoute(Widget child) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AccountService()),
        ChangeNotifierProvider(create: (ctx) => decklist.DecksService()),
      ],
      child: MaterialApp(
        navigatorKey: navKey,
        title: "Feel the ART",
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        // builder: (BuildContext context, Widget? child) => SafeArea(child: child ?? Container(),),
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const SafeArea(
          child: MainScreen(),
        ),
      ),
    );
  }
}
