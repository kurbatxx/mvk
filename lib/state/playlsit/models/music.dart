class Music {
  Music({required this.response});
  final Map<String, dynamic> response;

  factory Music.fromJson(Map<String, dynamic> json) {
    final response = json['response'] as Map<String, dynamic>;
    return Music(response: response);
  }
}
