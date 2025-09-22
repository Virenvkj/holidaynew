// To parse this JSON data, do
//
//     final holidayMaster = holidayMasterFromJson(jsonString);

import 'dart:convert';

import 'package:holidaynew/models/holidays/holiday_details.dart';

HolidayMaster holidayMasterFromJson(String str) =>
    HolidayMaster.fromJson(json.decode(str));

String holidayMasterToJson(HolidayMaster data) => json.encode(data.toJson());

class HolidayMaster {
  final List<HolidayDetails> holidays;

  HolidayMaster({
    required this.holidays,
  });

  factory HolidayMaster.fromJson(Map<String, dynamic> json) => HolidayMaster(
        holidays: List<HolidayDetails>.from(
            json["holidays"].map((x) => HolidayDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "holidays": List<dynamic>.from(holidays.map((x) => x.toJson())),
      };
}
