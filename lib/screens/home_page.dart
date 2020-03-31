import 'package:flutter/material.dart';
import 'package:user/components/best_food_card.dart';
import 'package:user/components/home_category_buttom.dart';
import 'package:user/components/popular_food_card.dart';
import 'package:user/constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchText;

  Future showCustomModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0xff757575),
          child: Container(
              height: MediaQuery.of(context).size.height * 4 / 9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Filter',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 30),
                child: Text(
                  'Hi Gugsi !',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('What would you like to eat?'),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: kHomeInputDecoration.copyWith(
                    suffixIcon: InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        showCustomModal(context);
                      },
                      child: Icon(
                        Icons.arrow_downward,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    searchText = value;
                    print(searchText);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CategoryIconButton(
                onTap: () {
                  print('Cakes');
                },
                image: 'assets/icon/cake.png',
                lable: 'Cakes',
              ),
              CategoryIconButton(
                onTap: () {
                  print('Sweets');
                },
                image: 'assets/icon/sweet.png',
                lable: 'Sweets',
              ),
              CategoryIconButton(
                onTap: () {
                  print('Rice & Curry');
                },
                image: 'assets/icon/rice.png',
                lable: 'Rice & Curry',
              ),
              CategoryIconButton(
                onTap: () {
                  print('Bakery');
                },
                image: 'assets/icon/backery.png',
                lable: 'Bakery',
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Popular Food',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                PopularFoodCard(
                  initialRating: 2.5,
                  numberOfRators: 200,
                ),
                PopularFoodCard(
                  initialRating: 2.5,
                  numberOfRators: 200,
                ),
                PopularFoodCard(
                  initialRating: 2.5,
                  numberOfRators: 200,
                ),
                PopularFoodCard(
                  initialRating: 2.5,
                  numberOfRators: 200,
                ),
                PopularFoodCard(
                  initialRating: 2.5,
                  numberOfRators: 200,
                ),
                PopularFoodCard(
                  initialRating: 2.5,
                  numberOfRators: 200,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Best Food',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          BestFoodCard(
            initialRating: 2.5,
          ),
          BestFoodCard(
            initialRating: 2.5,
          ),
          BestFoodCard(
            initialRating: 2.5,
          ),
          BestFoodCard(
            initialRating: 2.5,
          ),
          BestFoodCard(
            initialRating: 2.5,
          ),
          BestFoodCard(
            initialRating: 2.5,
          ),
          BestFoodCard(
            initialRating: 2.5,
          ),
        ],
      ),
    );
  }
}
