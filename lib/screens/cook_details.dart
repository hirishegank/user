import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/components/cooks_dishes_card.dart';

import 'package:user/components/review_card.dart';

class CookDetailsPage extends StatefulWidget {
  final String chefId;
  CookDetailsPage({this.chefId});

  @override
  _CookDetailsPageState createState() => _CookDetailsPageState();
}

class _CookDetailsPageState extends State<CookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cook Details'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      'assets/img/chef.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: <Widget>[
                              Text(
                                'Shan',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 05,
                              ),
                              FaIcon(
                                FontAwesomeIcons.solidCircle,
                                color: Colors.greenAccent,
                                size: 15,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '6+ yrs experience',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Special in Biriyani, Short eats',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('rating...'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Review',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height / 5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ReviewCard(),
                  ReviewCard(),
                  ReviewCard(),
                  ReviewCard(),
                  ReviewCard()
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Other Foods By the Cook',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Wrap(
                  children: <Widget>[
                    CooksDishedCard(),
                    CooksDishedCard(),
                    CooksDishedCard(),
                    CooksDishedCard(),
                    CooksDishedCard(),
                    CooksDishedCard(),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
