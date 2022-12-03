import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/account_model.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountInfo = Provider.of<AccountModel>(context);

    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: ElevatedButton(
                    onPressed: () => {accountInfo.addExp(10)},
                    child: const Text('Add EXP'))),
          ],
        ),
      ),
    );
  }
}
