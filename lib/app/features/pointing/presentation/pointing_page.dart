import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_desktop/app/features/pointing/presentation/cubit/pointing/cubit.dart';
import 'package:multi_desktop/app/features/pointing/presentation/cubit/pointing/state.dart';
import 'package:multi_desktop/app/widget/app_bar.dart';
import 'package:multi_desktop/app/widget/app_progress.dart';

class PointingPage extends StatefulWidget {
  PointingPage({super.key, required this.stuCode});

  String stuCode;

  @override
  State<PointingPage> createState() => _PointingPageState();
}

class _PointingPageState extends State<PointingPage> {
  late String stuCode;

  final PointingCubit _cubit = PointingCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stuCode = widget.stuCode;
    _cubit.fetchPoint(stuCode: stuCode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: AppAppBar(title: "Chấm điểm"),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              BlocBuilder<PointingCubit, PointingState>(
                buildWhen: (prev, curr) {
                  return curr is FetchedPointState ||
                      curr is FetchingPointState;
                },
                builder: (context, state) {
                  if (state is FetchedPointState) {
                    // return FormExtPoint(ePointExt: state.points);
                    return Text("DWWWQDW");
                  }
                  return const Center(
                    child: AppProgress(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
