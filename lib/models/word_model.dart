class WordModel {
  String id;
  String date;
  String word;
String? sameMeaningEnglish;
 String? sameMeaningTurkish;
  int countShow=0;
  int countCorrect=0;
  int countWrong=0;


  int getCountWrong (){
  return countWrong;
}

setCountWrong(int count){
countWrong=count;
}

  
int getCountCorrect (){
  return countCorrect;
}

setCountCorrect(int count){
countCorrect=count;
}


int getCountShow (){
  return countShow;
}

setCountShow(int count){
countShow=count;
}


  WordModel(
      {required this.id,
      required this.date,
      required this.word,
       required sameMeaningEnglish, 
       required sameMeaningTurkish});

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
      id: json["id"].toString(),
      date: json["date"].toString(),
      word: json["word"].toString(),
      sameMeaningEnglish: json["sameMeaningEnglish"],
      sameMeaningTurkish: json["sameMeaningTurkish"],
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "word": word,
        "sameMeaningEnglish": sameMeaningEnglish,
        "sameMeaningTurkish": sameMeaningTurkish,
       
      };
}
