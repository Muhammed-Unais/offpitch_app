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
}
