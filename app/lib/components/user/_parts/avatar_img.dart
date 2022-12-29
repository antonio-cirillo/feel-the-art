import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiavatar/multiavatar.dart';

class AvatarImg extends StatelessWidget {
  final String img;
  final double dim;

  const AvatarImg(this.img, this.dim, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dim,
      width: dim,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: EdgeInsets.all(1),
        child: SvgPicture.string(
          multiavatar(img),
        ),
      ),
    );
  }
}
