import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user/components/big_button.dart';
import 'package:user/constants.dart';
import 'bottom_navigation.dart';

class ProfilePage extends StatefulWidget {
  final String phoneNo;
  const ProfilePage({@required this.phoneNo});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name;
  String address;
  String otherDetails;
  FirebaseUser _firebaseUser;
  final db = Firestore.instance;
  int spice = 3;
  int suger = 3;
  int oil = 3;

  void getCurrentUser() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser();
    checkAlreadyRegistered();
  }

  void registerUser() {
    db.collection("user").document(_firebaseUser.uid).setData({
      'name': name,
      'otherDetails': otherDetails,
      'phoneNo': this.widget.phoneNo
    });
  }

  void checkAlreadyRegistered() async {
    final snapShot = await Firestore.instance
        .collection('user')
        .document(_firebaseUser.uid)
        .get();

    //if  registered
    if (snapShot.exists) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigation()));
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

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
                        decoration: InputDecoration(
                            hintText: "ex: Hirishegan Karuneswaran",
                            labelText: 'Name'),
                        onChanged: (value) {
                          name = value;
                          setState(() {});
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
                        decoration: InputDecoration(
                            hintText: "ex: Door No, Street, City",
                            labelText: 'Address'),
                        onChanged: (value) {
                          address = value;
                          setState(() {});
                          print(address);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      // child: TextField(
                      //   style: TextStyle(fontSize: 20),
                      //   textAlign: TextAlign.center,
                      //   decoration: InputDecoration(
                      //       hintText: "Eg: Alergic", labelText: 'More Details'),
                      //   onChanged: (value) {
                      //     otherDetails = value;
                      //     print(otherDetails);
                      //   },
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Select your preference',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Spice level'),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.green,
                              inactiveTrackColor: Colors.grey,
                              thumbColor: kBigButtonColor,
                              overlayColor: kBigButtonColor,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 10.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 20.0),
                            ),
                            child: Slider(
                              value: spice.toDouble(),
                              min: 1,
                              max: 6,
                              onChanged: (double value) {
                                setState(() {
                                  spice = value.round();
                                });
                              },
                            ),
                          ),
                          Text('Oil level'),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.green,
                              inactiveTrackColor: Colors.grey,
                              thumbColor: kBigButtonColor,
                              overlayColor: kBigButtonColor,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 10.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 20.0),
                            ),
                            child: Slider(
                              value: oil.toDouble(),
                              min: 1,
                              max: 6,
                              onChanged: (double value) {
                                setState(() {
                                  oil = value.round();
                                });
                              },
                            ),
                          ),
                          Text('Suger level'),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.green,
                              inactiveTrackColor: Colors.grey,
                              thumbColor: kBigButtonColor,
                              overlayColor: kBigButtonColor,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 10.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 20.0),
                            ),
                            child: Slider(
                              value: suger.toDouble(),
                              min: 1,
                              max: 6,
                              onChanged: (double value) {
                                setState(() {
                                  suger = value.round();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: BigButton(
                        bgColor: name != null &&
                                address != null &&
                                name != '' &&
                                address != ''
                            ? kBigButtonColor
                            : Colors.grey.shade300,
                        text: 'Save',
                        onPressed: () {
                          print('pressed');
                          registerUser(); //register user to the firestore
                          if (name != null &&
                              address != null &&
                              name != '' &&
                              address != '')
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => BottomNavigation()));
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
