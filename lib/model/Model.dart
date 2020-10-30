import 'package:cloud_firestore/cloud_firestore.dart';

class MerchantModel {
  final String uid;
  MerchantModel({this.uid});

  final CollectionReference merchantCollection =
      Firestore.instance.collection('merchants');
  Future updateMerchantData(String shopname, String address) async {
    return await merchantCollection
        .document(uid)
        .updateData({'sn': shopname, 'a': address});
  }
}
class CustomerModel {
  final String uid;
  CustomerModel({this.uid});

  final CollectionReference merchantCollection =
      Firestore.instance.collection('merchants');
  Future updateMerchantData(String shopname, String address) async {
    return await merchantCollection
        .document(uid)
        .updateData({'sn': shopname, 'a': address});
  }
}
class ProductModel {
  final String merchantUID;
  ProductModel({this.merchantUID});
  final CollectionReference merchantCollection =
      Firestore.instance.collection('merchants');
  Future addProduct(String title, String des, int price, int quantity) async {
    return await Firestore.instance.collection('products').add({
      "mId": merchantUID,
      "t": title,
      "d": des,
      "q": quantity,
      "p": price
    }).then((value) async {
      return await merchantCollection.document(merchantUID).setData({
        'products': FieldValue.arrayUnion([value.documentID]),
      });
    });
  }
}

// Newly Added
class ServiceModel {
  final String merchantUID;
  ProductModel({this.merchantUID});
  final CollectionReference merchantCollection =
      Firestore.instance.collection('merchants');
  Future addProduct(String title, String des, int price, int quantity) async {
    return await Firestore.instance.collection('services').add({
      "mId": merchantUID,
      "t": title,
      "d": des,
      "q": quantity,
      "p": price
    }).then((value) async {
      return await merchantCollection.document(merchantUID).setData({
        'service': FieldValue.arrayUnion([value.documentID]),
      });
    });
  }
}
