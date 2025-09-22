class ApiRequests {
  ApiRequests._();

  static const String baseUrl = 'https://holidayapi.com/v1/';
  static const String countryList =
      '${baseUrl}countries?pretty&key=75bd9324-2e21-4baf-8d33-2e3813b0d79f';
  static const String holidayList = '${baseUrl}holidays';
  static const String workingDays = '${baseUrl}workdays';
}
