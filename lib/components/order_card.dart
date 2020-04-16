import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderCards extends StatelessWidget {
  final String foodId;
  final bool isPast;
  final bool isAccepted;
  final Function onTap;
  const OrderCards(
      {Key key,
      @required this.isPast,
      this.onTap,
      this.foodId,
      this.isAccepted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('food')
            .document(this.foodId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          print(this.foodId);
          return GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/img/foodSample.png',
                            colorBlendMode: BlendMode.saturation,
                            color: isPast ? Colors.black : Colors.transparent,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  snapshot.data['food_name'],
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  isAccepted ? 'Accepted' : '',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'LKR ${snapshot.data['price'].toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RatingBarIndicator(
                                  rating: snapshot.data['rating'],
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemSize: 20,
                                  unratedColor: isPast
                                      ? Colors.grey.shade300
                                      : Colors.green.shade100,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 2.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: isPast ? Colors.grey : Colors.green,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                FutureBuilder(
                                    future: Firestore.instance
                                        .collection('chef')
                                        .document(snapshot.data['chef_id'])
                                        .get(),
                                    builder: (context, future_snapshot) {
                                      if (future_snapshot.hasData) {
                                        return Text(
                                          future_snapshot.data['name'],
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        );
                                      }
                                      return Text(
                                        'Loading',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      );
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
