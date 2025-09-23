import 'package:flutter/material.dart';
import 'package:holidaynew/models/countries/country_details.dart';
import 'package:holidaynew/providers/working_days_provider.dart';
import 'package:provider/provider.dart';

class WorkingDaysScreen extends StatelessWidget {
  const WorkingDaysScreen({super.key, required this.country});

  final CountryDetails country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${country.name} Working days')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<WorkingDaysProvider>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Start date : '),
                InkWell(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2024, 1, 1),
                      lastDate: DateTime(2024, 12, 31),
                      initialDate: value.startDate,
                    );
                    if (selectedDate != null) {
                      value.startDate = selectedDate;
                    }
                  },
                  child: Text(
                    value.startDate.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                const Text('End date : '),
                InkWell(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2024, 1, 1),
                      lastDate: DateTime(2024, 12, 31),
                      initialDate: value.endDate,
                    );

                    if (selectedDate != null) {
                      value.endDate = selectedDate;
                    }
                  },
                  child: Text(
                    value.endDate.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await context
                          .read<WorkingDaysProvider>()
                          .calcuateWorkingDays(
                            countryCode: country.code,
                            context: context,
                          );
                    },
                    child: const Text(
                      'Calculate Working days',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                if (value.workingDays != null)
                  Center(
                    child: Consumer<WorkingDaysProvider>(
                      builder: (context, value, child) {
                        return Text(
                          value.workingDays!.workdays.toString(),
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
