import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final playerProvider = Provider<AudioPlayer>((_) {
  final AudioContext audioContext = AudioContext(
    iOS: AudioContextIOS(
      defaultToSpeaker: true,
      //category: AVAudioSessionCategory.ambient,
      category: AVAudioSessionCategory.playAndRecord,
      options: [
        AVAudioSessionOptions.defaultToSpeaker,
        AVAudioSessionOptions.mixWithOthers,
      ],
    ),
    android: AudioContextAndroid(
      isSpeakerphoneOn: true,
      stayAwake: true,
      contentType: AndroidContentType.music,
      usageType: AndroidUsageType.media,
      audioFocus: AndroidAudioFocus.gain,
    ),
  );
  AudioPlayer.global.setGlobalAudioContext(audioContext);

  return AudioPlayer();
});
