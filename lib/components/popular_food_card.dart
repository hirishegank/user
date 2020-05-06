import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/screens/item_details.dart';

class PopularFoodCard extends StatelessWidget {
  final String foodId;
  final double initialRating;
  final int numberOfRators;
  final String foodName;
  final String imgUrl;
  const PopularFoodCard(
      {this.foodId,
      this.imgUrl,
      @required this.foodName,
      @required this.initialRating,
      @required this.numberOfRators});

  Future<String> getImageUrl() async {
    // print(imgUrl);
    String url;
    url = await FirebaseStorage.instance.ref().child(imgUrl).getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FoodDetailPage(
                  foodId: this.foodId,
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
              FutureBuilder(
                  future: getImageUrl(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Image.network(
                        snapshot.data,
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        fit: BoxFit.cover,
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
              SizedBox(
                height: 20,
              ),
              Text(
                this.foodName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
