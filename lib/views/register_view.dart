import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes_yt/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() {
    return _RegisterViewState();
  }
}

class _RegisterViewState extends State<RegisterView> {
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
      options: DefaultFirebaseOptions.currentPlatform,
    );

    try {
      final email = _email.text;
      final password = _password.text;
      //create user
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print('Here your credential ${userCredential}');
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        print('Weak password!');
      } else if (e.code == 'email-already-in-use') {
        print('Email already use!');
      } else {
        print(e.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
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
                  labelStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _password,
              obscureText: true, //hidden password
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _submit, child: Text('Register')),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login/', 
                  (route) => false
                );
              },
              child: const Text('Already register? Login here!')
            )
          ],
        ),
      ),
    );
  }
}
