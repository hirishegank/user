import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:user/components/order_card.dart';
import 'package:user/screens/order_confirmation.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  FirebaseUser _firebaseUser;

  void getCurrentUser() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser();
    setState(() {});
  }

  final List<Tab> myTabsLables = <Tab>[
    Tab(
      text: 'Past',
    ),
    Tab(text: 'Ongoing'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _tabController = TabController(vsync: this, length: myTabsLables.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void callback(past, foodId, qrCode, orderId, aleradyReviewd) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OrderConfirmPage(
              foodId: foodId,
              isPast: past,
              qrCode: qrCode,
              orderId: orderId,
              isAlredyReviwed: aleradyReviewd,
            )));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> myTab = [
      //past tab
      _firebaseUser != null
          ? StreamBuilder(
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.documents[index];
                      print(ds.data['status']);
                      return OrderCards(
                          foodId: ds.data['food_id'],
                          isPast: true,
                          isAccepted: ds.data['status'] == 'on_going',
                          onTap: () => callback(
                              true,
                              ds.data['food_id'],
                              ds.data['qr_code'],
                              ds.documentID,
                              ds.data['reviewed']));
                    });
              },
              stream: Firestore.instance
                  .collection('orders')
                  .where(
                    'user_id',
                    isEqualTo: _firebaseUser.uid,
                  )
                  .where('status', isEqualTo: 'past')
                  .snapshots(),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),

      //pending tab
      _firebaseUser != null
          ? StreamBuilder(
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.documents[index];
                      print(ds.data['status']);

                      return OrderCards(
                          foodId: ds.data['food_id'],
                          isPast: false,
                          isAccepted: ds.data['status'] == 'on_going',
                          onTap: () => callback(false, ds.data['food_id'],
                              ds.data['qr_code'], ds.documentID, true));
                    });
              },
              stream: Firestore.instance
                  .collection('orders')
                  .where(
                    'user_id',
                    isEqualTo: _firebaseUser.uid,
                  )
                  .where('status',
                      whereIn: ['pending', 'on_going']).snapshots(),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: TextStyle(
              fontFamily: 'Muli', fontWeight: FontWeight.bold, fontSize: 15),
          controller: _tabController,
          tabs: myTabsLables,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTab,
      ),
    );
  }
}
