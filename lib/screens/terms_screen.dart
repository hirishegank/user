import 'package:flutter/material.dart';
import 'package:user/components/big_button.dart';
import 'package:user/screens/mobile_verification.dart';

import '../constants.dart';

class TermsScreen extends StatefulWidget {
  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool _isAccepted = false;
  String terms = """
This document outlines how Hiri’s Kitchen app can be used and what is prohibited. It also includes a disclaimer to limit your liability for your App. Having a Mobile App Terms and Conditions of Use is especially important if you are selling goods or services on your App. This document explains the terms, which includes delivery, return, prohibited actions, and refund policies.


Use this Mobile App Terms and Conditions of Use if:
* you would like to explain how your App works and its prohibited use;
* you would like to protect the intellectual property on your App;
* you would like to limit liability for your information, outages and third party links;
* you would like to comply with Australian law and regulations

Why do I need a Mobile App Terms and Conditions of Use?
A Mobile App Terms of Use is an important document for every Mobile Application. It allows the operator to set out the rules for using their App. It also allows the operator to protect their intellectual property and limit their liability for the App.

What does this Mobile App Terms and Conditions of Use cover?
* the user’s rights and a licence to use the App;
* your ownership and intellectual property of the App;
* limiting liability for third party links;
* Australian consumer law and consumer guarantees;
* delivery of goods, returns and refunds policy;
* payment details;
* privacy and a disclaimer for warranties;
* disclosure of information;
* competitor and restricted access

Do I have to include a Terms and Conditions for my app?
You do not have to include Terms and Conditions for your app, however it is recommended that you do. Terms and Conditions can help prevent the misuse and abuse of your app, limit liability from your company and ensure that the content that you own remains yours

What should my app Terms and Conditions include?
Your app's Terms and Conditions should include how users can use your app and their obligations and rights when using the app. The Terms and Conditions also contains your rights as the owner of the app and the rights you have over your app and its intellectual property. The Terms and Conditions should outline who is able to download the app and if their are any factors that may restrict the downloading of the app, such as age or country of download. If your app is available for download in other countries, it is essential that you include the different laws that may apply when the app is used in another country.
The Office of the Australian Information Commissioner requires smartphone app developers to embed privacy policies within Terms and Conditions as well. Your Terms and Conditions should also outline the how a user can terminate this agreement, as well as the ramifications of breaching the Terms and Conditions. The Terms and Conditions should also include how personal information is dealt with; how it is stored and how breaches of personal information will be dealt with

How do I make my app Terms and Conditions binding?
A contract if formed once an offer is proposed and then accepted. When using an app, you are agreeing to the apps Terms and Conditions and are therefore accepting them. From this understanding, a contract is formed. To ensure that the Terms and Conditions are legally binding, ensure that the Terms and Conditions are clearly accessible and viewable before the user downloads the application and when they are using it

Do I need to include additional terms if I am using third party providers (e.g Google Maps, open-source code)?
Yes, you do need to include additional terms for third party providers if they are used within your app. Especially if these services utilise the function of another party’s service

Where should I publish my application Terms and Conditions?
Your Terms and Conditions should be published on the platform/s that it can be downloaded from. If your application has a website, the Terms and Conditions should also be viewable on there

What else can I do to legally protect my app?
There are many other steps that can be taken to protect your app and its intellectual property. You could hire a lawyer to ensure that your app is legally protected. A lawyer can provide you with advice on how to protect your app, as well as ensure that your app is legally protected. Other ways to protect your app include trademarking its name, using non-disclosure agreements and the signing over of copyright from your apps developers. Taking precautions like this, can help ensure that your app is legally protected.
  

  
  """;

  String privacy = """

At Website Name, accessible at Website.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Website Name and how we use it.
If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us through email at Email@Website.com
This privacy policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in Website Name. This policy is not applicable to any information collected offline or via channels other than this website.

Consent
By using our website, you hereby consent to our Privacy Policy and agree to its terms.

Information we collect
The personal information that you are asked to provide, and the reasons why you are asked to provide it, will be made clear to you at the point we ask you to provide your personal information.
If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide.
When you register for an Account, we may ask for your contact information, including items such as name, company name, address, email address, and telephone number.
How we use your information
We use the information we collect in various ways, including to:
* Provide, operate, and maintain our webste
* Improve, personalize, and expand our webste
* Understand and analyze how you use our webste
* Develop new products, services, features, and functionality
* Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the webste, and for marketing and promotional purposes
* Send you emails
* Find and prevent fraud
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(this.terms),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(this.privacy),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        onChanged: (value) {
                          setState(() {
                            this._isAccepted = value;
                          });
                        },
                        value: _isAccepted,
                      ),
                      Expanded(
                        child: Text(
                            "I agree to the privacy policy, terms and condition of Hiri's Kitchen."),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: BigButton(
                bgColor: _isAccepted ? kBigButtonColor : Colors.grey.shade500,
                text: 'Continue',
                onPressed: () {
                  if (_isAccepted)
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => MobileVerificationPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
