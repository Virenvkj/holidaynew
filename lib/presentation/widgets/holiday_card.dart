import 'package:flutter/material.dart';
import 'package:holidaynew/models/holidays/holiday_details.dart';

class HolidayCard extends StatelessWidget {
  const HolidayCard({
    super.key,
    required this.index,
    required this.holidayDetails,
  });

  final HolidayDetails holidayDetails;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (index % 2 == 0) ? Colors.blue[100] : Colors.yellow[100],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10).copyWith(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            holidayDetails.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            holidayDetails.date.toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
