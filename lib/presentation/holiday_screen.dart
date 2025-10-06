import 'package:flutter/material.dart';

import 'package:holidaynew/models/countries/country_details.dart';
import 'package:holidaynew/presentation/widgets/holiday_card.dart';
import 'package:holidaynew/providers/holiday_provider.dart';
import 'package:provider/provider.dart';

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({super.key, required this.country});

  final CountryDetails country;

  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HolidayProvider>().getHolidays(
      countryCode: widget.country.code,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        print("user trying to go back : ${result.toString()}");
      },
      child: Scaffold(
        appBar: AppBar(title: Text('${widget.country.name} Holidays')),
        body: Consumer<HolidayProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (value.holidayData == null) {
              return const Center(child: Text('No holidays found'));
            }

            return ListView.builder(
              itemCount: value.holidayData!.holidays.length,
              itemBuilder: (context, index) => HolidayCard(
                index: index,
                holidayDetails: value.holidayData!.holidays[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
