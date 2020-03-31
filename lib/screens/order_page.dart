import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/components/order_card.dart';

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

  List<Widget> myTab = [
    ListView(
      children: <Widget>[
        OrderCards(isPast: true),
        OrderCards(isPast: true),
        OrderCards(isPast: true),
        OrderCards(isPast: true),
        OrderCards(isPast: true),
        OrderCards(isPast: true),
      ],
    ),
    ListView(
      children: <Widget>[
        OrderCards(isPast: false),
        OrderCards(isPast: false),
        OrderCards(isPast: false),
        OrderCards(isPast: false),
        OrderCards(isPast: false),
        OrderCards(isPast: false),
      ],
    ),
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

  @override
  Widget build(BuildContext context) {
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
