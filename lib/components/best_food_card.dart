import 'package:flutter/material.dart';
import 'package:user/screens/item_details.dart';

class BestFoodCard extends StatelessWidget {
  final String primaryKey;
  const BestFoodCard({this.primaryKey});

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
                Text('Ratings...')
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
