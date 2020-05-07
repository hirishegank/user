import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/components/profile_content_card.dart';

class PaymentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Payments'),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('Payment Methods'),
            ),
            ProfileContentCard(
              icon: FaIcon(
                FontAwesomeIcons.ccVisa,
                size: 40,
              ),
              lable: 'Card',
            ),
            ProfileContentCard(
              icon: FaIcon(
                FontAwesomeIcons.wallet,
                size: 40,
              ),
              lable: 'Frimi',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Add payment methods',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            )
          ],
        ));
  }
}
