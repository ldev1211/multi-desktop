import 'package:flutter/material.dart';
import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';
import 'package:multi_desktop/util/app_colors.dart';

class ViewRowPoint extends StatefulWidget {
  PointExt point;

  Function(String?) onChangePoint;
  VoidCallback? onDelete;

  ViewRowPoint({super.key, required this.point, required this.onChangePoint, this.onDelete});
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
              width: size.width * 0.25 - 2,
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
            ),
            Container(
              width: size.width * 0.05 - 1,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Visibility(
                visible: widget.point.pointRule != null && widget.point.pointRule != 0,
                child: IconButton(
                  onPressed: () {
                    _showDeleteConfirmation(context);
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 20,
                  ),
                  tooltip: "Xoá điểm",
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
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

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Xác nhận xoá",
          style: TextStyle(
            color: Color(0xFFFF8F00),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: const Text(
          "Bạn có chắc chắn muốn xoá điểm này không?",
          style: TextStyle(
            color: Color(0xFFFF8F00),
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              "Huỷ",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              widget.onDelete?.call();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8F00),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Xoá",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
