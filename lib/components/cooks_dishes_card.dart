import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/screens/item_details.dart';

class CooksDishedCard extends StatelessWidget {
  final String foodId;
  final String chefId;
  final double initialRating;

  const CooksDishedCard(
      {this.foodId, @required this.initialRating, this.chefId});

  Future<String> getImageUrl(String imgUrl) async {
    // print(imgUrl);
    String url;
    url = await FirebaseStorage.instance.ref().child(imgUrl).getDownloadURL();

    return url;
  }

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
                  FutureBuilder(
                      future: getImageUrl(snapshot.data['imgUrl']),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> futureSnapshot) {
                        if (futureSnapshot.hasData) {
                          return Image.network(
                            futureSnapshot.data,
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    snapshot.data['food_name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Text('${snapshot.data['rating']}'),
                      SizedBox(
                        width: 5,
                      ),
                      RatingBarIndicator(
                        rating: snapshot.data['rating'],
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
                      Text('(${snapshot.data['number_of_rating']})')
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
