import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/screens/item_details.dart';

class CooksDishedCard extends StatelessWidget {
  final String foodId;
  final String chefId;
  final double initialRating;

  const CooksDishedCard(
      {this.foodId, @required this.initialRating, this.chefId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FoodDetailPage(
                  foodId: this.foodId,
                )));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width / 2 - 50,
        color: Colors.grey.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/img/foodSample.png',
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Food Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text('4.1'),
                SizedBox(
                  width: 5,
                ),
                RatingBarIndicator(
                  rating: initialRating,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 12,
                  unratedColor: Colors.green.shade100,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text('(200)')
              ],
            )
          ],
        ),
      ),
    );
  }
}
