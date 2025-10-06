import 'package:flutter/material.dart';
import 'package:holidaynew/core/api_requests.dart';
import 'package:holidaynew/models/working_days/working_days_details.dart';
import 'package:http/http.dart' as http;

class WorkingDaysProvider with ChangeNotifier {
  DateTime _startDate = DateTime(2024, 1, 1);
  DateTime _endDate = DateTime(2024, 12, 31);
  WorkingDaysDetails? _workingDays;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  WorkingDaysDetails? get workingDays => _workingDays;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;

  set startDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  set endDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  Future<void> calcuateWorkingDays({
    required String countryCode,
    required BuildContext context,
  }) async {
    _isLoading = true;

    final response = await http.get(
      Uri.parse(
        '${ApiRequests.workingDays}?country=$countryCode&start=${startDate.toString()}&end=${endDate.toString()}&pretty&key=75bd9324-2e21-4baf-8d33-2e3813b0d79f',
      ),
    );

    if (response.statusCode == 200) {
      _workingDays = workingDaysDetailsFromJson(response.body);
      
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Success')));
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
