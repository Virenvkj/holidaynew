import 'package:flutter/material.dart';
import 'package:holidaynew/models/holidays/holiday_master.dart';
import 'package:http/http.dart' as http;
import 'package:holidaynew/core/api_requests.dart';

class HolidayProvider with ChangeNotifier {
  bool _isLoading = false;
  HolidayMaster? _holidayData;

  bool get isLoading => _isLoading;
  HolidayMaster? get holidayData => _holidayData;

  Future<void> getHolidays({
    required String countryCode,
    required BuildContext context,
  }) async {
    _isLoading = true;

    final response = await http.get(
      Uri.parse(
        '${ApiRequests.holidayList}?country=$countryCode&year=2024&pretty&key=75bd9324-2e21-4baf-8d33-2e3813b0d79f',
      ),
    );

    if (response.statusCode == 200) {
      _holidayData = holidayMasterFromJson(response.body);
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }

    _isLoading = false;
    notifyListeners();
  }
}
