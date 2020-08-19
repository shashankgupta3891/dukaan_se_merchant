import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    @required FirebaseAuth auth,
  })  : _auth = auth,
        super();

  final FirebaseAuth _auth;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text(
              'Sign Out',
              textAlign: TextAlign.center,
            ),
            onTap: () async {
              await _auth.signOut();
              await Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
