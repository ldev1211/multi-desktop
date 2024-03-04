import 'package:bloc/bloc.dart';
import 'package:multi_desktop/app/features/pointing/data/entity/EPointExt.dart';
import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';
import 'package:multi_desktop/main.dart';

import 'state.dart';

class PointingCubit extends Cubit<PointingState> {
  PointingCubit() : super(InitState());
  late List<PointExt> points;
  List<EPointExt> ePointsExt = [];
  Future<void> fetchPoint({required String stuCode}) async {
    emit(FetchingPointState());
    final response = await service.getPointExt(stuCode);
    points = response.data;
    for (var e in points) {
      if (e.type == TypeRow.HEADER) {
        ePointsExt.add(EPointExt(e.content, []));
      } else {
        ePointsExt.last.points.add(e);
      }
    }
    emit(FetchedPointState(points: ePointsExt));
  }
}
