import 'package:flutter/material.dart';
import 'package:user/components/big_button.dart';
import 'bottom_navigation.dart';

class ProfilePage extends StatefulWidget {
  final String phoneNo;
  const ProfilePage({@required this.phoneNo});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name;
  String otherDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Profile',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Image.asset('assets/img/profile.png'),
                ),
                SizedBox(
                  height: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: "Eg: Hirishegan", labelText: 'Name'),
                        onChanged: (value) {
                          name = value;
                          print(name);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: "Eg: Alergic", labelText: 'More Details'),
                        onChanged: (value) {
                          otherDetails = value;
                          print(otherDetails);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    BigButton(
                      text: 'Save',
                      onPressed: () {
                        print('pressed');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => BottomNavigation()));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
