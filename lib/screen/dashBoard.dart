import 'package:android/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'addProduct.dart';
import 'home/drawer.dart';
import 'home/product.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  bool isVisible = false;

  TabController _tabController;
  final List<Tab> myTabs = [
    Tab(icon: Icon(Icons.directions_car)),
    Tab(icon: Icon(Icons.directions_transit)),
  ];
  @override
  void initState() {
    super.initState();
    checkUser();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  checkUser() async {
    final user = await _auth.currentUser();
    if (user != null) {
      print(user.phoneNumber);
    } else {
      print("new device");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          backgroundColor: kSecondaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            print("Hello");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProduct()),
            );
          },
        ),
      ),
      drawer: CustomDrawer(auth: _auth),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
//        actions: [
//          IconButton(
//            icon: Icon(Icons.call_missed_outgoing),
//            onPressed: () async {
//              await _auth.signOut();
//              await Navigator.of(context)
//                  .pushNamedAndRemoveUntil('/login', (route) => false);
//            },
//          )
//        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.yellow,
//          indicatorWeight: 5,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.swap_vertical_circle),
              text: 'Order',
            ),
            Tab(icon: Icon(Icons.shopping_cart), text: 'Products'),
          ],
          onTap: (index) {
            setState(() {
              isVisible = index == 1;
            });
          },
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [Icon(Icons.directions_car), Products()],
      ),
    );
  }
}
