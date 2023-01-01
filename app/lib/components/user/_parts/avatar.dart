import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:multiavatar/multiavatar.dart";
import "package:percent_indicator/percent_indicator.dart";
import "package:provider/provider.dart";

import "package:feel_the_art/theme/theme.dart";
import "package:feel_the_art/theme/size_config.dart";
import "package:feel_the_art/services/account_service.dart";

import 'package:feel_the_art/components/user/_parts/grid_avatars.dart';

class Avatar extends StatelessWidget {
  final double dim;

  const Avatar(this.dim, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountService accountService = Provider.of<AccountService>(context);

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircularPercentIndicator(
          progressColor: maizeColor,
          animation: true,
          animateFromLastPercent: true,
          animationDuration: 3000,
          radius: dim,
          lineWidth: dim,
          startAngle: 180,
          percent: accountService.exp == 0 ? 0.1 : (accountService.exp) / (accountService.level * 10),
          center: Padding(
            padding: const EdgeInsets.all(4),
            child: SvgPicture.string(
              multiavatar(accountService.avatar),
            ),
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
                          decoration: BoxDecoration(color: bgColor.withOpacity(0.5), borderRadius: const BorderRadius.all(Radius.circular(20))),
                          child: Column(children: [
                            const FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text("Scegli il tuo avatar",
                                    style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 36, fontFamily: "ElsieSwashCaps"))),
                            GridAvatars(accountService.allAvatar, accountService.setAvatar),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      accountService.addAvatar();
                                    },
                                    child: const Text("Salva")),
                                const Spacer(flex: 1),
                                ElevatedButton(
                                    onPressed: () {
                                      accountService.generateNewAvatar();
                                    },
                                    child: Text("Genera")),
                              ],
                            )
                          ])),
                    ])));
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: princessPerfumeColor,
            padding: const EdgeInsets.all(12),
          ),
          child: const Icon(Icons.edit),
        )
      ],
    );
  }
}
