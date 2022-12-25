import 'package:feel_the_art/screens/game/components/information.dart';
import 'package:feel_the_art/screens/game/components/user_cards.dart';
import 'package:flutter/material.dart';

class UserHandScreen extends StatelessWidget {
  const UserHandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(flex: 6, child: UserCardsScreen()),
        Expanded(flex: 3, child: InformationScreen())
      ],
    );
  }
}
