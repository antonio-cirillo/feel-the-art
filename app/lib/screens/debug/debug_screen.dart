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
              flex: 7,
              child: ElevatedButton(
                onPressed: () => {accountInfo.addExp(10)},
                child: const Text('Add EXP'),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(
                      width: 70,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: InkWell(
                        onTap: () async {
                          // to do
                        },
                        child: Container(
                          width: 90,
                          height: 90,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/card.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(
                      width: 70,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: InkWell(
                        onTap: () async {
                          //To do

                        },
                        child: Container(
                          width: 90,
                          height: 90,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/user7.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
            // Expanded(
            //   flex: 1,
            //   child: ElevatedButton(
            //     onPressed: () => Navigator.pop(context),
            //     child: const Text('POP'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
