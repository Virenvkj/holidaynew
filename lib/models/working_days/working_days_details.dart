// To parse this JSON data, do
//
//     final workingDaysDetails = workingDaysDetailsFromJson(jsonString);

import 'dart:convert';

WorkingDaysDetails workingDaysDetailsFromJson(String str) =>
    WorkingDaysDetails.fromJson(json.decode(str));

String workingDaysDetailsToJson(WorkingDaysDetails data) =>
    json.encode(data.toJson());

class WorkingDaysDetails {
  final int workdays;

  WorkingDaysDetails({
    required this.workdays,
  });

  factory WorkingDaysDetails.fromJson(Map<String, dynamic> json) =>
      WorkingDaysDetails(
        workdays: json["workdays"],
      );

  Map<String, dynamic> toJson() => {
        "workdays": workdays,
      };
}
