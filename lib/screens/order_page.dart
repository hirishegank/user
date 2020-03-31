import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/components/order_card.dart';
import 'package:user/screens/order_confirmation.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
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
    _tabController = TabController(vsync: this, length: myTabsLables.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void callback(past) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OrderConfirmPage(
              isPast: past,
            )));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> myTab = [
      ListView(
        children: <Widget>[
          OrderCards(isPast: true, onTap: () => callback(true)),
          OrderCards(isPast: true, onTap: () => callback(true)),
          OrderCards(isPast: true, onTap: () => callback(true)),
          OrderCards(isPast: true, onTap: () => callback(true)),
          OrderCards(isPast: true, onTap: () => callback(true)),
          OrderCards(isPast: true, onTap: () => callback(true)),
        ],
      ),
      ListView(
        children: <Widget>[
          OrderCards(isPast: false, onTap: () => callback(false)),
          OrderCards(isPast: false, onTap: () => callback(false)),
          OrderCards(isPast: false, onTap: () => callback(false)),
          OrderCards(isPast: false, onTap: () => callback(false)),
          OrderCards(isPast: false, onTap: () => callback(false)),
          OrderCards(isPast: false, onTap: () => callback(false)),
        ],
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
