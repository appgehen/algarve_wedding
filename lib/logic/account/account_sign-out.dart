import 'package:algarve_wedding/logic/shared-prefs/clear_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> signOut() async {
  clearSharedPrefs();
  await FirebaseAuth.instance.signOut();
}
