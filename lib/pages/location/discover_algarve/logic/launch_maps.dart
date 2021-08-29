import 'package:url_launcher/url_launcher.dart';

launchURL(List itemList, int index) async {
  String mapsURL = itemList[index]['mapsURL'];

  if (await canLaunch(mapsURL)) {
    await launch(mapsURL);
  } else {
    throw 'Could not launch $mapsURL';
  }
}
