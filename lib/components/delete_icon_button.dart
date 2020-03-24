import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('deleted');
      },
      child: FaIcon(
        FontAwesomeIcons.trash,
        color: Colors.green,
        size: 20,
      ),
    );
  }
}
