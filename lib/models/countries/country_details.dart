import 'package:holidaynew/models/countries/curreny_details.dart';

class CountryDetails {
  final String code;
  final String name;
  final List<CurrencyDetails> currencies;
  final String flag;

  CountryDetails({
    required this.code,
    required this.name,
    required this.currencies,
    required this.flag,
  });

  factory CountryDetails.fromJson(Map<String, dynamic> json) => CountryDetails(
        code: json["code"],
        name: json["name"],
        currencies: List<CurrencyDetails>.from(
            json["currencies"].map((x) => CurrencyDetails.fromJson(x))),
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "currencies": List<dynamic>.from(currencies.map((x) => x.toJson())),
        "flag": flag,
      };
}
