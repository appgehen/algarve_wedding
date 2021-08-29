import 'package:url_launcher/url_launcher.dart';

launchURL() async {
  String mapsURL =
      'https://www.google.com/maps/dir/52.3759174,9.941981/a+pausa+alvor/@44.3710756,-8.2913779,5z/';

  if (await canLaunch(mapsURL)) {
    await launch(mapsURL);
  } else {
    throw 'Could not launch $mapsURL';
  }
}
