import 'package:flutter/material.dart';

const bgColor = Color(0xffad92d7);
const blueJeansColor = Color(0xFF5DBDF6);
const robinEggBlueColor = Color(0xFF00DCC2);
const princessPerfumeColor = Color(0xFFFF7ACB);
const primaryColor = Color(0xff9f5cdb);
const maizeColor = Color(0xFFFFC54D);
const blackColor = Color(0xFF1B1B1B);

ThemeData theme = ThemeData(
  fontFamily: "Hind",
  backgroundColor: bgColor,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.green[900];
        }
        return Colors.green;
      }),
    ),
  ),
);

TextStyle get whiteText => const TextStyle(color: Colors.white);

TextStyle get titleStyle => const TextStyle(color: blackColor, fontWeight: FontWeight.w700, fontFamily: "ElsieSwashCaps");

TextStyle get shadow => const TextStyle(shadows: [Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 2.5)]);

BoxShadow get containerShadow => const BoxShadow(
      blurRadius: 3,
      color: Color(0x25000000),
      offset: Offset(0, 2),
    );

BoxDecoration get borderRed => BoxDecoration(border: Border.all(color: Colors.red));
