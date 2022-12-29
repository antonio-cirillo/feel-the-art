import "package:auto_animated/auto_animated.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:multiavatar/multiavatar.dart";

import "package:feel_the_art/theme/theme.dart";
import "package:feel_the_art/theme/size_config.dart";

class GridAvatars extends StatelessWidget {
  final List<String> _avatars;
  final Function _setAvatar;
  const GridAvatars(this._avatars, this._setAvatar, {Key? key}) : super(key: key);

  @override
  Widget buildAnimatedItem(BuildContext context, int index, Animation<double> animation) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(animation),
        child: GestureDetector(
          child: (index != 0 )
              ? SvgPicture.string(multiavatar(_avatars[index]))
              : Stack(children: [
            SvgPicture.string(multiavatar(_avatars[index])),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: princessPerfumeColor, shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.white)),
            )
          ]),
          onTap: () {
            if (index != 0) _setAvatar(_avatars[index]);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 3), borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: LiveGrid(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: buildAnimatedItem,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.9,
              crossAxisCount: 2,
              crossAxisSpacing: MediaQuery.of(context).getProportionateScreenHeight(20),
            ),
            itemCount: _avatars.length));
  }
}


