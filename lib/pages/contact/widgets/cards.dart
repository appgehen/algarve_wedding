import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget returnCards(Function linkFunction, String headline, IconData icon,
    BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          headline,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onTap: linkFunction,
      ),
    ),
  );
}

launchMail() async {
  const url = 'mailto:smithdaniel@web.de';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

launchDataprotection() async {
  const url =
      'https://firebasestorage.googleapis.com/v0/b/marry-me-cf187.appspot.com/o/dataprotectionRegulation%2FDatenschutzerkla%CC%88rung.pdf?alt=media';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

launchMaps() async {
  const url = 'https://goo.gl/maps/EcEXNazUgL5aHpLU8';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

launchPhone() async {
  const url = 'tel:+4917630105793';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
