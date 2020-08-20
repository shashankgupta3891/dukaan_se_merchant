import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sliver_fab/sliver_fab.dart';

import '../constants.dart';

class ProductDetails extends StatefulWidget {
  final String title;
  final String des;
  final int amount;
  final int quantity;

  ProductDetails({
    @required this.quantity,
    @required this.des,
    @required this.title,
    @required this.amount,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleTextController;
  TextEditingController desTextController;
  TextEditingController priceTextController;
  TextEditingController quantityTextController;

  bool readOnly = true;
  FocusNode focusNode;

  Function onEditing;
  Function onSaving;

  @override
  void initState() {
    super.initState();

    titleTextController = TextEditingController(text: widget.title);
    desTextController = TextEditingController(text: widget.des);
    priceTextController = TextEditingController(text: widget.amount.toString());
    quantityTextController =
        TextEditingController(text: widget.quantity.toString());

    onEditing = () {
      setState(() {
        readOnly = true;
      });
    };
    onSaving = () {
      setState(() {
        readOnly = false;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomInset: false,
//      resizeToAvoidBottomPadding: false,
      body: Builder(
        builder: (context) {
          return SliverFab(
//            topScalingEdge: 0,
            floatingWidget: FloatingActionButton(
              backgroundColor: readOnly ? kSecondaryColor : kPrimaryColor,
              child: Icon(readOnly ? Icons.edit : Icons.save),
              onPressed: readOnly ? onSaving : onEditing,
            ),
            slivers: [
              SliverAppBar(
//                elevation: 20,
                backgroundColor: Colors.white,
                expandedHeight: 256.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("SliverFab Example"),
                  background: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://images.pexels.com/photos/264636/pexels-photo-264636.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                          fit: BoxFit.fitHeight,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.black45),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
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
                                controller: titleTextController,
                                focusNode: focusNode,
                                readOnly: readOnly,
                                keyboardType: TextInputType.name,
                                style: kTextStyle.copyWith(color: Colors.black),
                                decoration: kAddProductInputDecoration.copyWith(
                                    hintText: 'Ex:- Mango'),
                                validator: (value) => value.isEmpty
                                    ? "Name cannot be empty"
                                    : null,
//                                onChanged: (value) {
//                                  title = value;
//                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
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
                                controller: desTextController,
                                readOnly: readOnly,
                                maxLines: 4,
                                decoration: kAddProductInputDecoration.copyWith(
                                    hintText: 'Ex:- This is Mango from USA'),
//                                onChanged: (value) {
//                                  des = value;
//                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
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
                                controller: priceTextController,
                                readOnly: readOnly,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: false,
                                  signed: false,
                                ),
                                decoration: kAddProductInputDecoration.copyWith(
                                    hintText: 'Ex:- 323'),
                                validator: (value) => value.isEmpty
                                    ? "Amount cannot be empty"
                                    : null,
//                                onChanged: (value) {
//                                  price = int.parse(value);
//                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
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
                                controller: quantityTextController,
                                readOnly: readOnly,
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
//                                onChanged: (value) {
//                                  quantity = int.parse(value);
//                                },
                              ),
                            ],
                          ),
                        ),
//                        Padding(
//                          padding: EdgeInsets.symmetric(vertical: 15),
//                          child: RaisedButton(
//                            color: kSecondaryColor,
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(20),
//                            ),
//                            child: Text(
//                              "Save",
//                              style: TextStyle(
//                                color: Colors.white,
//                                fontSize: 18,
//                                fontWeight: FontWeight.bold,
//                              ),
//                            ),
//                            onPressed: () async {
////                              if (_formKey.currentState.validate()) {
////                                final ProgressDialog pr = ProgressDialog(context);
////                                try {
////                                  pr.show();
////                                  await addItem();
////                                } catch (e) {
////                                  print(e);
////                                }
////                                pr.hide();
////                                Navigator.pop(context);
////                              }
//                            },
//                          ),
//                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
