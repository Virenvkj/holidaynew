import 'package:bloc/bloc.dart';
import 'package:holidaynew/bloc/working_days/working_days_state.dart';
import 'package:holidaynew/core/api_requests.dart';
import 'package:holidaynew/models/working_days/working_days_details.dart';
import 'package:http/http.dart' as http;

class WorkingDaysCubit extends Cubit<WorkingDaysState> {
  WorkingDaysCubit()
    : super(
        WorkingDaysState(
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 12, 31),
          isLoading: false,
          isError: false,
        ),
      );

  void updateStartDate(DateTime value) {
    emit(state.copyWith(startDate: value));
  }

  void updateEndDate(DateTime value) {
    emit(state.copyWith(endDate: value));
  }

  Future<void> calcuateWorkingDays({required String countryCode}) async {
    try {
      emit(state.copyWith(isLoading: true));

      final response = await http.get(
        Uri.parse(
          '${ApiRequests.workingDays}?country=$countryCode&start=${state.startDate.toString()}&end=${state.endDate.toString()}&pretty&key=75bd9324-2e21-4baf-8d33-2e3813b0d79f',
        ),
      );

      if (response.statusCode == 200) {
        emit(
          state.copyWith(
            workingDays: workingDaysDetailsFromJson(response.body),
          ),
        );
      } else {
        throw Exception();
      }

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }
}
