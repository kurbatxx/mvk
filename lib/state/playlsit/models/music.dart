class Music {
  Music({required this.response});
  final Response response;

  factory Music.fromJson(Map<String, dynamic> json) {
    final response = Response.fromJson(json['response']);
    return Music(response: response);
  }
}

class Response {
  Response({
    required this.count,
    required this.musicItems,
  });
  final int count;
  final List<MusicItem> musicItems;

  factory Response.fromJson(Map<String, dynamic> json) {
    final count = json['count'] as int;
    final musicItems = <MusicItem>[];

    if (json['items'] != null) {
      for (final musicItem in (json['items'] as List)) {
        musicItems.add(MusicItem.fromJson(musicItem));
      }
    }

    return Response(
      count: count,
      musicItems: musicItems,
    );
  }
}

class MusicItem {
  MusicItem({
    required this.artist,
    required this.title,
    required this.duration,
  });

  final String artist;
  final String title;
  final int duration;

  factory MusicItem.fromJson(Map<String, dynamic> json) {
    final artist = json['artist'] as String;
    final title = json['title'] as String;
    final duration = json['duration'] as int;
    return MusicItem(artist: artist, title: title, duration: duration);
  }
}
