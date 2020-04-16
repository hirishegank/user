import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/components/big_button.dart';
import 'package:user/models/cart.dart';

class DineInOptionPage extends StatefulWidget {
  final String foodId;
  final double dineInCost;
  const DineInOptionPage({this.foodId, this.dineInCost});
  @override
  _DineInOptionPageState createState() => _DineInOptionPageState();
}

class _DineInOptionPageState extends State<DineInOptionPage> {
  DateTime dateTime;
  TextEditingController dateTimeController = TextEditingController();

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return child;
      },
    );
  }

  @override
  void dispose() {
    dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dine In Option'),
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Text('What is Dine in Option ?'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Description',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Amet qui in cupidatat ut id fugiat aliqua cupidatat proident cupidatat sint. In cupidatat sit laborum voluptate veniam consequat. Cupidatat minim id irure consectetur. Tempor dolore sit deserunt adipisicing quis adipisicing minim consequat tempor pariatur eiusmod adipisicing ullamco.',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text('Check Availability'),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: dateTimeController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: InkWell(
                      onTap: () async {
                        dateTime = await getDate();
                        print(dateTime);
                        FocusScope.of(context).requestFocus(FocusNode());
                        dateTimeController.text = dateTime.toString();
                      },
                      child: FaIcon(
                        FontAwesomeIcons.calendarAlt,
                        size: 30,
                        color: Colors.green,
                      ),
                    ),
                    fillColor: Colors.grey.shade100,
                    hintText: 'Pick a Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.shade100, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade100, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                  onChanged: (value) {
                    print('test.....');
                    dateTime = DateTime.parse(value.replaceAll("/", "-"));
                    print(dateTime);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Dining Cost'),
                    Text('LKR ${this.widget.dineInCost.toStringAsFixed(2)}'),
                  ],
                ),
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
                    cart.foods[index].dineIn = this.dateTime;
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ));
  }
}
