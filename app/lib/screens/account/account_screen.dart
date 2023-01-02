import "package:flutter/material.dart";

import 'package:feel_the_art/components/user/_parts/avatar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Avatar(dim: 122),
    );
  }
}
