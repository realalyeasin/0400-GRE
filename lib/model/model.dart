class WordClass {
  int? id;
  String? word;
  String? meaning;
  String? example;
  String? syn;
  String? ant;
  String? pos;
  dynamic freq;
  int? fvrt;

  WordClass(
      {this.id,
        this.word,
        this.meaning,
        this.example,
        this.syn,
        this.ant,
        this.pos,
        this.freq,
        this.fvrt});

  WordClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    word = json['word'];
    meaning = json['meaning'];
    example = json['example'];
    syn = json['syn'];
    ant = json['ant'];
    pos = json['pos'];
    freq = json['freq'];
    fvrt = json['fvrt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['word'] = this.word;
    data['meaning'] = this.meaning;
    data['example'] = this.example;
    data['syn'] = this.syn;
    data['ant'] = this.ant;
    data['pos'] = this.pos;
    data['freq'] = this.freq;
    data['fvrt'] = this.fvrt;
    return data;
  }

  WordClass.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    word = map['word'];
    meaning = map['meaning'];
    example = map['example'];
    syn = map['syn'];
    ant = map['ant'];
    pos = map['pos'];
    freq = map['freq'];
    fvrt = map['fvrt'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['word'] = this.word;
    data['meaning'] = this.meaning;
    data['example'] = this.example;
    data['syn'] = this.syn;
    data['ant'] = this.ant;
    data['pos'] = this.pos;
    data['freq'] = this.freq;
    data['fvrt'] = this.fvrt;
    return data;
  }


}