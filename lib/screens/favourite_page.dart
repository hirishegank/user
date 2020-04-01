import 'package:flutter/material.dart';
import 'package:user/components/favourite_food_card.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Favourite'),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(
          children: <Widget>[
            FavouriteCard(),
            FavouriteCard(),
            FavouriteCard(),
            FavouriteCard(),
          ],
        ));
  }
}
