import 'package:multi_desktop/app/features/pointing/data/entity/EPointExt.dart';

class PointingState {}

class InitState extends PointingState {}

class FetchingPointState extends PointingState {}

class FetchedPointState extends PointingState {
  List<EPointExt> points;

  FetchedPointState({required this.points});
}
