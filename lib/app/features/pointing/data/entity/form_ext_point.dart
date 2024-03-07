import 'package:flutter/material.dart';
import 'package:multi_desktop/app/features/login/data/enitity/student_entity.dart';
import 'package:multi_desktop/app/features/pointing/data/entity/view_row_point.dart';
import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';
import 'package:multi_desktop/main.dart';
import 'package:multi_desktop/util/app_colors.dart';

class FormExtPoint extends StatefulWidget {
  FormExtPoint({super.key, required this.student, required this.points});

  List<PointExt> points;
  StudentEntity student;
  @override
  State<FormExtPoint> createState() => _FormExtPointState();
}

class _FormExtPointState extends State<FormExtPoint> {
  late List<PointExt> points;

  late Size size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    points = widget.points;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(header: "Nội dung đánh giá"),
        Container(
          width: size.width * 0.6,
          height: size.height * 0.7,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColor.colorMain),
            ),
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: points.length,
            itemBuilder: (context, i) {
              PointExt pointExt = points[i];
              return ViewRowPoint(
                point: pointExt,
                onChangePoint: (point) {
                  Map<String, dynamic> body = {
                    "idFormPoint": pointExt.id,
                    "point": pointExt.pointSelf,
                    'mssv': widget.student.stuCode
                  };
                  service.postPoint(body);
                },
              );
            },
          ),
        )
      ],
    );
  }

  Widget buildHeader({required String header}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: size.width * 0.3,
          height: 66,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(24)),
            border: Border.all(color: AppColor.colorMain),
          ),
          child: Text(
            header,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: size.width * 0.1,
          height: 66,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: AppColor.colorMain),
              right: BorderSide(color: AppColor.colorMain),
              top: BorderSide(color: AppColor.colorMain),
            ),
          ),
          alignment: Alignment.center,
          child: const Text(
            "Điểm tối đa",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: size.width * 0.1,
          height: 66,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: AppColor.colorMain),
              right: BorderSide(color: AppColor.colorMain),
              top: BorderSide(color: AppColor.colorMain),
            ),
          ),
          alignment: Alignment.center,
          child: const Text(
            "Điểm cá nhân chấm",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: size.width * 0.1,
          height: 66,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: AppColor.colorMain),
              right: BorderSide(color: AppColor.colorMain),
              top: BorderSide(color: AppColor.colorMain),
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
            ),
          ),
          child: const Text(
            "Chấm",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
