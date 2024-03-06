import 'package:bloc/bloc.dart';
import 'package:multi_desktop/app/features/pointing/data/entity/EPointExt.dart';
import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';
import 'package:multi_desktop/main.dart';

import 'state.dart';

class PointingCubit extends Cubit<PointingState> {
  PointingCubit() : super(InitState());
  late List<PointExt> points;
  Future<void> fetchPoint({required String stuCode}) async {
    emit(FetchingPointState());
    final response = await service.getPointExt(stuCode);
    points = response.data;
    emit(FetchedPointState(points: points));
  }
}
