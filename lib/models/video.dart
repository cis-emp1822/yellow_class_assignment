class Video {
  int? id;
  String? title;
  String? videoUrl;
  String? coverPicture;

  Video({id, title, videoUrl, coverPicture});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    videoUrl = json['videoUrl'];
    coverPicture = json['coverPicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['videoUrl'] = videoUrl;
    data['coverPicture'] = coverPicture;
    return data;
  }
}
