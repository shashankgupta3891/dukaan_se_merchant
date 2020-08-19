import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:android/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String phoneNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color d = Color(0x8A1E1D39);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      resizeToAvoidBottomPadding: false,
      body: Builder(
        builder: (BuildContext context) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: kAuthGradient)),
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(
                      flex: 3,
                    ),
                    Container(
                      child: Text('Hello',
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.3)),
                    ),
                    Container(
                      child: RichText(
                          text: TextSpan(
                        text: "There",
                        style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.3),
                        children: [
                          TextSpan(
                              text: ".",
                              style:
                                  TextStyle(fontSize: 60, color: Colors.green))
                        ],
                      )),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (val) => val.length != 10
                            ? 'Phone Number can\'t be less than 10'
                            : null,
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                        style: kTextStyle.copyWith(color: Colors.white),
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: "PHONE NUMBER",
                          labelStyle: TextStyle(color: Colors.white),
                          errorStyle: TextStyle(color: Colors.white),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Center(
                      child: FlatButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: phoneNumber, password: "h");

                              if (user != null) {
                                Navigator.of(context).pushNamed('/teacherDash');
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              setState(() {
                                showSpinner = false;
                              });
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                              print(e);
                            }
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: d,
                          ),
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'New to Mohalla Shops ?',
                            style: TextStyle(
                                fontFamily: 'Montserrat', color: Colors.white),
                          ),
                          SizedBox(width: 5.0),
                        ],
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
