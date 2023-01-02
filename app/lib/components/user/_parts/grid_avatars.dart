import "package:auto_animated/auto_animated.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:multiavatar/multiavatar.dart";

import 'package:provider/provider.dart';

import "package:feel_the_art/theme/theme.dart";
import 'package:feel_the_art/services/account_service.dart';


class GridAvatars extends StatelessWidget {
  //Concettualmente è sbagliata! Non bisognerebbe usare accountServiceProvider in questo modo! [BUG]

  const GridAvatars({Key? key}) : super(key: key);

  Widget buildAnimatedItem(BuildContext context, int index, Animation<double> animation) {
    final AccountService accountService = Provider.of<AccountService>(context);

    final current = accountService.allAvatar[index];

    List<Widget> avatar = [
      SvgPicture.string(multiavatar(current)),
    ];
    if (current == accountService.avatar) {
      avatar.add(Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(color: princessPerfumeColor, shape: BoxShape.circle),
        child: const Icon(Icons.check, color: Colors.white),
      ));
    }

    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(animation),
        child: GestureDetector(
          onTap: () {
            accountService.setAvatar(current);
          },
          child: Stack(
            alignment: Alignment.bottomRight,
            children: avatar,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AccountService accountService = Provider.of<AccountService>(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 3), borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: LiveGrid(
          physics: const BouncingScrollPhysics(),
          itemBuilder: buildAnimatedItem,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
          ),
          itemCount: accountService.allAvatar.length,
        ),
      ),
    );
  }
}
