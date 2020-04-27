import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'cook_details.dart';

class OrderConfirmPage extends StatefulWidget {
  const OrderConfirmPage(
      {Key key,
      @required this.isPast,
      this.foodId,
      this.qrCode,
      this.orderId,
      this.isAlredyReviwed = false})
      : super(key: key);
  final bool isPast;
  final String foodId;
  final String qrCode;
  final String orderId;
  final bool isAlredyReviwed;

  @override
  _OrderConfirmPageState createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends State<OrderConfirmPage> {
  bool showModal = true;
  String reviewTxt;
  double review = 2.5;

  FirebaseUser _firebaseUser;

  void getCurrentUser() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<String> getImageUrl(String imgUrl) async {
    // print(imgUrl);
    String url;
    url = await FirebaseStorage.instance.ref().child(imgUrl).getDownloadURL();

    return url;
  }

  processReview() async {
    Firestore.instance
        .collection('orders')
        .document(this.widget.orderId)
        .updateData({'reviewed': true});

    var food = await Firestore.instance
        .collection('food')
        .document(this.widget.foodId)
        .get();

    String chefId = food.data['chef_id'];
    print(food.data['rating']);

    int pastNumberOfRating =
        food.data['number_of_rating'] == 0 ? 1 : food.data['number_of_rating'];
    print(food.data['number_of_rating']);
    print(review);
    double newRating = (food.data['rating'] * pastNumberOfRating + review) /
        ((food.data['number_of_rating']) + 1);
    print(newRating);

    Firestore.instance
        .collection('food')
        .document(this.widget.foodId)
        .updateData(
            {'rating': newRating, 'number_of_rating': FieldValue.increment(1)});

    // Firestore.instance.collection('chef').document(chefId).updateData({
    //   "reviews": FieldValue.arrayUnion([
    //     {'review_text': this.reviewTxt, 'user_id': _firebaseUser.uid}
    //   ])
    // });

    Firestore.instance
        .collection('chef')
        .document(chefId)
        .collection('reviews')
        .add({'review_text': this.reviewTxt, 'user_id': _firebaseUser.uid});

    setState(() {
      showModal = false;
    });
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

          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.data['food_name']),
                  centerTitle: true,
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width - 60,
                          child: FutureBuilder(
                              future: getImageUrl(snapshot.data['imgUrl']),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> futureSnapshot) {
                                if (futureSnapshot.hasData) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      futureSnapshot.data,
                                      colorBlendMode: BlendMode.saturation,
                                      color: widget.isPast
                                          ? Colors.black
                                          : Colors.transparent,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          snapshot.data['description'],
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FutureBuilder(
                          builder: (context, futureSnapshot) {
                            if (!futureSnapshot.hasData)
                              return Text(
                                'Loading... ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Muli',
                                    fontSize: 20),
                              );
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CookDetailsPage(
                                          chefId: snapshot.data['chef_id'],
                                        )));
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
                                        text: futureSnapshot.data['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            );
                          },
                          future: Firestore.instance
                              .collection('chef')
                              .document(snapshot.data['chef_id'])
                              .get(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Ingredients',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          snapshot.data['ingrediance'].toString().substring(
                              1,
                              snapshot.data['ingrediance'].toString().length -
                                  1),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            widget.isPast
                                ? Image.asset('assets/img/expQr.png')
                                : QrImage(
                                    data: this.widget.qrCode,
                                    version: QrVersions.auto,
                                    gapless: false,
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Please scan this qr code to confirm your food delivery.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //modal
              !this.widget.isAlredyReviwed && showModal
                  ? Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black45,
                        child: Center(
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Order Succesfuly\ncompleted',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Muli',
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration.none),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'What do you think ?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Muli',
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration.none),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  RatingBar(
                                    initialRating: 2.5,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.green,
                                    ),
                                    onRatingUpdate: (rating) {
                                      review = rating;
                                      print(review);
                                    },
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'Feedback',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Muli',
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration.none),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextField(
                                      onChanged: (value) {
                                        this.reviewTxt = value;
                                        print(this.reviewTxt);
                                      },
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        filled: true,
                                        hintText: 'Write your review here',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade100,
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade100,
                                              width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                showModal = false;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.red),
                                              child: Text(
                                                'Cancel',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              processReview();
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.green),
                                              child: Text(
                                                'Accept',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          );
        });
  }
}
