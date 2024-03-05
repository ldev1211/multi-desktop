import 'package:flutter/material.dart';
import 'package:multi_desktop/app/features/pointing/data/entity/EPointExt.dart';
import 'package:multi_desktop/app/features/pointing/data/entity/view_row_point.dart';
import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';
import 'package:multi_desktop/app/widget/header_user.dart';
import 'package:multi_desktop/main.dart';
import 'package:multi_desktop/util/app_colors.dart';

class FormExtPoint extends StatelessWidget {
  FormExtPoint({super.key, required this.pointExt});

  PointExt pointExt;

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderUser.pointExt(),
        Container(
          // width: size.width * 0.95,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColor.colorMain),
            ),
          ),
          height: size.height * 0.45,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: ePointExt.points.length,
            itemBuilder: (context, i) {
              PointExt pointExt = ePointExt.points[i];
              return ViewRowPoint(
                point: pointExt,
                onChangePoint: (point) {
                  Map<String, dynamic> body = {
                    "idFormPoint": pointExt.id,
                    "point": pointExt.pointSelf
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
          width: size.width * 0.55,
          height: 66,
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
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Container(
          width: size.width * 0.2,
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
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Container(
          width: size.width * 0.2,
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
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
