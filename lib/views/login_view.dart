import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes_yt/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  // This widget is the root of your application.
  @override
  State<LoginView> createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  Future<void> _submit() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    //can error
    try {
      final email = _email.text;
      final password = _password.text;
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('here is your brr nyrr: ${userCredential}');
    } on FirebaseAuthException catch (e) {
      if(e.code == 'invalid-credential') {
        print('Invalid-credential');
      }else {
        print('Something has happened!');
        print(e.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _password,
              obscureText: true, //hidden password
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _submit, child: Text('Login')),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/register/', (route) => false
                );
              }, 
              child: Text('Not register yet? Register here!')
            )
          ],
        ),
      ),
    );
  }
}
