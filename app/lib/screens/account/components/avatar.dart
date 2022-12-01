import 'package:feel_the_art/utils/obj_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:provider/provider.dart';
import '../../../model/account_model.dart';
import '../../../utils/size_config.dart';

class Avatar extends StatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  bool _mod = false;
  bool _gen = false;

  @override
  Widget build(BuildContext context) {
    AccountModel accountInfo = Provider.of<AccountModel>(context);
    if(accountInfo.status != ObjStatus.ready){
      return const Text('Caricamento');
    }
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircularPercentIndicator(
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 3000,
                  radius: SizeConfig.getProportionateScreenWidth(100),
                  lineWidth: SizeConfig.getProportionateScreenWidth(8),
                  startAngle: 180,
                  percent: accountInfo.exp == 0 ? 0.1 : (accountInfo.exp) / (accountInfo.level * 10),
                  center: SvgPicture.string(
                    multiavatar(_gen ? accountInfo.generatedAvatar : accountInfo.avatar),
                    height: SizeConfig.getProportionateScreenWidth(184),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!_mod) {
                      setState(() {
                        _mod = true;
                      });
                    } else {
                      accountInfo.generateNewAvatar();
                      setState(() {
                        _gen = true;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  child: Icon(
                    _mod ? Icons.refresh : Icons.edit,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (_mod)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (_gen) accountInfo.addAvatar();
                        setState(() {
                          _mod = false;
                          _gen = false;
                        });
                      },
                      child: const Text('Salva')),
                  ElevatedButton(
                      onPressed: () => {
                            setState(() {
                              _mod = false;
                              _gen = false;
                            }),
                          },
                      child: const Text('Annulla')),
                ],
              ),
              // Row(
              //   children: [
              //     Expanded(child: GridView.count(crossAxisCount: 4, children: List.generate(4, (index) => Text('$index')),))
              //   ],
              // ),

              Row(
                children: accountInfo.allAvatar
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            GestureDetector(
                              onTap: () {
                                accountInfo.setAvatar(e);
                                setState(() {
                                  _mod = false;
                                  _gen = false;
                                });
                              },
                              child: SvgPicture.string(
                                multiavatar(e),
                                height: SizeConfig.getProportionateScreenWidth(70),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              accountInfo.name,
              style: const TextStyle(letterSpacing: 2, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Livello ${accountInfo.level}',
              style: const TextStyle(letterSpacing: 2),
            ),
          ],
        ),
      ],
    );
  }
}
