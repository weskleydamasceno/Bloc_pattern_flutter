import 'dart:convert';

import 'package:fluttertube/models/video.dart';
import 'package:http/http.dart' as http;


const API_KEY = "AIzaSyCAEsEym1Kgi8R72k3jaqHsifqA-ivAj0Q";

class Api {

  search(String search) async {

    http.Response response = await http.get(
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
    );
    decode(response);
  }

  List<Video> decode(http.Response response) {
    if(response.statusCode == 200) {
      var decoded = json.decode(response.body);
      // Os videos no arquivo json são uma lista de mapas,
      // então pegou os mapas e transformou em um objeto do tipo video
      // e no final em uma lista de vídeos
      List<Video> videos = decoded["items"].map<Video>(
        (map) {
          return Video.fromJson(map);
        }
      ).toList();
      print(videos);
    } else {
      throw Exception("Failed to load videos");
    }
  }

}