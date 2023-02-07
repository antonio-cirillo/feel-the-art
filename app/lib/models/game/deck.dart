import "package:feel_the_art/models/game/card.dart";

class Deck {
  final String _name;
  final Map<int, Card> _cards;
  final int _unlockLevel;

  Deck._(this._name, this._cards, this._unlockLevel);

  static Deck buildFromJson(Map<String, dynamic> json) {
    Map<int, Card> list = {};

    json["cards"].forEach((el) {
      list.putIfAbsent(el['id'], () => Card.buildFromJson(el));
    });

    return Deck._(json["name"], list, json["unlock_level"]);
  }

  static Map<String, dynamic> debugJson() {
    return {
      "name": "Deck 1",
      "cards": [
        {
          "id": 0,
          "title": "Gioconda_1_1",
          "author": "Leonardo Da Vinci",
          "date": "1503-1506",
          "museum": "Museo del Louvre",
          "description":
              "Opera iconica ed enigmatica della pittura mondiale, si tratta sicuramente del ritratto più celebre della storia nonché di una delle opere d'arte più note in assoluto. Il sorriso quasi impercettibile del soggetto, col suo alone di mistero, ha ispirato tantissime pagine di critica, letteratura, opere di immaginazione e persino studi psicoanalitici; sfuggente, ironica e sensuale, la Monna Lisa è stata di volta in volta amata e idolatrata, ma anche irrisa e vandalizzata."
        },
        {
          "id": 1,
          "title": "Gioconda_1_1",
          "author": "Leonardo Da Vinci",
          "date": "1503-1506",
          "museum": "Museo del Louvre",
          "description":
              "Opera iconica ed enigmatica della pittura mondiale, si tratta sicuramente del ritratto più celebre della storia nonché di una delle opere d'arte più note in assoluto. Il sorriso quasi impercettibile del soggetto, col suo alone di mistero, ha ispirato tantissime pagine di critica, letteratura, opere di immaginazione e persino studi psicoanalitici; sfuggente, ironica e sensuale, la Monna Lisa è stata di volta in volta amata e idolatrata, ma anche irrisa e vandalizzata."
        }
      ],
      "unlock_level": 0
    };
  }

  static Map<String, dynamic> debugListJson() {
    return {
      "list": [
        {
          "name": "Deck 1",
          "cards": [
            {
              "id": 1,
              "title": "Water Lillies",
              "author": "Claude Monet",
              "date": "1916",
              "museum": "The National Museum of Western Arts, Tokyo",
              "description": "Olio su tela. Fa parte di una serie di c. 250 dipinti raffiguranti le ninfee del giardino di casa a Giverny, Francia. I dipinti, completati in circa 30 anni, sono conservati in molti musei del mondo."
            },
            {
              "id": 2,
              "title": "Ballerine alla sbarra",
              "author": "Edgar Degas",
              "date": "1900",
              "museum": "Phillips Collection, Washington",
              "description":
                  "Con il dipinto “Ballerine alla sbarra” il pittore francese riporta sulla tela due ballerine, che ignare dello sguardo esterno, sono impegnate nell’atto di allenarsi alla sbarra: gesti consueti che ritroviamo in tutte le compagnie di ballo."
            },
            {
              "id": 3,
              "title": "Le tre età della donna",
              "author": "Gustav Klimt",
              "date": "1905",
              "museum": "Galleria Nazionale d'Arte Moderna, Roma",
              "description":
                  "Si tratta di un'opera della maturità di Klimt: le figure sono asciutte, sintetiche ed il decorativismo geometrico si materializza in forme che ricordano oro, sete raffinate e pietre preziose. Il tema è una rivisitazione, in chiave simbolica, delle tre fasi della vita femminile: l'infanzia, la maternità e l'inevitabile declino della vecchiaia. "
            },
            {"id": 4, "title": "La battaglia dell'amore", "author": "Cezanne", "date": "1880", "museum": "Collezione privata", "description": ""},
            {"id": 5, "title": "Love the sentinel", "author": "Fragonard", "date": "1773", "museum": "", "description": ""},
            {
              "id": 6,
              "title": "Chiamata degli apostoli Andrea e Pietro",
              "author": "Duccio da Boninsegna",
              "date": "1308-1311",
              "museum": "",
              "description": ""
            },
            {
              "id": 7,
              "title": "Angelo dell'annunciazione",
              "author": "Simone Martini",
              "date": "1333",
              "museum": "Uffizi di Firenze",
              "description":
                  "Nella pala, una ricca cornice dorata, scandita da cinque archi a sesto acuto, accoglie (nella parte centrale) le figure della Vergine e dell’arcangelo Gabriele annunciante e (alle due estremità) le immagini dei santi Ansano e Massima. Quest’ultima è dipinta da Lippo Memmi, il più rappresentativo seguace di Simone Martini, nonché suo cognato e collaboratore."
            },
            {
              "id": 8,
              "title": "Santa Caterina d'Alessandria",
              "author": "Bartolomeo Bulgarini",
              "date": "1337-1378",
              "museum": "Museo Nzionale di S.Matteo",
              "description": ""
            },
            {
              "id": 9,
              "title": "L'annunciazione",
              "author": "Masolino da Panicale",
              "date": "1423-1429",
              "museum": "National Gallery of Art di Washington D.C.",
              "description":
                  "L'angelo è abbigliato sontuosamente e tiene le braccia incrociate in segno di reverenza alla Vergine. Essa è seduta in un trono ed ha in mano il tradizionale attributo del libro, simbolo delle Scritture che si avverano. Con un gesto eloquente sembra accettare con remissione l'incarico affidatole dal Signore, mentre una luce divina le illumina la testa dal soffitto."
            },
            {"id": 10, "title": "Anna e Gioacchino offrono cibo ai poveri", "author": "Andrea di Bartolo", "date": "", "museum": "", "description": ""},
            {
              "id": 11,
              "title": "San Giorgio e il dragone",
              "author": "Rogier van der Weyden",
              "date": "1432-1435",
              "museum": "National Gallery of Art di Washington D.C.",
              "description": ""
            },
            {"id": 12, "title": "Sermone domenicano", "author": "Angolo degli Erri", "date": "", "museum": "", "description": ""},
            {"id": 13, "title": "Adorazione dei magi", "author": "Sandro Botticelli", "date": "1475", "museum": "Uffizi di Firenze", "description": ""},
            {"id": 14, "title": "Le nozze di Cana", "author": "The Master of the Catholic Kings", "date": "1495-1497", "museum": "", "description": ""},
            {
              "id": 15,
              "title": "San martino e il mendicante",
              "author": "Domenikos Theotokopoulos ",
              "date": "1597-1599",
              "museum": "National Gallery of Art, Washington. ",
              "description":
                  "San Martino di Tours con la sua prestigiosa armatura, aiuta un mendicante dividendo il suo mantello, che si trova a sinistra della composizione. I personaggi si trovano su un piccolo spazio di terra. "
            },
            {
              "id": 16,
              "title": "Autoritratto",
              "author": "Vincent Van Gogh",
              "date": "1889",
              "museum": "Museo d'Orsay",
              "description":
                  "Van Gogh dipinse un grande numero di autoritratti durante la sua carriera artistica, e questo è considerato uno dei suoi più belli, se non addirittura il migliore. "
            },
            {
              "id": 17,
              "title": "Notte stellata",
              "author": "Vincent Van Gogh",
              "date": "1889",
              "museum": "Museum of Modern Art, New York",
              "description":
                  "L'immagine possiede una forza straordinaria. A sinistra la scena è chiusa da un cipresso alto e severo che, stagliandosi contro il cielo notturno, agisce come un intermediario vegetale tra la terra e il cielo, tra la vita e la morte: più che un albero sembrerebbe quasi una fiamma scura che divampa all'improvviso alla ricerca dell'infinito. A fianco del solitario cipresso troviamo un piccolo paesino - forse è Saint-Rémy, forse Nuenen"
            },
            {
              "id": 18,
              "title": "Fioritura del mandorlo",
              "author": "Vincent Van Gogh",
              "date": "1890",
              "museum": "Amsterdam, Van Gogh Museum",
              "description": "Protagonista del dipinto una porzione di pochi rami rigogliosi di un mandorlo in fiore."
            },
            {
              "id": 19,
              "title": "Il caffè notturno",
              "author": "Vincent Van Gogh",
              "date": "1888",
              "museum": "Art Gallery dell'Università di Yale, New Haven",
              "description":
                  "Il locale raffigurato è il Café de la Gare, un locale ubicato presso la place Lamartine di Arles dove van Gogh era solito pranzare o trascorrere le serate. La proprietaria di tale bar, madame Ginoux, fu ritratta in vari dipinti vangoghiani"
            },
            {
              "id": 20,
              "title": "La siseta",
              "author": "Paul Gaugin",
              "date": "1892-1894",
              "museum": "New York, Metropolitan Museum of Art",
              "description":
                  "Quattro ragazze polinesiane riposano su di un tavolato di legno al riparo di una veranda molto semplice. Le giovani sono vestite con abiti colorati e parei. Una di loro, in primo piano e di schiena, indossa un cappello di paglia decorato con un nastro. Le altre portano i lunghi capelli neri annodati sulla schiena."
            },
            {
              "id": 21,
              "title": "L'albero della vita",
              "author": "Gustav Klimt",
              "date": "1908-1911",
              "museum": "Vienna, Österreichisches Museum für angewandte Kunst",
              "description":
                  "Trittico della vita è il titolo di un’opera decorativa progettata da Gustav Klimt e composta da tre pannelli. A partire da sinistra, uno dei pannelli esterni raffigura una danzatrice coperta dalle fronde e si intitola L’attesa. La donna porta vistosi gioielli e un abito lungo molto decorato. Il pannello centrale è invece interamente occupato dal tronco dell’albero che si dirama verso i pannelli laterali. Il pannello laterale destro ospita poi la scena di un abbraccio tra un uomo e una donna e si intitola Abbraccio o compimento."
            },
            {"id": 22, "title": "Il bacio", "author": "Gustav Klimt", "date": "", "museum": "", "description": ""},
            {
              "id": 23,
              "title": "Morte e vita",
              "author": "Gustav Klimt",
              "date": "1907-1908",
              "museum": "Österreichische Galerie Belvedere, Vienna ",
              "description":
                  "n uomo e una donna si abbracciano al centro di uno spazio astratto. L’uomo avvolge il viso della donna con le sue mani teneramente e si china sul volto di lei dall’alto. La giovane ha il viso reclinato di lato e poggiato sulla sua spalla sinistra. Il suo braccio destro è sollevato e la mano poggia sul collo dell’uomo. Il braccio sinistro della donna invece è flesso contro la sua spalla. "
            },
            {
              "id": 24,
              "title": "Tuttomondo",
              "author": "Keith Haring",
              "date": "1989",
              "museum": "Chiesa di Sant'Antonio abate",
              "description":
                  "Nella grande opera realizzata da Keith Haring sono presenti 30 figure di omini e animali antropomorfi. A partire dall’alto a sinistra un personaggio sembra incastrarsi all’interno di altre forme. Verso destra si individua poi un altro omino che collega una sua gamba con un braccio passando dal centro del suo corpo. Un altro invece sostiene un delfino sulla spalla e delle forbici umane tagliano un serpente a metà. Tre omini sembrano nascere dalle reciproche teste."
            },
            {"id": 25, "title": "Il bambino radioso", "author": "Keith Haring", "date": "", "museum": "", "description": ""},
            {
              "id": 26,
              "title": "L'urlo",
              "author": "Edvard Munch",
              "date": "1893-1910",
              "museum": "Galleria Nazionale di Oslo",
              "description":
                  "L'urlo rappresenta un sentiero in salita sulla collina di Ekberg[11] sopra la città di Oslo, spesso confuso con un ponte, a causa del parapetto che taglia diagonalmente la composizione; su questo sentiero si sta consumando un urlo lancinante, acuto, che in quest'opera acquisisce un carattere indefinito e universale, elevando la scena a simbolo del dramma collettivo dell'angoscia, del dolore e della paura."
            },
            {
              "id": 27,
              "title": "La persistenza della memoria",
              "author": "Salvator Dalì",
              "date": "1931",
              "museum": "The Museum of Modern Art di New York, ",
              "description":
                  "All’interno di un paesaggio fantastico sono disposti alcuni oggetti irreali. Dominano la scena alcuni orologi dalla consistenza deformata. Sono chiamati, infatti, orologi molli. Pur segnando ancora il tempo, sembrano aver perso la loro solidità"
            },
            {
              "id": 28,
              "title": "The Beautiful Bird Revealing the Unknown to a Pair of Lovers",
              "author": "Jean Mirò",
              "date": "1941",
              "museum": "",
              "description": ""
            },
            {
              "id": 29,
              "title": "Campo di papaveri",
              "author": "Claude Monet",
              "date": "1873",
              "museum": "Parigi, Musée d’Orsay",
              "description":
                  "Un campo di papaveri a sinistra e un prato a destra. In mezzo una donna fende l’erba alta riparandosi con un parasole. La segue un bambino, abbigliato alla moda dell’epoca, che si vede appena tra l’erba alta. Più in alto, sulla sinistra, un’altra signora accompagnata anche lei da un bambino, osserva in basso. All’orizzonte, al sommo del pendio, una corona di alberi e cespugli incorona il verde del prato. In mezzo, poi, si intravede una abitazione di campagna. Il cielo è ampio e denso di nuvole che sembrano correre spinte dal vento. Sembra di percepire l’odore dell’erba calda e secca e il vento caldo estivo scorrere tra le fronde lontane."
            },
            {"id": 30, "title": "Cervo in mezzo ai fiori", "author": "Franz Marc", "date": "", "museum": "", "description": ""},
            {
              "id": 31,
              "title": "Giuseppe Arcimboldo",
              "author": "Il Vertemno",
              "date": "1590",
              "museum": "Castello di Skokloster, Håbo",
              "description":
                  "Vertumno è un dipinto di Giuseppe Arcimboldo del 1590, raffigurante l'imperatore Rodolfo II d'Asburgo come Vertumno, il dio romano del mutamento di stagione, ed è pertanto noto anche come L'imperatore Rodolfo II in veste di Vertumno"
            },
          ],
          "unlock_level": 0
        },
        {"name": "Deck 2", "cards": [], "unlock_level": 1000}
      ]
    };
  }

  String get name => _name;

  int get unlockLevel => _unlockLevel;

  List<Card> get cards => _cards.entries.map((e) => e.value).toList();
  Map<int, Card> get cardsMap => _cards;

  String get cover => "assets/decks/${_name.replaceAll(" ", "_").toLowerCase()}.png";
}
