import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/screens/item_details.dart';

class BestFoodCard extends StatelessWidget {
  final String primaryKey;
  final double initialRating;
  const BestFoodCard({this.primaryKey, @required this.initialRating});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FoodDetailPage(
                  primaryKey: this.primaryKey,
                )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        color: Colors.grey.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/img/foodSample.png',
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'Food Name',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                RatingBarIndicator(
                  rating: initialRating,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 20,
                  unratedColor: Colors.green.shade100,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Ingrediants',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Ingrediants goes here.....',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
