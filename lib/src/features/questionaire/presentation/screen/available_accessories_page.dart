import 'package:boilerplate/src/features/questionaire/domain/entities/entities.dart';
import 'package:boilerplate/src/features/questionaire/presentation/cubits/device_assessment_cubit.dart';
import 'package:boilerplate/src/features/questionaire/presentation/models/flow_state.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/product_condition_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableAccessoriesPage extends StatelessWidget {
  const AvailableAccessoriesPage({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocSelector<DeviceAssessmentCubit, DeviceAssessmentState, Accessories?>(
        selector: (state) => state.input.accessories,
        builder: (context, state) {
          final cubit = context.read<DeviceAssessmentCubit>();
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: [
                SizedBox(height: 30.h),
                IssueSection(
                  title: "Available Accessories",
                  issues: [
                    IssueData(
                      title: "Original charger of device",
                      image: "assets/images/question/charger.png",
                      isSelected: state?.originalCharger ?? false,
                      onTap: () {
                        final accessories =
                            cubit.input.accessories ?? Accessories.none;
                        cubit.accessoriesChanged(
                          accessories.copyWith(
                            originalCharger: !accessories.originalCharger,
                          ),
                        );
                      },
                    ),
                    IssueData(
                      title: "Original box of the phone",
                      image: "assets/images/question/original_box.png",
                      isSelected: state?.originalBox ?? false,
                      onTap: () {
                        final accessories =
                            cubit.input.accessories ?? Accessories.none;
                        cubit.accessoriesChanged(
                          accessories.copyWith(
                            originalBox: !accessories.originalBox,
                          ),
                        );
                      },
                    ),
                  ],
                ),
            
                SizedBox(height: 50.h),
              ],
            ),
          );
        },
      );
}
