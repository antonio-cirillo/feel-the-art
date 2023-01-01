import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:feel_the_art/services/account_service.dart";

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountService accountService = Provider.of<AccountService>(context);

    return Column(
      children: const [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Statistiche",
            style: TextStyle(
                letterSpacing: 2, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        // ColumnLabel(image: "/assets/images/card.png", text: "Partite giocate: ${accountService.totalGames}"),
        // ColumnLabel(image: "/assets/images/card.png", text: "Primi posti: ${accountService.firstPlaces}"),
        // ColumnLabel(image: "/assets/images/card.png", text: "Secondi posti: ${accountService.secondPlaces}"),
        // ColumnLabel(image: "/assets/images/card.png", text: "Terzi posti: ${accountService.thirdPlaces}"),
        // ColumnLabel(image: "/assets/images/card.png", text: "Partite perse: ${accountService.loseGames}"),
      ],
    );
  }
}
