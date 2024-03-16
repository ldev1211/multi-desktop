import 'package:flutter/material.dart' hide Border, BorderStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_desktop/app/features/login/data/enitity/student_entity.dart';
import 'package:multi_desktop/app/features/pointing/data/entity/form_ext_point.dart';
import 'package:multi_desktop/app/features/pointing/presentation/cubit/pointing/cubit.dart';
import 'package:multi_desktop/app/features/pointing/presentation/cubit/pointing/state.dart';
import 'package:multi_desktop/app/widget/app_bar.dart';
import 'package:multi_desktop/app/widget/app_progress.dart';
import 'package:multi_desktop/app/widget/header_user.dart';

class PointingPage extends StatefulWidget {
  PointingPage({super.key, required this.stuCode});

  StudentEntity stuCode;

  @override
  State<PointingPage> createState() => _PointingPageState();
}

class _PointingPageState extends State<PointingPage> {
  late StudentEntity student;

  final PointingCubit _cubit = PointingCubit();

  String? path;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    student = widget.stuCode;
    _cubit.fetchPoint(stuCode: student.stuCode, isEmit: true);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppAppBar(title: "Chấm điểm"),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: HeaderUser.pointExt(student),
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<PointingCubit, PointingState>(
                    buildWhen: (prev, curr) {
                      return curr is FetchedPointState ||
                          curr is FetchingPointState;
                    },
                    builder: (context, state) {
                      if (state is FetchedPointState) {
                        return FormExtPoint(
                          points: state.points,
                          student: student,
                        );
                      }
                      return const Center(
                        child: Center(
                          child: AppProgress(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
