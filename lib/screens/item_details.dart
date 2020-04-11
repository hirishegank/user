import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/components/big_button.dart';
import 'package:user/screens/cart_items.dart';
import 'package:user/screens/cook_details.dart';

class FoodDetailPage extends StatefulWidget {
  final String primaryKey;
  FoodDetailPage({this.primaryKey});

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  bool addeddToChart = false;

  Widget renderButton() {
    return BigButton(
      fontsize: 20,
      text: addeddToChart == false ? 'Add to cart' : 'Added to cart',
      onPressed: () {
        setState(() {
          addeddToChart = !addeddToChart;
        });
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: FutureBuilder(
                      future: getImageUrl(snapShot.data['imgUrl']),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> future_snapshot) {
                        if (future_snapshot.hasData) {
                          return Image.network(
                            future_snapshot.data,
                            fit: BoxFit.cover,
                          );
                        }
                        return Image.asset(
                          'assets/img/foodSample.png',
                          fit: BoxFit.cover,
                        );
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
                              builder: (context) => CookDetailsPage()));
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Cooked by ',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Muli',
                                fontSize: 20),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Shan',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
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
                  child: renderButton(),
                ),
              ],
            );
          }
          return Text('loading...');
        },
        stream: Firestore.instance
            .collection("food")
            .document(this.widget.primaryKey)
            .snapshots(),
      )),
    );
  }
}
