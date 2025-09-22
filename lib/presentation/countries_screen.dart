import 'package:flutter/material.dart';
import 'package:holidaynew/presentation/widgets/country_card.dart';
import 'package:holidaynew/providers/fetch_country_provider.dart';
import 'package:provider/provider.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FetchCountryProvider>().fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Countries')),
      body: Consumer<FetchCountryProvider>(
        builder: (context, value, child) {
          final isLoading = value.isLoading;
          final countryData = value.countryData;

          return isLoading
              ? const Center(child: CircularProgressIndicator())
              : (countryData == null || countryData.countries.isEmpty)
              ? const Center(child: Text('No data found'))
              : ListView.builder(
                  itemCount: countryData.countries.length,
                  itemBuilder: (context, index) {
                    return CountryCard(
                      country: countryData.countries[index],
                      index: index,
                    );
                  },
                );
        },
      ),
    );
  }
}
