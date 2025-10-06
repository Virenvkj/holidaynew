import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holidaynew/bloc/working_days/working_days_cubit.dart';
import 'package:holidaynew/bloc/working_days/working_days_state.dart';
import 'package:holidaynew/models/countries/country_details.dart';

class WorkingDaysScreenBloc extends StatelessWidget {
  const WorkingDaysScreenBloc({super.key, required this.country});

  final CountryDetails country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${country.name} Working days')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<WorkingDaysCubit, WorkingDaysState>(
          listener: (context, state) {
            if (state.workingDays != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Success")));
            }
            if (state.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Oops something went wrong"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isError) {
              return const Center(
                child: Text('Something went wrong, please try again !'),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Start date : '),
                InkWell(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2024, 1, 1),
                      lastDate: DateTime(2024, 12, 31),
                      initialDate: state.startDate,
                    );
                    if (selectedDate != null) {
                      if (!context.mounted) return;
                      context.read<WorkingDaysCubit>().updateStartDate(
                        selectedDate,
                      );
                    }
                  },
                  child: Text(
                    state.startDate.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                const Text('End date : '),
                InkWell(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2024, 1, 1),
                      lastDate: DateTime(2024, 12, 31),
                      initialDate: state.endDate,
                    );

                    if (selectedDate != null) {
                      if (!context.mounted) return;
                      context.read<WorkingDaysCubit>().updateEndDate(
                        selectedDate,
                      );
                    }
                  },
                  child: Text(
                    state.endDate.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await context
                          .read<WorkingDaysCubit>()
                          .calcuateWorkingDays(countryCode: country.code);
                    },
                    child: const Text(
                      'Calculate Working days',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                if (state.workingDays != null)
                  Center(
                    child: Text(
                      state.workingDays!.workdays.toString(),
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
