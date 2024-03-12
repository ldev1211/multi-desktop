import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';

class PointingState {}

class InitState extends PointingState {}

class FetchingPointState extends PointingState {}

class FetchedPointState extends PointingState {
  List<PointExt> points;
  int totalSelf;
  int totalFinal;

  FetchedPointState({
    required this.points,
    required this.totalFinal,
    required this.totalSelf,
  });
}
