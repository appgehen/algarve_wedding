import 'package:url_launcher/url_launcher.dart';

launchSpotify() async {
  const url = 'https://open.spotify.com/playlist/5L2P8MaZybDtcymPVKgbF2';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
