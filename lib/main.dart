import 'package:flutter/material.dart';
import 'package:holidaynew/presentation/countries_screen.dart';
import 'package:holidaynew/providers/fetch_country_provider.dart';
import 'package:holidaynew/providers/working_days_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FetchCountryProvider()),
        ChangeNotifierProvider(create: (context) => WorkingDaysProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CountriesScreen(),
      ),
    );
  }
}
