import 'package:firebase_auth/firebase_auth.dart';
import 'package:dreamy_tales/auth.dart';
import 'package:flutter/material.dart';
import 'package:dreamy_tales/pages/welcome_page.dart';

class HomePage extends StatelessWidget{
  HomePage({Key? key}) : super(key:key);
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }
  Widget _title(){
    return const Text('Dreamy Tales');
  }
  Widget _userUid(){
    return Text(user?.email ?? 'User email');
  }
  Widget _signOutButton(){
    return ElevatedButton(
        onPressed: signOut,
        child: const Text('Sign Out'),
    );
  }
  Widget _welcomeButton(BuildContext context){
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    },
    child: const Text('Welcome'),
  );
}
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _userUid(),
            _signOutButton(),
            _welcomeButton(context),
          ]
        )
      )
    );
  }
}