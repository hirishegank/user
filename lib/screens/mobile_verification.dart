import 'package:flutter/material.dart';
import 'package:user/components/big_button.dart';
import 'package:user/screens/success_registration.dart';

class MobileVerificationPage extends StatefulWidget {
  const MobileVerificationPage({Key key}) : super(key: key);

  @override
  _MobileVerificationPageState createState() => _MobileVerificationPageState();
}

class _MobileVerificationPageState extends State<MobileVerificationPage> {
  String phoneNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Verification',
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
                  child: Image.asset('assets/img/phone.png'),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Enter your mobile number to verify',
                        textAlign: TextAlign.center,
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
                            hintText: "07X XXX XXXX",
                            // labelText: 'Phone Number'
                          ),
                          onChanged: (value) {
                            phoneNo = value;
                            print(phoneNo);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BigButton(
                        text: 'Proceed',
                        onPressed: () {
                          print('pressed');
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => SuccessRegistrationPage(
                                        phoneNo: phoneNo,
                                      )));
                        },
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
