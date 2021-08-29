import 'package:assets_audio_player/assets_audio_player.dart';

void playAudio(List item, int index) {
  final _assetsAudioPlayer = AssetsAudioPlayer();

  print(item[index]['soundFile']);
  _assetsAudioPlayer.open(
    Audio.network(item[index]['soundFile']),
  );
}
