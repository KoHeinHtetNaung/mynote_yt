import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() {
    return VerifyEmailViewState();
  }
}

class VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verfied Mail',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Text('Please verify your email address!'),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;

                await user?.sendEmailVerification();
                print('Please check your email box!');
              },
              child: const Text('Send email verification')),
        ],
      ),
    );
  }
}
