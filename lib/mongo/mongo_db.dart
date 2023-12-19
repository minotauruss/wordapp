import 'package:firebase_auth/firebase_auth.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:wordapp/models/constant.dart';
import 'package:wordapp/models/user_model.dart';
import 'package:wordapp/models/word_model.dart';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
  }

  static Future<String> insertMongoDb(WordModel wordModel) async {
    final user = FirebaseAuth.instance.currentUser;
    await db.open();
    if (user != null) {
      userCollection = db.collection(user.uid);
    }
    try {
      var result = await userCollection.insertOne(wordModel.toJson());
      if (result.isSuccess) {
        return "data kaydedildi";
      } else {
        return "data kaydedilemedi";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<List<WordModel>?> getDataModel()async{
    List<WordModel> wordModelList = [];
     final user = FirebaseAuth.instance.currentUser;
     await db.open();
      if (user != null) {
      userCollection = db.collection(user.uid);
    }
    try {
     final users = await userCollection.find().toList();
    

   if(users != null){
      for(var item in users){
       
      WordModel userModelConvert =  WordModel.fromJson(item);
      wordModelList.add(userModelConvert);
     }
   }

     return wordModelList;

      
    } catch (e) {
      print(e);
      
    }


  }
}
