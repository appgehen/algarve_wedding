import 'package:url_launcher/url_launcher.dart';

timeLineLaunchURL(String url) async {
  String mapsURL = url;

  if (await canLaunch(mapsURL)) {
    await launch(mapsURL);
  } else {
    throw 'Could not launch $mapsURL';
  }
}
