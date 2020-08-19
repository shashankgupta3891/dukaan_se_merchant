import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../productDetails.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  String userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  /*void getProducts() async{
    final users = await FirebaseAuth.instance.currentUser();
    userId=users.uid;
    await for(var i in  Firestore.instance.collection("products").where("mId",isEqualTo: users.uid).snapshots()){
      for (var j in i.documents){
        print(j.data);
      }
    }

  }*/
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("products")
          .where("mId", isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final product = snapshot.data.documents;
//          List<Text> productWidget = [];
//          print(product[0].data);
//          for (var p in product) {
//            final productTitle = p.data['t'];
//            final productAmount = p.data['p'];
//            final productQuantity = p.data['q'];
//
//            productWidget.add(Text("${productTitle}"));
//          }

          return GridView.builder(
            itemCount: product.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4),
            itemBuilder: (context, index) {
              String productTitle = product[index].data['t'];
              int productAmount = product[index].data['p'];
              int productQuantity = product[index].data['q'];
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(),
                      ),
                    );
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Image.network(
                            'https://images.pexels.com/photos/4022107/pexels-photo-4022107.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                productTitle,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('Amount'),
                                      Text(
                                        productAmount.toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Quantity'),
                                      Text(
                                        productQuantity.toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Container(
          constraints: BoxConstraints(
            maxWidth: 100,
            minWidth: 50,
            maxHeight: 100,
            minHeight: 50,
          ),
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
