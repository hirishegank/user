import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'cook_details.dart';

class OrderConfirmPage extends StatelessWidget {
  const OrderConfirmPage(
      {Key key, @required this.isPast, this.foodId, this.qrCode})
      : super(key: key);
  final bool isPast;
  final String foodId;
  final String qrCode;

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
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data['food_name']),
              centerTitle: true,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width - 60,
                      child: FutureBuilder(
                          future: getImageUrl(snapshot.data['imgUrl']),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> future_snapshot) {
                            if (future_snapshot.hasData) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  future_snapshot.data,
                                  colorBlendMode: BlendMode.saturation,
                                  color: isPast
                                      ? Colors.black
                                      : Colors.transparent,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      snapshot.data['description'],
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                      builder: (context, futureSnapshot) {
                        if (!futureSnapshot.hasData)
                          return Text(
                            'Loading... ',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Muli',
                                fontSize: 20),
                          );
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CookDetailsPage()));
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Cooked by ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Muli',
                                  fontSize: 20),
                              children: <TextSpan>[
                                TextSpan(
                                    text: futureSnapshot.data['name'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        );
                      },
                      future: Firestore.instance
                          .collection('chef')
                          .document(snapshot.data['chef_id'])
                          .get(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Ingredients',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      snapshot.data['ingrediance'].toString().substring(1,
                          snapshot.data['ingrediance'].toString().length - 1),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        isPast
                            ? Image.asset('assets/img/expQr.png')
                            : QrImage(
                                data: this.qrCode,
                                version: QrVersions.auto,
                                gapless: false,
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Please scan this qr code to confirm your food delivery.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
