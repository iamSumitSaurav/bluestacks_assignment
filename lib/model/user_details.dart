// Dummy User Details //

class UserDetails {
  static List<UserDetails> getUserDetails() => [
        /*       username : realTrump, password : donald123     */
        UserDetails("Donald Trump", "realTrump", "donald123",
            "images/trump.jpg", 2000, 30, 20),

        /*       username : iamModi, password : modi123         */
        UserDetails("Narendra Modi", "iamModi", "modi123", "images/modi.jpg",
            5500, 70, 55),

        /*       username : kingKhan, password : king123         */
        UserDetails("Shah Rukh Khan", "kingKhan", "king123",
            "images/shah_rukh_khan.jpg", 1500, 80, 45),
      ];

  String name;
  String username;
  String password;
  String profilePhoto;
  int rating;
  int tournamentsPlayed;
  int tournamentsWon;
  int winningPercentage;

  UserDetails(this.name, this.username, this.password, this.profilePhoto,
      this.rating, this.tournamentsPlayed, this.tournamentsWon);
}
