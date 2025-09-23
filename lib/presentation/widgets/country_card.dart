import 'package:flutter/material.dart';
import 'package:holidaynew/models/countries/country_details.dart';
import 'package:holidaynew/presentation/holiday_screen.dart';
import 'package:holidaynew/presentation/working_days_screen.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({super.key, required this.index, required this.country});

  final CountryDetails country;
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
          Row(
            children: [
              Image.network(
                country.flag,
                width: 30,
                height: 30,
                errorBuilder: (context, error, stackTrace) => Image.network(
                  'https://flagsapi.com/IN/flat/64.png',
                  width: 30,
                  height: 30,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                country.code,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            country.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          (country.currencies.isEmpty)
              ? const SizedBox.shrink()
              : Text(
                  'Currency : ${country.currencies.first.alpha}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HolidayScreen(country: country),
                    ),
                  );
                },
                child: const Text(
                  'Get holidays',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WorkingDaysScreen(country: country),
                    ),
                  );
                },
                child: const Text(
                  'Get working days',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
