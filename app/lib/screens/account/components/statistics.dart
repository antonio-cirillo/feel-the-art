import 'package:feel_the_art/screens/_common/column_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../model/account_model.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AccountModel accountInfo = Provider.of<AccountModel>(context);

    return Column(
      children: const [
         Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Statistiche',
            style: TextStyle(letterSpacing: 2, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        // ColumnLabel(image: '/assets/images/card.png', text: 'Partite giocate: ${accountInfo.totalGames}'),
        // ColumnLabel(image: '/assets/images/card.png', text: 'Primi posti: ${accountInfo.firstPlaces}'),
        // ColumnLabel(image: '/assets/images/card.png', text: 'Secondi posti: ${accountInfo.secondPlaces}'),
        // ColumnLabel(image: '/assets/images/card.png', text: 'Terzi posti: ${accountInfo.thirdPlaces}'),
        // ColumnLabel(image: '/assets/images/card.png', text: 'Partite perse: ${accountInfo.loseGames}'),
      ],
    );
  }
}
