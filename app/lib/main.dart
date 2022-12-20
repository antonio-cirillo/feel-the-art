import 'package:feel_the_art/model/deck_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';

import 'package:feel_the_art/screens/main_screen.dart';
import 'package:feel_the_art/model/account_model.dart';
import 'package:feel_the_art/utils/theme/colors.dart';

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
        ChangeNotifierProvider(create: (ctx) => AccountModel('GIGI')),
        ChangeNotifierProvider(create: (ctx) => DeckListModel()),
      ],
      child: MaterialApp(
        title: 'Feel the ART',
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primaryColor: ,
          scaffoldBackgroundColor: amethystColor.withOpacity(0.8),
          fontFamily: 'Hind',
        ),
        routes: {
          '/game': (context) => const Scaffold(),
        },
        home: const SafeArea(
          bottom: false,
          child: MainScreen(),
        ),
      ),
    );
  }
}
