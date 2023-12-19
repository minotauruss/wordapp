import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


 
   String errorMessageEmail = "";
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();



  Future<UserCredential?> googleSignUp() async{
    try {
      GoogleAuthProvider _auth  = GoogleAuthProvider();
      await FirebaseAuth.instance.signInWithProvider(_auth);
      
     
    } on FirebaseAuthException catch (e) {
      print(e.code);
      
    }
  }

  void register() async {
    try {
        showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailControl.text, password: passwordControl.text);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  signUp() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailControl.text, password: passwordControl.text);

          // ignore: use_build_context_synchronously
          Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print(e.code);
     if(e.code == 'invalid-credential'){
 wrongEmail();
     }
    }
  }

  wrongEmail(){
    showDialog(context: context, builder: (context){
      return const AlertDialog(content: Text("Wrong Email address or Password!"),);
    });
  }



  @override
  Widget build(BuildContext context) {
    //bool _isKeyBoard = MediaQuery.of(context).viewInsets.bottom == 100;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
             const SizedBox(
              height: 16,
            ),
            const Icon(
              LineAwesomeIcons.user_lock,
              size: 100,
            ),
          const SizedBox(
                 height: 16,
            ),
            const Text(
              "Word App Uygulamasina Hoşgeldınız",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: emailControl,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: passwordControl,
                decoration:  const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width - 48,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      textStyle: const TextStyle(color: Colors.white10),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    onPressed: signUp,
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ))),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width - 48,
                child: SignInButton(Buttons.google, onPressed: googleSignUp, text: "Sign In with Goole",)),
          ],
        ),
      )),
    );
  }
}
