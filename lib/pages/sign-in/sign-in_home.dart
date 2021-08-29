import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:algarve_wedding/widgets/appbar.dart';
import 'widgets/background_image.dart';
import 'package:algarve_wedding/logic/account/account_sign-in.dart';
import '../../logic/invitation-codes_get.dart';
import '../../logic/shared-prefs/save_prefs.dart';

class SignInToApp extends StatefulWidget {
  @override
  _SignInToAppState createState() => _SignInToAppState();
}

class _SignInToAppState extends State<SignInToApp> {
  bool _validate = false;
  TextEditingController _invitationCodeController = new TextEditingController();

  @override
  void initState() {
    getInvitationCodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        returnBackgroundImage(context),
        Scaffold(
          appBar: returnAppBar(true, context),
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Anmelden',
                              style: Theme.of(context).textTheme.headline1),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp('[ ]')),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Einladungs-Code',
                                    errorText: _validate
                                        ? 'Bitte trage einen gültigen Einladungs-Code ein.'
                                        : null,
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).focusColor),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).focusColor),
                                    ),
                                  ),
                                  controller: _invitationCodeController,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 20, right: 20, bottom: 20),
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  height: 50,
                                  minWidth: MediaQuery.of(context).size.width,
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  child: Text('Anmelden'),
                                  onPressed: () {
                                    _saveInvitationCode(context);
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _saveInvitationCode(BuildContext context) async {
    String key = 'invitationCode';
    if (_invitationCodeController.text.length > 0) {
      setState(() {
        final _inputValue = _invitationCodeController.text.toString();
        _validate = false;
        if (saveInvitationCodes.containsValue(_inputValue.toUpperCase())) {
          saveSharedPrefs(key, _inputValue);
          signInAnonymously(context);
        } else {
          setState(() {
            _validate = true;
          });
        }
      });
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}
