class Quiz {
  final int _id, _correctAnswer;
  final String _imageUrl, _question;
  final List<String> _answers;

  Quiz._(this._id, this._imageUrl, this._question, this._correctAnswer, this._answers);

  static Quiz buildFromJson(Map<String, dynamic> json) {
    return Quiz._(
      json["id"],
      json["image_url"],
      json["question"],
      json["correct_answer"],
      json["answers"],
    );
  }

  static Map<String, dynamic> debugListJson() {
    return {
      "list": [
        {
          "id": 0,
          "image_url": "",
          "question": "Cos'è l'arte?",
          "correct_answer": 1,
          "answers": [
            "È l'insieme delle tecniche per il disegno e la scultura",
            "Ogni forma di creativita' ed espressivita' estetica",
            "Il talento che ha ogni individuo",
            "Cio' che non è scienza"
          ]
        },
        {
          "id": 1,
          "image_url": "",
          "question": "Qual era il nome di Van Gogh?",
          "correct_answer": 2,
          "answers": ["Erik", "Dirk-Pieter", "Vincent", "Gert"]
        },
        {
          "id": 2,
          "image_url": "",
          "question": "Una caratteristica degli impressionisti è...",
          "correct_answer": 0,
          "answers": [
            "rappresentare la realta', usando la luce per attrarre lo sguardo immediatamente",
            "l'uso dei colori scuri",
            "dare vitalita' ai dipinti",
            "la raffigurazione di nature morte"
          ]
        },
        {
          "id": 3,
          "image_url": "",
          "question": "Qual è il museo d'arte piu' importante di Firenze?",
          "correct_answer": 3,
          "answers": ["Pinacoteca di Brera", "Museo di Capodimonte", "MoMA", "Galleria degli Uffizi"]
        },
        {
          "id": 4,
          "image_url": "",
          "question": "Dove si trova il Museo del Louvre?",
          "correct_answer": 1,
          "answers": ["A Londra", "A Parigi", "A Bruxelles", "A Ginevra"]
        },
        {
          "id": 5,
          "image_url": "",
          "question": "Dove si trova la National Gallery?",
          "correct_answer": 2,
          "answers": ["A New York", "A San Francisco", "A Londra", "A Sydney"]
        },
        {
          "id": 6,
          "image_url": "",
          "question": "Dove si puo' ammirare  la 'Monna Lisa'?",
          "correct_answer": 0,
          "answers": ["Al Louvre, Parigi", "Alle Scuderie del Quirinale, Roma", "Agli Uffizi, Firenze", "Alla National Gallery, Londra"]
        },
        {
          "id": 7,
          "image_url": "",
          "question": "Che colore è 'vermiglio'?",
          "correct_answer": 3,
          "answers": ["Una tonalita' di verde", "Una tonalita' di giallo", "Una tonalita' di  rosa", "Una tonalita' di rosso"]
        },
      ]
    };
  }

  int get id => _id;
  String get imageUrl => _imageUrl;
  int get correctAnswer => _correctAnswer;
  List<String> get answers => _answers;
  String get question => _question;
}
