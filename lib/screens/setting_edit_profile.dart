import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsEditPage extends StatefulWidget {
  @override
  _SettingsEditPageState createState() => _SettingsEditPageState();
}

class _SettingsEditPageState extends State<SettingsEditPage> {
  String name;
  String phoneNo = "+94773995161";
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  FirebaseUser _firebaseUser;

  void getCurrentUser() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser();
    final userDetails = await Firestore.instance
        .collection('user')
        .document(_firebaseUser.uid)
        .get();
    setState(() {
      this.name = userDetails['name'];
    });
  }

  @override
  void initState() {
    getCurrentUser();
    nameController.text = name;
    phoneNoController.text = phoneNo;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Stack(
                children: <Widget>[
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/img/profile.png',
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.saturation,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 200,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w200),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              controller: phoneNoController,
              decoration: InputDecoration(
                  labelText: 'Phone No',
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w200),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          )
        ]));
  }
}
