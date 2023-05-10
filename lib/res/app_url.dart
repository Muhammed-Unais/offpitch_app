class AppUrl {
  // Base url
  static var baseUrl = "https://offpitch.live/api";

  // login post uri
  static var loginEndPoint = "$baseUrl/auth/login";

  // signup post uri
  static var signupEndPoint = "$baseUrl/auth/signup";

  // otp verify post uri
  static var otpVerifyEndPoint = "$baseUrl/auth/verify-email";

  // forgotPasswordEndPoint
  static var forgotPasswordEndPonint = "$baseUrl/auth/forgot-password";

  // user logout========
  static var userlogout = "$baseUrl/auth/logout";

  //All tournamentsEndpoint
  static var allTournaments = "$baseUrl/tournaments";

  //
  static var club = "$baseUrl/user/club";

  //
  static var refreshToken = "$baseUrl/auth/refresh";

  // single tornament apiendpoint
  static var singleTournament = "$baseUrl/tournament/";

  //
  static var clubCreation = "$baseUrl/user/club";

  //
  static var createTournament = "$baseUrl/user/tournament";

  static var playersClub = "$baseUrl/user/players";

  //
  static var addPlayers = "$baseUrl/user/player";

  static var userHostedTournaments = "$baseUrl/user/tournaments";

  static var scheduleTournament = "$baseUrl/user/tournament";

  static var registerTournamement = "$baseUrl/user/tournament/";

  static var userRegisteredTournamements =
      "$baseUrl/user/tournaments/registered";

  static var tournamentTypeT1AddResult = "$baseUrl/user/tournament/";

  // user profile ===============
  static var userProfile = "$baseUrl/user/profile";

  // user watchList ===============
  static var userWatchlist = "$baseUrl/user/watchlist";

  // save payment============
  static var paymentSave = "$baseUrl/user/tournament";

  // Add Result ============
  static var addResult = "$baseUrl/user/tournament";
}
