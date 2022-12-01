import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/account_model.dart';
import '../../utils/obj_status.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountInfo = Provider.of<AccountModel>(context);
    if(accountInfo.status != ObjStatus.error){
      return const Text("Caricamento");
    }

    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(flex: 1, child: ElevatedButton(onPressed: () => {accountInfo.addExp(10)}, child: const Text('Add EXP'))),
          ],
        ),
      ),
    );
  }
}
