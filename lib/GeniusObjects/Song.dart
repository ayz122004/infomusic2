class Song {
  late String title;
  late String artist;
  late String album;
  late String date;

  Song({
    required this.title,
    required this.artist,
    required this.album,
    required this.date,
  });

  static String fetchTitle(Map<String, dynamic> data) {
    try {
      return data['response']['song']['title'];
    } catch (Exception) {
      return "";
    }
  }

  static String fetchArtist(Map<String, dynamic> data) {
    try {
      return data['response']['song']['primary_artist']['name'];
    } catch (Exception) {
      return "";
    }
  }

  static String fetchAlbum(Map<String, dynamic> data) {
    try {
      return data['response']['song']['album']['name'];
    } catch (Exception) {
      return "";
    }
  }

  static String fetchDate(Map<String, dynamic> data) {
    try {
      return data['response']['song']['release_date_for_display'];
    } catch (Exception) {
      return "";
    }
  }

  factory Song.fromJson(Map<String, dynamic> data) {
    return Song(
      title: fetchTitle(data),
      artist: fetchArtist(data),
      album: fetchAlbum(data),
      date: fetchDate(data),
    );
  }
}
