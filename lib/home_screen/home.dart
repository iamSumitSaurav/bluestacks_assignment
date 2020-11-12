import 'package:assignment_bluestacks/model/model.dart';
import 'package:assignment_bluestacks/model/user_details.dart';
import 'package:assignment_bluestacks/network/network.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final int itemIndex;
  HomeView({this.itemIndex});
  @override
  _HomeViewState createState() => _HomeViewState(itemIndex);
}

class _HomeViewState extends State<HomeView> {
  final int itemIndex;
  _HomeViewState(this.itemIndex);
  Future<GameModel> gameModel;
  @override
  void initState() {
    super.initState();

    gameModel = Network().getGames();

    gameModel.then((game) => {print(game.data.tournaments[0].gameName)});
  }

  @override
  Widget build(BuildContext context) {
    var user = UserDetails.getUserDetails()[itemIndex];
    var _winningPercentage =
        (user.tournamentsWon / user.tournamentsPlayed) * 100;
    return Scaffold(
        backgroundColor: Colors.blueGrey[100],
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.notes_outlined),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.24),
                Text("${user.username}",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(height: 10),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(user.profilePhoto),
                      radius: 55,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 20),
                          child: Text("${user.name}",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            height: 50,
                            width: 170,
                            //color: Colors.white,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white),

                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 10),
                                  child: Text("${user.rating}",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Text("Elo rating")
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: _gameDetails("${user.tournamentsPlayed}",
                        "Tournaments played", Colors.white),
                    decoration: BoxDecoration(
                        color: Colors.amber[700],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25))),
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.3),
                SizedBox(width: 2),
                Container(
                    child: _gameDetails("${user.tournamentsWon}",
                        "Tournaments won", Colors.white),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[400],
                    ),
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.3),
                SizedBox(width: 2),
                Container(
                    child: _gameDetails(
                        _winningPercentage.toStringAsFixed(0) + "%",
                        "Winning percentage",
                        Colors.white),
                    decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.3),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, bottom: 15),
              child: Text("Recommended for you",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Container(
              child: FutureBuilder<GameModel>(
                future: gameModel,
                builder:
                    (BuildContext context, AsyncSnapshot<GameModel> snapshot) {
                  if (snapshot.hasData) {
                    return _bottomView(snapshot);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                          child: Container(child: CircularProgressIndicator())),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }

  Widget _gameDetails(String data, String detailsType, Color color) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 5),
          child: Text(data,
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: color)),
        ),
        Text(
          detailsType.split(" ")[0],
          style: TextStyle(color: color, fontSize: 16),
        ),
        Text(
          detailsType.split(" ")[1],
          style: TextStyle(color: color, fontSize: 16),
        )
      ],
    );
  }

  Widget _bottomView(AsyncSnapshot<GameModel> snapshot) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemCount: snapshot.data.data.tournaments.length,
            itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: _gameCardContainer(snapshot, index))),
      ),
    );
  }

  Widget _gameCardContainer(AsyncSnapshot<GameModel> snapshot, int index) {
    var data = snapshot.data.data.tournaments;
    return Container(
      height: 200,
      child: Column(
        children: [
          Container(
              height: 110,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(data[index].coverUrl)))),
          Container(
            height: 90,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "${data[index].gameName}",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text("${data[index].name}",
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.75))),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: Colors.black.withOpacity(0.5),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
