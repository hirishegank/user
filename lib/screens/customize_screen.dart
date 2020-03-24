import 'package:flutter/material.dart';
import 'package:user/components/big_button.dart';

class CustomizeFoodPage extends StatefulWidget {
  final String primaryKey;

  const CustomizeFoodPage({this.primaryKey});
  @override
  _CustomizeFoodPageState createState() => _CustomizeFoodPageState();
}

class _CustomizeFoodPageState extends State<CustomizeFoodPage> {
  final List<String> ingrediants = [
    'ingrediant1',
    'ingrediant2',
    'ingrediant3',
    'ingrediant4',
    'ingrediant5',
    'ingrediant6',
    'ingrediant7',
    'ingrediant8',
    'ingrediant9',
  ];
  List<Widget> wingrediants;
  List<Widget> buildIngrediantWidgets() {
    List<Widget> newList = [];
    ingrediants.asMap().forEach((index, value) {
      newList.add(IngrediantTag(
        ingrediant: ingrediants[index],
        onTap: () => removeIngrediant(index),
      ));
    });
    return newList;
  }

  removeIngrediant(int index) {
    print(index);
    setState(() {
      wingrediants = List.from(wingrediants)..removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    print('init');
    wingrediants = buildIngrediantWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Customize'),
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Customize Your Food',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10)),
                margin: const EdgeInsets.all(
                  20,
                ),
                child: Image.asset(
                  'assets/img/customizeFoodSample.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Inrediants',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Wrap(
                  children: wingrediants,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text('Extra Note'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hintText: 'Alergic',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide:
                          BorderSide(color: Colors.grey.shade100, width: 1),
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
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: BigButton(
                  text: 'Save',
                  onPressed: () {
                    print('Save');
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
