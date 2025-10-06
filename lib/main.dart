import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holidaynew/bloc/working_days/working_days_cubit.dart';
import 'package:holidaynew/presentation/countries_screen.dart';
import 'package:holidaynew/providers/fetch_country_provider.dart';
import 'package:holidaynew/providers/holiday_provider.dart';
import 'package:holidaynew/providers/working_days_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => WorkingDaysCubit())],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FetchCountryProvider()),
          ChangeNotifierProvider(create: (context) => WorkingDaysProvider()),
          ChangeNotifierProvider(create: (context) => HolidayProvider()),
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
      ),
    );
  }
}
