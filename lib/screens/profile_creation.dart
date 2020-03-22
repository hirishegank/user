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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Center(
                  child: Image.asset('assets/img/profile.png'),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Column(
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
                              hintText: "Eg: Alergic",
                              labelText: 'More Details'),
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
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => BottomNavigation()));
                        },
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
