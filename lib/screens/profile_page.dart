import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/components/profile_content_card.dart';
import 'package:user/screens/favourite_page.dart';
import 'package:user/screens/help_page.dart';
import 'package:user/screens/payment_methods.dart';
import 'package:user/screens/setting_view.dart';
import 'package:user/screens/walkthrough.dart';

class ViewProfilePage extends StatelessWidget {
  Future<void> _logout() async {
    /// Method to Logout the `FirebaseUser` (`_firebaseUser`)
    try {
      // signout code
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        ProfileCard(),
        SizedBox(
          height: 20,
        ),
        // ProfileContentCard(
        //   icon: FaIcon(FontAwesomeIcons.solidHeart),
        //   lable: 'Your Favourites',
        //   onTap: () => Navigator.of(context)
        //       .push(MaterialPageRoute(builder: (context) => FavouritePage())),
        // ),
        ProfileContentCard(
          icon: FaIcon(FontAwesomeIcons.creditCard),
          lable: 'Payments',
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PaymentsPage())),
        ),
        ProfileContentCard(
          icon: FaIcon(FontAwesomeIcons.cog),
          lable: 'Settings',
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SettingsViewPage())),
        ),
        ProfileContentCard(
          icon: FaIcon(FontAwesomeIcons.handsHelping),
          lable: 'Help',
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HelpPage())),
        ),
        ProfileContentCard(
          icon: FaIcon(FontAwesomeIcons.signOutAlt),
          lable: 'Logout',
          onTap: () {
            _logout();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Walkthrough()));
          },
        ),
      ],
    ));
  }
}
