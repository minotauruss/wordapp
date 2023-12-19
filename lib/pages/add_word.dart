import 'package:flutter/material.dart';
import 'package:wordapp/models/time_format.dart';
import 'package:wordapp/models/word_model.dart';
import 'package:wordapp/mongo/mongo_db.dart';

class AddWord extends StatefulWidget {
  const AddWord({super.key});

  @override
  State<AddWord> createState() => _AddWordState();
}

class _AddWordState extends State<AddWord> {

 
 

  final _word = TextEditingController();
  final _meanEng = TextEditingController();
  final _meanTurk = TextEditingController();

 

 

  void getTextClear() {
    setState(() {
      

 _word.clear();
 _meanEng.clear();
 _meanTurk.clear();

    });
  }



  Future<void> getSave() async {
    showDialog(
        context: context,
        builder: (context) {
          return const SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });

    DateTime time = DateTime.now();
    final data = WordModel(
        id: _word.text,
        date: TimeFormatNow.dateFormatGAY(time),
        word: _word.text,
        sameMeaningEnglish: _meanEng.text,
        sameMeaningTurkish: _meanTurk.text
    
        );

    try {
      if(_word.text.isNotEmpty && (_meanEng.text.isNotEmpty || _meanTurk.text.isNotEmpty)){
       await MongoDatabase.insertMongoDb(data);
      }
      
    } catch (e) {
      print(e);
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double yukseklik = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word"),
        actions: [
          IconButton(onPressed: ()async{;}, icon: const Icon(Icons.add
          ))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            textDirection: TextDirection.rtl,
            children: [
              getFormField(_word,"Please Enter the Word"),
               getFormField(_meanEng,"Please Enter Similiar Meaning the Word"),
               getFormField(_meanTurk,"Lutfen turkce anlamini giriniz"),

               Container(
                width: MediaQuery.of(context).size.width-48,
                
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: ()async{
                    await getSave();
                  }, child: const Text("SAVE",style: TextStyle(color: Colors.white, fontSize: 18),),),
               )
            ],
          ),
        ),
      )),
   
    );
  }

  void getSaveField() {
   
    
  }

  Widget getFormField(TextEditingController controller, String hintMetin) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintMetin,
            border: const OutlineInputBorder(),
            hintStyle: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
