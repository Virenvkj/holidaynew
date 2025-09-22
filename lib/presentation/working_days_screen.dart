import 'package:flutter/material.dart';
import 'package:holidaynew/core/api_requests.dart';
import 'package:holidaynew/models/countries/country_details.dart';
import 'package:holidaynew/models/working_days/working_days_details.dart';
import 'package:http/http.dart' as http;

class WorkingDaysScreen extends StatefulWidget {
  const WorkingDaysScreen({
    super.key,
    required this.country,
  });

  final CountryDetails country;

  @override
  State<WorkingDaysScreen> createState() => _WorkingDaysScreenState();
}

class _WorkingDaysScreenState extends State<WorkingDaysScreen> {
  DateTime startDate = DateTime(2024, 1, 1);
  DateTime endDate = DateTime(2024, 12, 31);
  WorkingDaysDetails? workingDays;
  bool isLoading = false;

  Future<void> calcuateWorkingDays() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse(
          '${ApiRequests.workingDays}?country=${widget.country.code}&start=${startDate.toString()}&end=${endDate.toString()}&pretty&key=75bd9324-2e21-4baf-8d33-2e3813b0d79f'),
    );

    if (response.statusCode == 200) {
      workingDays = workingDaysDetailsFromJson(response.body);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.country.name} Working days'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Start date : '),
                  InkWell(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2024, 1, 1),
                        lastDate: DateTime(2024, 12, 31),
                        initialDate: startDate,
                      );
                      setState(() {
                        if (selectedDate != null) {
                          startDate = selectedDate;
                        }
                      });
                    },
                    child: Text(
                      startDate.toString(),
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
                        initialDate: endDate,
                      );
                      setState(() {
                        if (selectedDate != null) {
                          endDate = selectedDate;
                        }
                      });
                    },
                    child: Text(
                      endDate.toString(),
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
                        await calcuateWorkingDays();
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
                  if (workingDays != null)
                    Center(
                      child: Text(
                        workingDays!.workdays.toString(),
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ],
              ),
      ),
    );
  }
}
