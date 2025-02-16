import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes_yt/firebase_options.dart';
import 'package:mynotes_yt/views/login_view.dart';
import 'package:mynotes_yt/views/register_view.dart';
import 'package:mynotes_yt/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      routes: {
        '/login/': (context) => LoginView(),
        '/register/': (context) => RegisterView(),
      },
    )
  );
  
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform
        ), 
        builder: (context, snapshot)  {
          switch (snapshot.connectionState) {            
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if(user != null) {
                if(user.emailVerified) {
                  print("Email is verified");
                }else {
                  return VerifyEmailView();
                }
              }else {
                return LoginView();
              }
              return RegisterView();
            default:
              return CircularProgressIndicator();
          }
        }
      );
  }
}





