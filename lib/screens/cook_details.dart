import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/components/cooks_dishes_card.dart';

import 'package:user/components/review_card.dart';

class CookDetailsPage extends StatefulWidget {
  final String chefId;
  CookDetailsPage({this.chefId});

  @override
  _CookDetailsPageState createState() => _CookDetailsPageState();
}

class _CookDetailsPageState extends State<CookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cook Details'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            StreamBuilder(
                stream: Firestore.instance
                    .collection('chef')
                    .document(this.widget.chefId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    Center(
                      child: CircularProgressIndicator(),
                    );
                  print('testing----------');

                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 20.0, right: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Image.asset(
                                'assets/img/chef.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      textBaseline: TextBaseline.alphabetic,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data['name'],
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 05,
                                        ),
                                        FaIcon(
                                          FontAwesomeIcons.solidCircle,
                                          color: Colors.greenAccent,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '6+ yrs experience',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Special in Biriyani, Short eats',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    RatingBarIndicator(
                                      rating: 4.3,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemSize: 25,
                                      unratedColor: Colors.green.shade100,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Review',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: MediaQuery.of(context).size.height / 5,
                        child: StreamBuilder(
                            stream: Firestore.instance
                                .collection('chef')
                                .document(this.widget.chefId)
                                .collection('reviews')
                                .snapshots(),
                            builder: (context, reviewSnapshots) {
                              if (!reviewSnapshots.hasData)
                                return Center(
                                    child: CircularProgressIndicator());

                              return ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: reviewSnapshots.data.documents
                                      .map<ReviewCard>((doc) {
                                    print(doc.data['user_id']);
                                    return ReviewCard(
                                      reviewText: doc.data['review_text'],
                                      reviewerId: doc.data['user_id'],
                                    );
                                  }).toList());
                              // return ListView.builder(
                              //   scrollDirection: Axis.horizontal,
                              //   itemCount:
                              //       reviewSnapshots.data.documents.length,
                              //   itemBuilder: (context, index) {
                              //     String reviewText = reviewSnapshots
                              //                 .data.documents
                              //                 .toList()[index]['review_text'] !=
                              //             null
                              //         ? reviewSnapshots.data['reviews'][index]
                              //             ['review_text']
                              //         : '';
                              //     return ReviewCard(
                              //       reviewText: reviewText,
                              //       reviewerId: reviewSnapshots.data['reviews']
                              //           [index]['user_id'],
                              //     );
                              //   },
                              // );
                            }),
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Other Foods By the Cook',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('food')
                        .where('chef_id', isEqualTo: this.widget.chefId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return Wrap(
                          children: snapshot.data.documents
                              .map<CooksDishedCard>((food) {
                        return CooksDishedCard(
                          initialRating: food['rating'],
                          foodId: food.documentID,
                        );
                      }).toList());
                    }))
          ],
        ),
      ),
    );
  }
}
