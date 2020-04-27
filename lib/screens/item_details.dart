import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/components/big_button.dart';
import 'package:user/models/food.dart';
import 'package:user/screens/cart_items.dart';
import 'package:user/screens/cook_details.dart';
import 'package:user/models/cart.dart';

class FoodDetailPage extends StatefulWidget {
  final String foodId;
  FoodDetailPage({this.foodId});

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  Food food = Food();
  bool addeddToChart = false;

  Widget renderButton(var foodSnapshot) {
    try {
      this.addeddToChart =
          cart.foods.where((f) => f.id == this.widget.foodId).toList().first ==
                  null
              ? false
              : true;
    } catch (e) {
      this.addeddToChart = false;
    }
    // print(this.addeddToChart);
    return BigButton(
      fontsize: 20,
      text: addeddToChart == false ? 'Add to cart' : 'Added to cart',
      onPressed: () {
        if (!addeddToChart) {
          cart.foods.add(this.food);
          setState(() {
            this.addeddToChart = true;
          });
        }
      },
    );
  }

  Future<String> getImageUrl(String imgUrl) async {
    // print(imgUrl);
    String url;
    url = await FirebaseStorage.instance.ref().child(imgUrl).getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: FaIcon(
              FontAwesomeIcons.cartArrowDown,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartPage()));
            },
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
          child: StreamBuilder(
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            this.food.chefId = snapShot.data['chef_id'];
            this.food.id = this.widget.foodId;
            this.food.price = snapShot.data['price'];
            this.food.quantity = 1;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: FutureBuilder(
                      future: getImageUrl(snapShot.data['imgUrl']),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> futureSnapshot) {
                        if (futureSnapshot.hasData) {
                          return Image.network(
                            futureSnapshot.data,
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            fit: BoxFit.cover,
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        snapShot.data['food_name'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      Text(
                        'LKR ${snapShot.data['price'].toStringAsFixed(2)}',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CookDetailsPage(
                                    chefId: snapShot.data['chef_id'],
                                  )));
                        },
                        child: StreamBuilder(
                            stream: Firestore.instance
                                .collection('chef')
                                .document(this.food.chefId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return Text('Loading...');
                              return RichText(
                                text: TextSpan(
                                  text: 'Cooked by ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Muli',
                                      fontSize: 20),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: snapshot.data['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              );
                            }),
                      ),
                      RatingBarIndicator(
                        rating: snapShot.data['rating'],
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 25,
                        unratedColor: Colors.green.shade100,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      children: <Widget>[
                        Text(
                          'Descritpion',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        snapShot.data['description'] != null
                            ? Text(
                                snapShot.data['description'],
                                style: TextStyle(color: Colors.grey),
                              )
                            : Text(
                                'No description',
                                style: TextStyle(color: Colors.grey),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Ingredients',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        snapShot.data['ingrediance'] != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: snapShot.data['ingrediance']
                                    .map<Text>(
                                      (f) => Text(
                                        f,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )
                                    .toList(),
                              )
                            : Text(
                                'No details',
                                style: TextStyle(color: Colors.grey),
                              )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: renderButton(snapShot.data),
                ),
              ],
            );
          }
          return Text('loading...');
        },
        stream: Firestore.instance
            .collection("food")
            .document(this.widget.foodId)
            .snapshots(),
      )),
    );
  }
}
