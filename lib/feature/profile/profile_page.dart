import 'package:catapp/feature/auth/signin_page.dart';
import 'package:catapp/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: size.width / 6,
                    ),
                    Expanded(
                      child: Text(user?.email ?? 'email'),
                    )
                  ],
                ),
              ),
              FilledButton(
                onPressed: _signout,
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Sign Out'),
              content: const Text('Are you sure you want to sign out?'),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                FilledButton(
                    onPressed: () {
                      UserRepository.instance.signOut().then((value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInPage()),
                          (Route<dynamic> route) => false,
                        );
                      });
                    },
                    child: const Text('Sign Out')),
              ]);
        });
  }
}
