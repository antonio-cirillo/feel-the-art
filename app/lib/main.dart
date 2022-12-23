import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";
import "package:device_preview/device_preview.dart";

import "package:feel_the_art/theme/theme.dart";
import "package:feel_the_art/screens/main_screen.dart";
import "package:feel_the_art/components/background.dart";
import "package:feel_the_art/services/account_service.dart";
import "package:feel_the_art/services/deck_list_service.dart" as decklist;

void main() {
  // debugPaintSizeEnabled=true;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(
    // const FeelTheArt(),
    DevicePreview(
      enabled: true,
      builder: (context) => const FeelTheArt(),
    ),
  );
}

class FeelTheArt extends StatelessWidget {
  const FeelTheArt({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AccountService()),
        ChangeNotifierProvider(create: (ctx) => decklist.DeckListService()),
      ],
      child: MaterialApp(
        title: "Feel the ART",
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const SafeArea(
          bottom: false,
          child: MainScreen(),
        ),
      ),
    );
  }
}
