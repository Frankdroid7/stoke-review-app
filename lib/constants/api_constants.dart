class ApiConstants {
  ApiConstants._();

  static const String baseUrl =
      'http://stokereviewsapi-dev.eu-west-2.elasticbeanstalk.com';
  static const String loginUser = '$baseUrl/Token/GetToken';
  static const String registerUser = '$baseUrl/register-user';
}
