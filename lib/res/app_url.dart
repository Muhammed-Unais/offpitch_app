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

  //All tournamentsEndpoint
  static var allTournaments = "$baseUrl/tournaments";

  //
  static var club = "$baseUrl/user/club";

  //
  static var refreshToken = "$baseUrl/auth/refresh";

  // single tornament apiendpoint
  static var singleTournament = "$baseUrl/tournament/";
}
