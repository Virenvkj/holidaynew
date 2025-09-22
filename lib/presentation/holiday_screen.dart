import 'package:flutter/material.dart';
import 'package:holidaynew/core/api_requests.dart';
import 'package:holidaynew/models/countries/country_details.dart';
import 'package:holidaynew/models/holidays/holiday_master.dart';
import 'package:holidaynew/presentation/widgets/holiday_card.dart';
import 'package:http/http.dart' as http;

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({
    super.key,
    required this.country,
  });

  final CountryDetails country;

  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  bool isLoading = false;
  late HolidayMaster holidayData;

  Future<void> getHolidays() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse(
        '${ApiRequests.holidayList}?country=${widget.country.code}&year=2024&pretty&key=75bd9324-2e21-4baf-8d33-2e3813b0d79f',
      ),
    );

    if (response.statusCode == 200) {
      holidayData = holidayMasterFromJson(response.body);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getHolidays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.country.name} Holidays'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (holidayData.holidays.isEmpty)
              ? const Center(
                  child: Text('No holidays found'),
                )
              : ListView.builder(
                  itemCount: holidayData.holidays.length,
                  itemBuilder: (context, index) => HolidayCard(
                    index: index,
                    holidayDetails: holidayData.holidays[index],
                  ),
                ),
    );
  }
}
