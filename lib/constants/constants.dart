class AppConstants {
  static String baseUrl = 'https://api.staging.paymee.app/api';
  static String sendSMS = '$baseUrl/v2/mobile/authentication/send_sms';
  static String verifySMSCode = '$baseUrl/v2/mobile/business/verify_code';
  static String registerNewUser = '$baseUrl/v2/mobile/business/register';
  static String loginWithPin = '$baseUrl/v2/mobile/business/login/pin';
  static String sendSMSLogin = '$baseUrl/v2/mobile/business/login';
  static String confirmLogin = '$baseUrl/v2/mobile/business/login/confirm';
  static String completeDocs =
      '$baseUrl/v2/mobile/business/complete_submission';
  static String sheckEmail = '$baseUrl/v2/mobile/business/checkMail';
}
