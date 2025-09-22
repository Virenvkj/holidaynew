// To parse this JSON data, do
//
//     final CountryMaster = CountryMasterFromJson(jsonString);

import 'dart:convert';

import 'package:holidaynew/models/countries/country_details.dart';

CountryMaster countryMasterFromJson(String str) =>
    CountryMaster.fromJson(json.decode(str));

String countryMasterToJson(CountryMaster data) => json.encode(data.toJson());

class CountryMaster {
  final List<CountryDetails> countries;

  CountryMaster({
    required this.countries,
  });

  factory CountryMaster.fromJson(Map<String, dynamic> json) => CountryMaster(
        countries: List<CountryDetails>.from(
            json["countries"].map((x) => CountryDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}
