import 'package:flutter/material.dart';
import 'package:multi_desktop/app/features/login/data/enitity/student_entity.dart';
import 'package:multi_desktop/app/features/pointing/data/entity/EPointExt.dart';
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
  late List<EPointExt> ePoints;
  late List<PointExt> points;

  late Size size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    points = widget.points;
  }

  int subTotalFinal = 0;
  int totalSelf = 0;
  int totalFinal = 0;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    subTotalFinal = 0;
    totalSelf = 0;
    totalFinal = 0;
    for (var e in points) {
      if (e.type == TypeRow.TOTAL) {
        e.pointFinal = subTotalFinal;
        subTotalFinal = 0;
        continue;
      }
      totalFinal += e.pointFinal ?? 0;
      subTotalFinal += e.pointFinal ?? 0;
      totalSelf += e.pointSelf ?? 0;
    }
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
            itemCount: points.length + 1,
            itemBuilder: (context, i) {
              if (i == points.length) {
                return buildTotal(totalSelf, totalFinal);
              }
              PointExt pointExt = points[i];

              return ViewRowPoint(
                point: pointExt,
                onChangePoint: (point) {
                  Map<String, dynamic> body = {
                    "idFormPoint": pointExt.id,
                    "point": point,
                    'mssv': widget.student.stuCode
                  };
                  setState(() {});
                  service.postPoint(body);
                },
              );
            },
          ),
        )
      ],
    );
  }

  Widget buildTotal(int totalSelf, totalFinal) {
    return IntrinsicHeight(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: AppColor.colorMain),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const VerticalDivider(
              width: 1,
              color: AppColor.colorMain,
              thickness: 1,
            ),
            Container(
              width: size.width * 0.3 - 2,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Text(
                "Tổng điểm",
                style: TextStyle(
                  color: AppColor.colorMain,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const VerticalDivider(
              width: 1,
              color: AppColor.colorMain,
              thickness: 1,
            ),
            Container(
              width: size.width * 0.1 - 1,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Text(
                "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.colorMain,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const VerticalDivider(
              width: 1,
              color: AppColor.colorMain,
              thickness: 1,
            ),
            Container(
              width: size.width * 0.1 - 1,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                "$totalSelf điểm",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColor.colorMain,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const VerticalDivider(
              width: 1,
              color: AppColor.colorMain,
              thickness: 1,
            ),
            Container(
              width: size.width * 0.1 - 1,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                "$totalFinal điểm",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColor.colorMain,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const VerticalDivider(
              width: 1,
              color: AppColor.colorMain,
              thickness: 1,
            )
          ],
        ),
      ),
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
