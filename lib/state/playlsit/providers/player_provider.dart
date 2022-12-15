import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final audioPlayerProvider = Provider<AudioPlayer>((_) {
  final AudioContext audioContext = AudioContext(
    iOS: AudioContextIOS(
      defaultToSpeaker: true,
      category: AVAudioSessionCategory.ambient,
      options: [
        AVAudioSessionOptions.defaultToSpeaker,
        AVAudioSessionOptions.mixWithOthers,
      ],
    ),
    android: AudioContextAndroid(
      isSpeakerphoneOn: true,
      stayAwake: true,
      contentType: AndroidContentType.music, // i change this
      usageType: AndroidUsageType.media, // i change this
      audioFocus: AndroidAudioFocus.gain, // i change this
    ),
  );
  AudioPlayer.global.setGlobalAudioContext(audioContext);

  return AudioPlayer();
});
