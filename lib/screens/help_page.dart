import 'package:flutter/material.dart';

import 'package:user/components/profile_content_card.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Help'),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(
          children: <Widget>[
            ProfileContentCard(
              lable: 'Help with an order',
            ),
            ProfileContentCard(
              lable: 'Guide',
            ),
            ProfileContentCard(
              lable: 'FAQ',
            ),
            ProfileContentCard(
              lable: 'Hotline',
            ),
            ProfileContentCard(
              lable: 'Language',
            ),
          ],
        ));
  }
}
