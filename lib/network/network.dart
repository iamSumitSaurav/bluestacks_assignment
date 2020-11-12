import 'dart:convert';
import 'package:assignment_bluestacks/model/model.dart';
import 'package:http/http.dart';

class Network {
  Future<GameModel> getGames() async {
    String url =
        "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?status=all";

    final response = await get(Uri.encodeFull(url));

    print("URL : ${Uri.encodeFull(url)}");

    if (response.statusCode == 200) {
      //we get actual mapped model (dart object)
      print("Game Model : ${response.body}");
      return GameModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting Game details! Please try again later.");
    }
  }
}
