import 'package:flutter/material.dart';
import 'launch_maps.dart';

class BuildRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 15),
      child: Column(
        children: [
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            height: 50,
            minWidth: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            child: Text('Navigiere mich hin'),
            onPressed: () {
              launchURL();
            },
          ),
        ],
      ),
    );
  }
}
