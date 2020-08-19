import 'package:android/model/Model.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:android/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:progress_dialog/progress_dialog.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String phoneNumber;
  String dialCode = "+91";
//  ProgressDialog pr;

  List<String> states = [
    "Andhra Pradesh",
    "Arunachal Pradesh ",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Lakshadweep",
    "Delhi NCR",
    "Puducherry"
  ];

  String shopName;
  String address;
  String pinCode;
  String smsCode;
  String verificationID;
  String statesData;

  Future<void> verifyPhone() async {
    print("Number to ${dialCode + phoneNumber}");
    final PhoneCodeAutoRetrievalTimeout autoRetrive = (String verId) {
      this.verificationID = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationID = verId;
      smsCodeDialog(context).then((value) {});
    };
    final PhoneVerificationCompleted verifiedSuccess = (void a) {
      print("verified");
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      print('${exception.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: dialCode + phoneNumber,
        timeout: const Duration(seconds: 20),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verificationFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrive);
  }

  // This function "smsCodeDialog" is used to pop up the alert dialog to enter the OTP / SMS Code
  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
//        final ProgressDialog pr = ProgressDialog(context);
        return new AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text("Enter SMS Code"),
          titlePadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30))),
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
          ),
          contentPadding: EdgeInsets.all(10),
          actions: <Widget>[
            FlatButton(
              child: Text("Done"),
              onPressed: () async {
                final ProgressDialog pr = ProgressDialog(context);
                await pr.show();
                FirebaseAuth.instance.currentUser().then((user) async {
                  if (user != null) {
                    Navigator.of(context).pop();
                    await Navigator.of(context)
                        .pushNamedAndRemoveUntil('/Dash', (r) => false);
                  } else {
                    Navigator.of(context).pop();
                    signIn();
                  }
                });
                await pr.hide();
              },
            )
          ],
        );
      },
    );
  }

  signIn() {
    var _credential = PhoneAuthProvider.getCredential(
        verificationId: verificationID, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(_credential).then((user) async {
      final users = await _auth.currentUser();

      print("${address}");
      print("${users.uid}");
      await MerchantModel(uid: users.uid).updateMerchantData(shopName, address);
      Navigator.of(context).pushReplacementNamed('/Dash');
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    pr = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            return ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: kAuthGradient,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                    elevation: 5,
                    //color: d,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.white,
                            Colors.white,
                          ],
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Center(
                              child: Container(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Sign Up",
                                    style: kTextStyle.copyWith(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.3),
                                    children: [
                                      TextSpan(
                                        text: ".",
                                        style: TextStyle(
                                            fontSize: 60, color: Colors.green),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Spacer(
                              flex: 1,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: CountryCodePicker(
                                      onChanged: (code) {
                                        setState(() {
                                          dialCode = code.dialCode;
                                        });
                                      },
                                      initialSelection: 'IN',
                                      favorite: ['+91'],
                                      showCountryOnly: false,
                                      showOnlyCountryWhenClosed: false,
                                      alignLeft: true,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: TextFormField(
                                      validator: (value) => value.isEmpty
                                          ? "Phone Number cannot be empty"
                                          : null,
                                      onChanged: (value) {
                                        phoneNumber = value;
                                      },
                                      style: kTextStyle,
                                      decoration: kTextFieldDecoration.copyWith(
                                          labelText: 'PHONE NUMBER'),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5),
                              child: TextFormField(
                                validator: (value) => value.length < 6
                                    ? "Shop Name should not be less than 6"
                                    : null,
                                onChanged: (value) {
                                  shopName = value;
                                },
                                style: kTextStyle,
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'SHOP NAME',
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5),
                              child: TextFormField(
                                onChanged: (value) {
                                  address = value;
                                },
                                validator: (value) => value.isEmpty
                                    ? "Address could not be empty"
                                    : null,
                                style: kTextStyle,
                                decoration: kTextFieldDecoration.copyWith(
                                    labelText: 'ADDRESS'),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 5),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        pinCode = value;
                                      },
                                      validator: (value) => value.isEmpty
                                          ? "Pin Code is of 6 digits"
                                          : null,
                                      style: kTextStyle,
                                      decoration: kTextFieldDecoration.copyWith(
                                          labelText: 'PIN CODE'),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'STATE',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    value: statesData,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.black26,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        statesData = newValue;
                                      });
                                    },
                                    items: states.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),

                            Spacer(
                              flex: 1,
                            ),

                            RaisedButton(
                              color: kSecondaryColor,
//                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    //  final newUser =await _auth.createUserWithEmailAndPassword(email: phoneNumber, password: shopName);
                                    await verifyPhone();
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
                            ),

                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  'By clicking on Sign Up, you agree to our Terms and Conditions',
                                  style: kTextStyle.copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                            //Spacer(flex: 3,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
