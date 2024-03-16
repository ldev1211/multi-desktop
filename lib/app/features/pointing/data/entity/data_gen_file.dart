import 'package:multi_desktop/app/features/login/data/enitity/student_entity.dart';
import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';

class StudentPoint {
  StudentEntity student;
  List<PointExt> points;

  StudentPoint({required this.student, required this.points});
}
