import 'package:flutter/material.dart';
import 'widgets/header_image.dart';
import 'logic/build_cards.dart';
import 'package:algarve_wedding/logic/shared-prefs/save_prefs.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Kontakt',
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.transparent,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              saveSharedPrefs('adminMode', 'true');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                child: returnHeaderImage(context),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Alicia & Daniel',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    height: 30.0,
                    width: 150.0,
                    child: Divider(
                      color: Color.fromRGBO(189, 189, 189, 1),
                    ),
                  ),
                  returnDisplayedCard(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
