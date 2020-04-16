import 'package:flutter/material.dart';
import 'package:user/components/big_button.dart';
import 'package:user/models/cart.dart';

class DeliveryOptionPage extends StatefulWidget {
  final String foodId;
  final double deliveryFee;
  const DeliveryOptionPage({this.foodId, this.deliveryFee});

  @override
  _DeliveryOptionPageState createState() => _DeliveryOptionPageState();
}

class _DeliveryOptionPageState extends State<DeliveryOptionPage> {
  bool _isDoorStep = true;
  String address;
  String deliveryOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Delivery Option'),
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Text('Delivery Address'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) {
                    this.address = value;
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hintText: 'No.10,\nExample Road,\nExample',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade100, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text('Delivery Method'),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                            child: InkWell(
                          onTap: () {
                            setState(() {
                              _isDoorStep = !_isDoorStep;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.green),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: _isDoorStep
                                  ? Icon(
                                      Icons.check,
                                      size: 30.0,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Door Step Pickup'),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            child: InkWell(
                          onTap: () {
                            setState(() {
                              _isDoorStep = !_isDoorStep;
                              this.deliveryOption = _isDoorStep
                                  ? 'Door step pickup'
                                  : 'Door Delivery';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.green),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: !_isDoorStep
                                  ? Icon(
                                      Icons.check,
                                      size: 30.0,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Door Delivery'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Delivery Fee'),
                        Text(
                            'LKR ${this.widget.deliveryFee.toStringAsFixed(2)}')
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: BigButton(
                  text: 'Save',
                  onPressed: () {
                    var food = cart.foods
                        .where((food) => food.id == this.widget.foodId)
                        .toList()
                        .first;

                    var index = cart.foods.indexOf(food);
                    cart.foods[index].deliveryOption = this.deliveryOption;
                    cart.foods[index].address = this.address;
                    print(cart.foods[index].deliveryOption);
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class IngrediantTag extends StatelessWidget {
  final String ingrediant;
  final Function onTap;
  const IngrediantTag({@required this.ingrediant, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              ingrediant,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.close,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
