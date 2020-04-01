import 'package:flutter/material.dart';

class SettingsEditPage extends StatefulWidget {
  @override
  _SettingsEditPageState createState() => _SettingsEditPageState();
}

class _SettingsEditPageState extends State<SettingsEditPage> {
  String name = "Gusgi";
  String phoneNo = "+94 77 xxx xxxx";
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  @override
  void initState() {
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
                        'assets/img/walk2.png',
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
