import 'package:flutter/material.dart';
import 'package:user/components/big_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:user/screens/profile_creation.dart';

import 'bottom_navigation.dart';

class MobileVerificationPage extends StatefulWidget {
  const MobileVerificationPage({Key key}) : super(key: key);

  @override
  _MobileVerificationPageState createState() => _MobileVerificationPageState();
}

class _MobileVerificationPageState extends State<MobileVerificationPage> {
  String phoneNo;
  String smsCode;
  AuthCredential _phoneAuthCredential;
  FirebaseUser _firebaseUser;
  var _verificationId;

  Future<void> _login() async {
    /// This method is used to login the user
    /// `AuthCredential`(`_phoneAuthCredential`) is needed for the signIn method
    /// After the signIn method from `AuthResult` we can get `FirebaserUser`(`_firebaseUser`)
    try {
      await FirebaseAuth.instance
          .signInWithCredential(this._phoneAuthCredential)
          .then((AuthResult authRes) {
        _firebaseUser = authRes.user;
        print(_firebaseUser.toString());
        //move to create profile page after successful OTP provided

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ProfilePage(phoneNo: this.phoneNo)));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _submitOTP() {
    /// when used different phoneNumber other than the current (running) device
    /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
    this._phoneAuthCredential = PhoneAuthProvider.getCredential(
        verificationId: this._verificationId, smsCode: this.smsCode);

    _login();
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter sms Code'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
                print(this.smsCode);
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Done'),
                onPressed: () {
                  _submitOTP();
                },
              )
            ],
          );
        });
  }

  Future<void> _submitPhoneNumber() async {
    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');

      this._phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
    }

    void verificationFailed(AuthException error) {
      print(error);
    }

    void codeSent(String verificationId, [int code]) {
      this._verificationId = verificationId;
      print('codeSent');
      smsCodeDialog(context);
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: Duration(milliseconds: 10000),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void getCurrentUserForRouting() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser();

    if (_firebaseUser != null)
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavigation()));
  }

  @override
  void initState() {
    getCurrentUserForRouting();
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
            'Verification',
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
                  child: Image.asset(
                    'assets/img/phone.png',
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                Column(
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
                        keyboardType: TextInputType.phone,
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
                      height: 50,
                    ),
                    BigButton(
                      text: 'Proceed',
                      onPressed: () {
                        print('pressed');
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //     builder: (context) => SuccessRegistrationPage(
                        //           phoneNo: phoneNo,
                        //         )));
                        _submitPhoneNumber();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
