import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/components/big_button.dart';
import 'package:user/screens/cart_items.dart';
import 'package:user/screens/cook_details.dart';

class FoodDetailPage extends StatefulWidget {
  final String primaryKey;
  FoodDetailPage({this.primaryKey});

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  bool addeddToChart = false;

  Widget renderButton() {
    return BigButton(
      fontsize: 20,
      text: addeddToChart == false ? 'Add to cart' : 'Added to cart',
      onPressed: () {
        setState(() {
          addeddToChart = !addeddToChart;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: FaIcon(
              FontAwesomeIcons.cartArrowDown,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartPage()));
            },
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/img/foodSample.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Thalapakatti Biriyani',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Text(
                    'RS.400.00',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
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
                              text: 'Shan',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'ratting...',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    Text(
                      'Descritpion',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'tempting food words activate simulations of eating the food, including simulations of the taste and texture of the food, simulations of eating situations, and simulations of hedonic enjoyment ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ingredients',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ingredients rice, chicken, pudina, coriander leaves, onions, ginger garlic paste, chilli powder, turmeric powder, chicken masala, coriander powder, garam masala, biriyani leaves, curd, lemon',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: renderButton(),
            ),
          ],
        ),
      ),
    );
  }
}
