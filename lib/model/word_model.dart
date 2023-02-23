class WordModel {
  int? id;
  String? word;
  String? meaning;
  String? example;
  String? syn;
  String? ant;
  String? pos;
  String? freq;
  String? fvrt;


  WordModel({required this.id, required this.word, required this.meaning, required this.example,required this.syn, required this.ant,required this.pos, required this.freq, required this.fvrt});

  WordModel.fromMap(dynamic obj) {
    id = obj['contactId'];
    word = obj['word'];
    meaning = obj['meaning'];
    example = obj['example'];
    syn = obj['syn'];
    ant = obj['ant'];
    pos = obj['pos'];
    freq = obj['freq'];
    fvrt = obj['fvrt'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'word': word,
      'meaning': meaning,
      'example':example,
      'syn':syn,
      'ant':ant,
      'pos':pos,
      'freq':freq,
      'fvrt':fvrt,
    };

    return map;
  }
}