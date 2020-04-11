import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/screens/item_details.dart';

class BestFoodCard extends StatelessWidget {
  final String primaryKey;
  final double initialRating;
  final String foodName;
  final String ingrediants;
  final String imgUrl;
  const BestFoodCard(
      {this.primaryKey,
      this.imgUrl,
      @required this.initialRating,
      @required this.foodName,
      this.ingrediants = 'No details'});

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
            FutureBuilder(
                future: getImageUrl(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Image.network(
                      snapshot.data,
                      fit: BoxFit.cover,
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    foodName,
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
                  ingrediants,
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
