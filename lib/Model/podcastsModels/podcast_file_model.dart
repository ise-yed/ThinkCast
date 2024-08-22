
// ignore_for_file: prefer_interpolation_to_compose_strings

class PodcastFileModel {
  String? id;
  String? podcastId;
  String? file;
  String? title;
  String? length;

  PodcastFileModel();

  PodcastFileModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    podcastId = element["podcast_id"];
    file = "https://thinkcast.ir/" + element["file"];
    title = element["title"];
    length = element["length"];
  }
}
