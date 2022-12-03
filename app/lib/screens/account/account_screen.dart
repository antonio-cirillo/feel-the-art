import 'package:flutter/material.dart';

import '../../utils/size_config.dart';
import 'components/avatar.dart';
import 'components/chart.dart';
import 'components/statistics.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double padding = SizeConfig.getProportionateScreenWidth(20);
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.fromLTRB(padding, padding, padding, 0),
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              const Avatar(),
              Divider(height: padding),
              const Statistics(),
              const ChartWin()
            ],
          ))),
    );
  }
}
