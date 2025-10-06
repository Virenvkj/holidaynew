import 'package:holidaynew/models/working_days/working_days_details.dart';

class WorkingDaysState {
  WorkingDaysState({
    required this.startDate,
    required this.endDate,
    this.workingDays,
    required this.isLoading,
    required this.isError,
  });

  final DateTime startDate;
  final DateTime endDate;
  final WorkingDaysDetails? workingDays;
  final bool isLoading;
  final bool isError;

  WorkingDaysState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    WorkingDaysDetails? workingDays,
    bool? isLoading,
    bool? isError,
  }) {
    return WorkingDaysState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      workingDays: workingDays ?? this.workingDays,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
