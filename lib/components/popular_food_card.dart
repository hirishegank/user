import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/screens/item_details.dart';

class PopularFoodCard extends StatelessWidget {
  final String primaryKey;
  final double initialRating;
  final int numberOfRators;
  final String foodName;
  const PopularFoodCard(
      {this.primaryKey,
      @required this.foodName,
      @required this.initialRating,
      @required this.numberOfRators});

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
                this.foodName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              CustomRatingBarPopularFood(
                initialRating: initialRating,
                numberOfRators: numberOfRators,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRatingBarPopularFood extends StatelessWidget {
  final double initialRating;
  final int numberOfRators;
  const CustomRatingBarPopularFood(
      {Key key, @required this.initialRating, @required this.numberOfRators})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('$initialRating'),
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
        Text('($numberOfRators)')
      ],
    );
  }
}
