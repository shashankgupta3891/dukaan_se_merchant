import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WaitingScreen extends StatefulWidget {
  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  checkUser() async {
    final user = await _auth.currentUser();
    if (user != null) {
      print(user.phoneNumber);
      Navigator.of(context).pushNamedAndRemoveUntil('/Dash', (r) => false);
    } else {
      print("new device");
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.deepPurple,
    );
  }
}
