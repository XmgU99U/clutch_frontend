class AppUrls {
  // localhost or 192.168.8.166
  static const String _base = 'http://192.168.8.166:8000/';
  static const String login = '${_base}auth/login';
  static const String register = '${_base}auth/register';
  static const String verifyEmail = '${_base}auth/verify_email';
  static const String refresh = '${_base}auth/refresh';
  static const String logout = '${_base}auth/logout';
  static const String resendVerificationCode =
      '${_base}auth/resend_verification_code';
}
