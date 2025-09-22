import 'package:flutter/widgets.dart';
import 'package:holidaynew/core/api_requests.dart' show ApiRequests;
import 'package:holidaynew/models/countries/country_master.dart';
import 'package:http/http.dart' as http;

class FetchCountryProvider with ChangeNotifier {
  bool _isLoading = false;
  CountryMaster? _countryData;

  bool get isLoading => _isLoading;
  CountryMaster? get countryData => _countryData;

  Future<void> fetchCountries() async {
    _isLoading = true;

    final response = await http.get(Uri.parse(ApiRequests.countryList));
    if (response.statusCode == 200) {
      _countryData = countryMasterFromJson(response.body);
    }

    _isLoading = false;
    notifyListeners();
  }
}
