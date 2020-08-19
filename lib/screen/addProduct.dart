import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:android/constants.dart';
import 'file:///C:/Users/shash/OneDrive/Desktop/flutterProjects/android/lib/model/Model.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String title;
  String des;
  int price;
  int quantity;
  addItem() async {
    final users = await FirebaseAuth.instance.currentUser();
    await ProductModel(merchantUID: users.uid)
        .addProduct(title, des, price, quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Add Product/Services"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Product Display Name',
                        style: kAddProductTextStyle,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      style: kTextStyle.copyWith(color: Colors.black),
                      decoration: kAddProductInputDecoration.copyWith(
                          hintText: 'Ex:- Mango'),
                      validator: (value) =>
                          value.isEmpty ? "Name cannot be empty" : null,
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Product Description (if any)',
                        style: kAddProductTextStyle,
                      ),
                    ),
                    TextFormField(
                      maxLines: 4,
                      decoration: kAddProductInputDecoration.copyWith(
                          hintText: 'Ex:- This is Mango from USA'),
                      onChanged: (value) {
                        des = value;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Product Amount',
                        style: kAddProductTextStyle,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: false,
                        signed: false,
                      ),
                      decoration: kAddProductInputDecoration.copyWith(
                          hintText: 'Ex:- 323'),
                      validator: (value) =>
                          value.isEmpty ? "Amount cannot be empty" : null,
                      onChanged: (value) {
                        price = int.parse(value);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Product Quantity',
                        style: kAddProductTextStyle,
                      ),
                    ),
                    TextFormField(
                      validator: (v) {
                        if (v.isEmpty == true) {
                          return 'Please Enter';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: kAddProductInputDecoration.copyWith(
                          hintText: 'Ex:- 23'),
                      onChanged: (value) {
                        quantity = int.parse(value);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: RaisedButton(
                  color: kSecondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      final ProgressDialog pr = ProgressDialog(context);
                      try {
                        pr.show();
                        await addItem();
                      } catch (e) {
                        print(e);
                      }
                      pr.hide();
                      Navigator.pop(context);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
