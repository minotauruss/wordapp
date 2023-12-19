import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wordapp/models/word_model.dart';
import 'package:wordapp/mongo/mongo_db.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<WordModel>? wordListModel = [];
  List<String> wordListCovertoList = [];
  List<String> wordListCovertoList2 = [];
  List<WordModel> wordList = [
    WordModel(
        id: "",
        date: "date",
        word: "first",
     
        sameMeaningEnglish: "English Meanings",
        sameMeaningTurkish: "Turkce anlamlari")
  ];
  bool isLoad = false;
  List<String> setWordList = [];
  String correctWord = "word";
  bool isMatch = false;
  int nextCount = 0;
  int indeks = 0;
  bool helpBool = false;

  @override
  void initState() {
    super.initState();
    getData();
    getShuffledWord(wordList[0].word);
  }

  getData() async {
    if (isLoad == false) {
      wordListModel = await MongoDatabase.getDataModel();

      if (wordListModel != null) {
        for (var item in wordListModel!) {
          setState(() {
            wordList.add(item);
          });
        }
      }
      setState(() {
        isLoad = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Game"),
      ),
      body: SafeArea(
          child: isLoad == false
              ? Center(child: CircularProgressIndicator())
              : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: IconButton(
                            onPressed: getHelp,
                            icon: const Icon(
                              Icons.help,
                              size: 48,
                            )),
                      ),
                      Container(
                        height: 150,
                        child:  Text(isMatch ? "Doğru" : "Yanlış", style: TextStyle(
                          color: isMatch? Colors.green : Colors.red,fontSize: 24,fontWeight: FontWeight.bold
                        ), ),
                      ),
                      Container(
                         padding: const EdgeInsets.symmetric(horizontal: 48,vertical: 48),
                               margin: EdgeInsets.symmetric(
                          horizontal: (MediaQuery.of(context).size.width -
                                  (wordListCovertoList.length *
                                      ((300 / wordListCovertoList.length) +
                                          6.0))) /
                              2,
                        ),
                        alignment: Alignment.center,
                        
                        color: Colors.purple.shade100,
                        child: Text(wordList[nextCount].sameMeaningTurkish ?? "anlami bulunamiyor")
                      ),
                      Container(
                       
                        alignment: Alignment.center,
                        height: 64,
                        margin:        EdgeInsets.symmetric(vertical: 48,
                          horizontal: (MediaQuery.of(context).size.width -
                                  (wordListCovertoList.length *
                                      ((300 / wordListCovertoList.length) +
                                          6.0))) /
                              2,
                        ),
                        width: MediaQuery.of(context).size.width - 48,
                        decoration: BoxDecoration(
                            color: isMatch ? Colors.green : Colors.red),
                        child: Text(
                          textAlign: TextAlign.center,
                          correctWord,
                          style: const TextStyle(color: Colors.white, fontSize: 32),
                        ),
                      ),
                      Container(
                        height: 64,
                        margin: EdgeInsets.symmetric(
                          horizontal: (MediaQuery.of(context).size.width -
                                  (wordListCovertoList.length *
                                      ((300 / wordListCovertoList.length) +
                                          6.0))) /
                              2,
                        ),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: wordListCovertoList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  getSetWordList(wordListCovertoList[index]);

                                  setState(() {
                                    if (wordListCovertoList.length == 1) {
                                      getMatch();
                                      wordListCovertoList =
                                          wordListCovertoList2;
                                    } else {
                                      wordListCovertoList
                                          .remove(wordListCovertoList[index]);
                                    }

                                    indeks = index;
                                  });
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(horizontal: 3),
                                    height: 300 / wordListCovertoList.length,
                                    width: 300 / wordListCovertoList.length,
                                    color: Colors.grey,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      wordListCovertoList[index],
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    )),
                              );
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.all(24),
                        child: getButton(),
                      )
                    ],
                  ),
                )),
    );
  }

  void getShuffledWord(String data) {
    for (var item in data.characters) {
      setState(() {
        wordListCovertoList.add(item);
        wordListCovertoList2.add(item);
      });
    }

    wordListCovertoList.shuffle();
  }

  void getSetWordList(String word) {
    if (helpBool == false) {
      setState(() {
        setWordList.add(word);
        correctWord = setWordList.join("");
      });
    } else {
      setState(() {
        helpBool = false;

        setWordList.add(word);
        correctWord = setWordList.join("");
      });
    }
  }

  void getHelp() {
    setState(() {
      helpBool = true;
    });
    if (helpBool == true) {
      correctWord = wordListCovertoList2[0];
      setWordList.add(correctWord);
      wordListCovertoList.remove(correctWord);
      helpBool = true;
    }
  }

  void getMatch() {
    if (wordListCovertoList2.join("").toLowerCase() ==
        correctWord.toLowerCase()) {
      setState(() {
        isMatch = true;
        getCorrectShow();
        
       
      });
    } else {
      setState(() {
        isMatch = false;
      });
    }
  }

  getNext() {
    if (nextCount < wordList.length-1) {
      setState(() {
        nextCount = nextCount + 1;
        correctWord = "Word";
        setWordList = [];
        isMatch = false;
        wordListCovertoList = [];

        wordListCovertoList2 = [];
      });

      getShuffledWord(wordList[nextCount].word);
    }
  }

  Widget getButton() {
    return ElevatedButton(
      
      onPressed: getNext, child: Text("Next"));
  }


   getCorrectShow(){
    return showDialog(context: context, builder: (BuildContext context){
     return const AlertDialog(
       
          content: Icon(Icons.done, size: 48,color: Colors.green,) );
          

    });
    
  }
}
