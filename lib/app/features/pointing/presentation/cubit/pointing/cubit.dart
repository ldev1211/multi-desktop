import 'package:bloc/bloc.dart';
import 'package:multi_desktop/app/features/pointing/data/entity/EPointExt.dart';
import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';
import 'package:multi_desktop/app/features/pointing/data/model/response_cert.dart';
import 'package:multi_desktop/main.dart';

import 'state.dart';

class PointingCubit extends Cubit<PointingState> {
  PointingCubit() : super(InitState());
  late List<PointExt> points;
  late List<EPointExt> ePoints;
  Future<List<PointExt>?> fetchPoint(
      {required String stuCode, required bool isEmit}) async {
    if (!isEmit) emit(FetchingPointState());
    final response = await service.getPointExt(stuCode);
    points = response.data;
    ePoints = [];
    int totalSelf = 0;
    int totalFinal = 0;
    int totalFullSelf = 0;
    int totalFullFinal = 0;
    for (var e in points) {
      if (e.type == TypeRow.TOTAL) {
        e.pointSelf = totalSelf;
        e.pointFinal = totalFinal;
        totalSelf = 0;
        totalFinal = 0;
        continue;
      }
      if (e.pointRule != null) {
        totalSelf += e.pointSelf ?? 0;
        totalFinal += e.pointFinal ?? 0;
        totalFullSelf += e.pointSelf ?? 0;
        totalFullFinal += e.pointFinal ?? 0;
      }
    }
    if (!isEmit) return points;
    emit(FetchedPointState(
      points: points,
      totalFinal: totalFullFinal,
      totalSelf: totalFullSelf,
    ));
    return null;
  }

  late Cert cert;

  Future<void> fetchCert({required String stuCode}) async {
    emit(FetchingCertState());
    ResponseCert responseCert = await service.fetchCert(stuCode);
    cert = responseCert.data;
    emit(FetchedCertState(cert));
  }
}
