import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';
import 'package:multi_desktop/app/features/pointing/data/model/response_cert.dart';

class PointingState {}

class InitState extends PointingState {}

class FetchingPointState extends PointingState {}

class FetchingCertState extends PointingState {}

class FetchedCertState extends PointingState {
  Cert cert;

  FetchedCertState(this.cert);
}

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
