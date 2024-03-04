import 'dart:io';
import 'package:flutter/material.dart';
import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';
import 'package:multi_desktop/util/app_colors.dart';

class ViewRowPoint extends StatefulWidget {
  PointExt point;

  Function(int?) onChangePoint;

  ViewRowPoint({super.key, required this.point, required this.onChangePoint});
  @override
  State<ViewRowPoint> createState() => _ViewRowPointState();
}

class _ViewRowPointState extends State<ViewRowPoint> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.text = (widget.point.pointSelf != null)
        ? widget.point.pointSelf.toString()
        : "";
    return IntrinsicHeight(
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
            width: size.width * 0.55 - 2,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Text(
              "${widget.point.stt ?? ""} ${widget.point.content}",
              style: TextStyle(
                color: Colors.black,
                fontWeight: (widget.point.stt != null ||
                        widget.point.type == TypeRow.TOTAL)
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          const VerticalDivider(
            width: 1,
            color: AppColor.colorMain,
            thickness: 1,
          ),
          Container(
            width: size.width * 0.2 - 1,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Text(
              (widget.point.pointRule != null)
                  ? "${widget.point.pointRule} điểm"
                  : "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
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
            width: size.width * 0.2 - 1,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Visibility(
              visible: widget.point.pointRule != null &&
                  widget.point.type != TypeRow.TOTAL,
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                cursorColor: AppColor.colorMain,
                controller: controller,
                keyboardType: (Platform.isAndroid)
                    ? TextInputType.number
                    : const TextInputType.numberWithOptions(
                        signed: true,
                        decimal: true,
                      ),
                textAlign: TextAlign.center,
                onChanged: (string) {
                  try {
                    int pointVal = int.parse(controller.text);
                    if (!(controller.text == '-' ||
                        pointVal <= widget.point.pointRule!)) {
                      controller.text = controller.text
                          .substring(0, controller.text.length - 1);
                      return;
                    }
                    widget.point.pointSelf = pointVal;
                  } catch (e) {
                    widget.point.pointSelf = null;
                  }
                  widget.onChangePoint(widget.point.pointSelf);
                },
                style: const TextStyle(fontSize: 13),
                decoration: const InputDecoration(
                  hintText: "0 điểm",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColor.colorMain),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
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
    );
  }
}
