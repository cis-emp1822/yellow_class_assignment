import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yellow_class_parikshit/models/video.dart';

class ApisHere {
  Future<Stream<List<Video>>> getPlaylist(BuildContext context,
      {Map<String, List<String>>? filters}) async {
    try {
      String data = await DefaultAssetBundle.of(context)
          .loadString("lib/jsons/videos.json");
      final jsonResult = jsonDecode(data); //l
      if (jsonResult['status']) {
        List<dynamic> gets = jsonResult['data'] as List<dynamic>;
        List<Video> playlists =
            gets.map<Video>((e) => Video.fromJson(e)).toList();

        return Stream.value(playlists);
      } else {
        return Stream.error("error Occurred Fetching Videos");
      }
    } catch (e) {
      return Stream.error(e.toString());
    }
  }
}
