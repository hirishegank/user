import 'package:flutter/material.dart';

class ProfileContentCard extends StatelessWidget {
  final Widget icon;
  final String lable;
  final Function onTap;
  const ProfileContentCard(
      {Key key, this.icon, @required this.lable, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            icon ??
                SizedBox(
                  height: 1,
                ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(lable),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/img/walk1.png',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Gugsi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Joined 2 weeks ago',
                style: TextStyle(fontSize: 15),
              )
            ],
          ))
        ],
      ),
    );
  }
}
