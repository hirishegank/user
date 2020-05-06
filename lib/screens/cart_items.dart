import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/components/big_button.dart';

import 'package:user/components/home_category_buttom.dart';
import 'package:user/models/cart.dart';
import 'package:user/screens/bottom_navigation.dart';
import 'package:user/screens/customize_screen.dart';
import 'package:user/screens/delivery_option.dart';
import 'package:user/screens/dinein_option.dart';
import 'dart:math';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double total = 0;

  FirebaseUser _firebaseUser;

  void getCurrentUser() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser();
  }

  String _randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  CartItemCard foodListBuilder(food) {
    int index = cart.foods.indexOf(food);
    return CartItemCard(
      qty: food.quantity,
      foodId: food.id,
      index: index,
      changeSum: _setTotal,
    );
  }

  double _getTotal() {
    double sum = 0;
    cart.foods.forEach((food) {
      sum += food.price * food.quantity;
    });
    this.total = sum;
    return sum;
  }

  _setTotal() {
    double sum = _getTotal();
    setState(() {
      this.total = sum;
    });
  }

  _hitFirebase() {
    cart.foods
        .map((food) {
          print(food.removedIngrediants);
          return {
            'qr_code': _randomString(20),
            'dine_in': food.dineIn,
            'delivery_address': food.address,
            'delivery_opthion': food.deliveryOption,
            'chef_id': food.chefId,
            'food_id': food.id,
            'removed_ingrediance': food.removedIngrediants,
            'extran_notes': food.extraNote,
            'delivery_fee': food.price * food.quantity * 0.1,
            'quantity': food.quantity,
            'unit_price': food.price,
            'status': 'pending',
            'user_id': _firebaseUser.uid,
            'reviewed': false
          };
        })
        .toList()
        .forEach((order) => Firestore.instance.collection('orders').add(order));
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        title: Text('Cart Items'),
        elevation: 0,
        centerTitle: true,
      )),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            ...cart.foods.map(foodListBuilder).toList(),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Sub Total'),
                      Text('LKR ${this._getTotal().toStringAsFixed(2)}'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Delivery fee'),
                      Text(
                          'LKR ${(this._getTotal() * 0.1).toStringAsFixed(2)}'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'LKR ${(this._getTotal() * 1.1).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Payment methode'),
                      Text('Cash'),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  BigButton(
                    fontsize: 20,
                    text: 'Checkout',
                    onPressed: () {
                      print('checkout');
                      _hitFirebase();
                      cart.foods.clear();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => BottomNavigation()));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CartItemCard extends StatefulWidget {
  final String foodId;
  final int index;
  final Function changeSum;
  final int qty;
  const CartItemCard({
    this.qty,
    this.foodId,
    Key key,
    this.index,
    this.changeSum,
  }) : super(key: key);

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  double ammount = 400;
  int quantity = 1;

  Future<String> getImageUrl(String imgUrl) async {
    // print(imgUrl);
    String url;
    url = await FirebaseStorage.instance.ref().child(imgUrl).getDownloadURL();

    return url;
  }

  @override
  void initState() {
    super.initState();
    print(cart.foods[this.widget.index].quantity);
    this.quantity = cart.foods[this.widget.index].quantity;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('food')
            .document(this.widget.foodId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: FutureBuilder(
                          future: getImageUrl(snapshot.data['imgUrl']),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> futureSnapshot) {
                            if (futureSnapshot.hasData) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  futureSnapshot.data,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    snapshot.data['food_name'],
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cart.foods.removeAt(this.widget.index);
                                    this.widget.changeSum();
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.trash,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'LKR ${snapshot.data['price'].toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        ManipulateButton(
                                          icon: FontAwesomeIcons.minus,
                                          onTap: () {
                                            setState(() {
                                              if (quantity > 1) {
                                                quantity--;
                                                cart.foods[this.widget.index]
                                                    .quantity = quantity;
                                              }
                                            });
                                            this.widget.changeSum();
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 3),
                                          child: Center(
                                            child: Text(
                                              "$quantity",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.green)),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ManipulateButton(
                                          icon: FontAwesomeIcons.plus,
                                          onTap: () {
                                            setState(() {
                                              quantity++;
                                              cart.foods[this.widget.index]
                                                  .quantity = quantity;
                                            });
                                            this.widget.changeSum();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "LKR ${(snapshot.data['price'] * quantity).toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CategoryIconButton(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CustomizeFoodPage(
                                  imgUrl: snapshot.data['imgUrl'],
                                  foodId: this.widget.foodId,
                                  ingrediants: snapshot.data['ingrediance'],
                                )));
                      },
                      image: 'assets/icon/customize.png',
                      lable: 'Customize',
                    ),
                    CategoryIconButton(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DeliveryOptionPage(
                                  deliveryFee:
                                      snapshot.data['price'] * quantity * 0.1,
                                  foodId: this.widget.foodId,
                                )));
                      },
                      image: 'assets/icon/deliveryopt.png',
                      lable: 'Delivery Option',
                    ),
                    CategoryIconButton(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DineInOptionPage(
                                  dineInCost:
                                      snapshot.data['price'] * quantity * 0.2,
                                  foodId: this.widget.foodId,
                                )));
                      },
                      image: 'assets/icon/dinein.png',
                      lable: 'Dine In',
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class ManipulateButton extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  const ManipulateButton({this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        child: FaIcon(
          icon,
          color: Colors.green,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
      ),
    );
  }
}
