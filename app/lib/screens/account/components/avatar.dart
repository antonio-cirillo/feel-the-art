import "package:auto_animated/auto_animated.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:multiavatar/multiavatar.dart";
import "package:percent_indicator/percent_indicator.dart";
import "package:provider/provider.dart";

import "package:feel_the_art/utils/theme/colors.dart";
import "package:feel_the_art/utils/theme/size_config.dart";
import "package:feel_the_art/services/account_service.dart";

class Avatar extends StatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    AccountService accountInfo = Provider.of<AccountService>(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircularPercentIndicator(
                  progressColor: princessPerfumeColor,
                  backgroundColor: princessPerfumeColor.withOpacity(0.3),
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 3000,
                  radius: MediaQuery.of(context).getProportionateScreenWidth(122),
                  lineWidth: MediaQuery.of(context).getProportionateScreenWidth(8),
                  startAngle: 180,
                  percent: accountInfo.exp == 0 ? 0.1 : (accountInfo.exp) / (accountInfo.level * 10),
                  center: SvgPicture.string(
                    multiavatar(accountInfo.avatar),
                    height: MediaQuery.of(context).getProportionateScreenWidth(250),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showGeneralDialog(
                        barrierDismissible: true,
                        barrierLabel: "Avatar",
                        context: context,
                        pageBuilder: (context, _, __) => Align(
                            alignment: Alignment.center,
                            child: Wrap(children: [
                              Container(
                                  height: MediaQuery.of(context).getProportionateScreenHeight(620),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                  margin: const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(color: amethystColor.withOpacity(0.5), borderRadius: const BorderRadius.all(Radius.circular(20))),
                                  child: Column(children: [
                                    const FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text("Scegli il tuo avatar",
                                            style:
                                                TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 36, fontFamily: "ElsieSwashCaps"))),
                                    const Expanded(flex: 7, child: GridAvatars()),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                accountInfo.addAvatar();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: princessPerfumeColor,
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(10),
                                                          topRight: Radius.circular(25),
                                                          bottomRight: Radius.circular(25),
                                                          bottomLeft: Radius.circular(25)))),
                                              child: const Text("Salva")),
                                        ),
                                        const Spacer(flex: 1),
                                        Expanded(
                                            flex: 4,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  accountInfo.generateNewAvatar();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: princessPerfumeColor,
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(25),
                                                            topRight: Radius.circular(25),
                                                            bottomRight: Radius.circular(10),
                                                            bottomLeft: Radius.circular(25)))),
                                                child: Text("Genera")))
                                      ],
                                    )
                                  ])),
                            ])));
                  },
                  style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: princessPerfumeColor, padding: const EdgeInsets.all(12)),
                  child: const Icon(Icons.edit),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class GridAvatars extends StatefulWidget {
  const GridAvatars({Key? key}) : super(key: key);

  @override
  State<GridAvatars> createState() => _GridAvatars();
}

class _GridAvatars extends State<GridAvatars> {
  Widget buildAnimatedItem(BuildContext context, int index, Animation<double> animation) {
    AccountService accountInfo = Provider.of<AccountService>(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(animation),
        child: GestureDetector(
          child: (accountInfo.avatar != accountInfo.allAvatar[index])
              ? SvgPicture.string(multiavatar(accountInfo.allAvatar[index]))
              : Stack(children: [
                  SvgPicture.string(multiavatar(accountInfo.allAvatar[index])),
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
            if (index != 0) accountInfo.setAvatar(accountInfo.allAvatar[index]);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AccountService accountInfo = Provider.of<AccountService>(context);
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
            itemCount: accountInfo.allAvatar.length));
  }
}
