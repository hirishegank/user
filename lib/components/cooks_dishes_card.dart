import 'package:flutter/material.dart';
import 'package:user/screens/item_details.dart';

class CooksDishedCard extends StatelessWidget {
  final String primaryKey;

  const CooksDishedCard({
    this.primaryKey,
  });

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
              children: <Widget>[
                Text('4.1'),
                SizedBox(
                  width: 5,
                ),
                Text('rating....'),
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
