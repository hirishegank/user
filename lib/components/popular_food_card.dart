import 'package:flutter/material.dart';
import 'package:user/screens/item_details.dart';

class PopularFoodCard extends StatelessWidget {
  final String primaryKey;
  const PopularFoodCard({this.primaryKey});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FoodDetailPage(
                  primaryKey: this.primaryKey,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: EdgeInsets.all(15),
          width: 200,
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
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Row(
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
      ),
    );
  }
}
