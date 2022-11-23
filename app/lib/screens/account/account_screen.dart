import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/AccountModel.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountInfo = Provider.of<AccountModel>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/card.png'),
                  radius: 40,
                ),
              ),
              const Divider(
                height: 60,
              ),
              const Text(
                'Nome',
                style: TextStyle(letterSpacing: 2),
              ),
              const SizedBox(height: 10),
              Text(
                accountInfo.name,
                style: const TextStyle(letterSpacing: 2, fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
