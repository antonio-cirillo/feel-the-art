import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:multiavatar/multiavatar.dart";
import "package:percent_indicator/percent_indicator.dart";
import "package:provider/provider.dart";

import "package:feel_the_art/theme/theme.dart";
import "package:feel_the_art/services/account_service.dart";

import 'package:feel_the_art/components/user/_parts/grid_avatars.dart';

class Avatar extends StatefulWidget {
  final double dim;

  const Avatar({Key? key, required this.dim}) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  bool modActive = false;

  void setModActive(bool val) {
    setState(() {
      modActive = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AccountService accountService = Provider.of<AccountService>(context);

    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircularPercentIndicator(
              progressColor: maizeColor,
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 3000,
              radius: widget.dim,
              lineWidth: widget.dim,
              startAngle: 180,
              percent: accountService.exp == 0 ? 0.1 : (accountService.exp) / (accountService.level * 10),
              center: Padding(
                padding: const EdgeInsets.all(4),
                child: SvgPicture.string(
                  multiavatar(modActive ? accountService.generatedAvatar : accountService.avatar),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setModActive(false);
                showGeneralDialog(
                  barrierDismissible: true,
                  barrierLabel: "Avatar",
                  context: context,
                  pageBuilder: (context, _, __) => Container(
                    padding: const EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: MediaQuery.of(context).padding.top + 40),
                    decoration: BoxDecoration(color: bgColor.withOpacity(0.5), borderRadius: const BorderRadius.all(Radius.circular(20))),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text("Scegli il tuo avatar", style: Theme.of(context).textTheme.headlineMedium?.merge(titleStyle).merge(whiteText)),
                        ),
                        GridAvatars(),
                        ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Chiudi")),
                      ],
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: princessPerfumeColor,
                padding: const EdgeInsets.all(12),
              ),
              child: const Icon(Icons.edit),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            direction: Axis.horizontal,
            children: [
              ElevatedButton(
                onPressed: () {
                  accountService.generateNewAvatar();
                  setModActive(true);
                },
                child: Text("Genera Avatar!"),
              ),
            ],
          ),
        ),
        Visibility(
          visible: modActive,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  accountService.addAvatar();
                  setModActive(false);
                },
                child: Text("Salva"),
              ),
              ElevatedButton(
                onPressed: () => setModActive(false),
                child: Text("Annulla"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
