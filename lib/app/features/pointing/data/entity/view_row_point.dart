import 'package:flutter/material.dart';
import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';
import 'package:multi_desktop/util/app_colors.dart';

class ViewRowPoint extends StatefulWidget {
  PointExt point;

  Function(String?) onChangePoint;

  ViewRowPoint({super.key, required this.point, required this.onChangePoint});
  @override
  State<ViewRowPoint> createState() => _ViewRowPointState();
}

class _ViewRowPointState extends State<ViewRowPoint> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.text = (widget.point.pointFinal != null) ? widget.point.pointFinal.toString() : "";
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
              child: Text(
                "${widget.point.stt ?? ""} ${widget.point.content}",
                style: TextStyle(
                  color: widget.point.type == TypeRow.TOTAL ? AppColor.colorMain : Colors.black,
                  fontWeight: (widget.point.stt != null ||
                          widget.point.type == TypeRow.TOTAL ||
                          widget.point.type == TypeRow.HEADER)
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
              width: size.width * 0.1 - 1,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                (widget.point.pointRule != null) ? "${widget.point.pointRule} điểm" : "",
                textAlign: TextAlign.center,
                style: const TextStyle(
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
              child: Visibility(
                visible: [TypeRow.ROW, TypeRow.TOTAL].contains(widget.point.type) &&
                    widget.point.pointRule != null,
                child: Text(
                  (widget.point.pointSelf != null) ? "${widget.point.pointSelf} điểm" : "0 điểm",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
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
              child: Visibility(
                visible: [TypeRow.ROW, TypeRow.TOTAL].contains(widget.point.type) &&
                    widget.point.pointRule != null,
                child: (TypeRow.TOTAL == widget.point.type)
                    ? Text(
                        (widget.point.pointFinal != null)
                            ? "${widget.point.pointFinal} điểm"
                            : "0 điểm",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : TextField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: AppColor.colorMain,
                        controller: controller,
                        textAlign: TextAlign.center,
                        onChanged: (string) {
                          if(string == '-') return;
                          widget.onChangePoint(string.isEmpty ? '0' : string);
                          try {
                            widget.point.pointFinal = int.parse(string);
                          } catch (e) {
                            widget.point.pointFinal = null;
                          }
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
      ),
    );
  }
}
