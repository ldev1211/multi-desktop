import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_desktop/app/features/login/data/enitity/student_entity.dart';
import 'package:multi_desktop/app/features/pointing/data/entity/form_ext_point.dart';
import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';
import 'package:multi_desktop/app/features/pointing/presentation/cubit/pointing/cubit.dart';
import 'package:multi_desktop/app/features/pointing/presentation/cubit/pointing/state.dart';
import 'package:multi_desktop/app/widget/app_bar.dart';
import 'package:multi_desktop/app/widget/app_progress.dart';
import 'package:multi_desktop/app/widget/header_user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PointingPage extends StatefulWidget {
  PointingPage({super.key, required this.stuCode});

  StudentEntity stuCode;

  @override
  State<PointingPage> createState() => _PointingPageState();
}

class _PointingPageState extends State<PointingPage> {
  late StudentEntity student;

  final PointingCubit _cubit = PointingCubit();

  String? path;

  Future<void> initPDF(List<PointExt> data) async {
    final font = await rootBundle.load("fonts/Lora-Regular.ttf");
    final fontBold = await rootBundle.load("fonts/Lora-Bold.ttf");
    final ttfRegular = pw.Font.ttf(font);
    final ttfBold = pw.Font.ttf(fontBold);
    final pdf = pw.Document();
    final defaultHeaderTextStyleBold =
        pw.TextStyle(fontSize: 10, font: ttfBold, color: PdfColors.black);
    final defaultHeaderTextStyleRegular =
        pw.TextStyle(fontSize: 11, font: ttfRegular, color: PdfColors.black);
    final defaultRowTextStyleRegular =
        pw.TextStyle(fontSize: 10, font: ttfRegular, color: PdfColors.black);
    String nhhk = "20222";
    String semester = "I" * int.parse(nhhk.substring(4));
    String year =
        "${int.parse(nhhk.substring(0, 4))}-${int.parse(nhhk.substring(0, 4)) + 1}";
    double headerHeight = 70;
    double rowHeight = 30;
    double widthStt = 25;
    double widthContent = 250;
    double widthPointRule = 50;
    double widthPointExt = 200;
    double widthDetailPoint = widthPointExt / 3;
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        build: (context) {
          return [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text("HỌC VIỆN CN BƯU CHÍNH VIỄN THÔNG",
                          style: defaultHeaderTextStyleBold),
                      pw.Text("HỌC VIỆN CN BCVN CƠ SỞ TẠI TP. HCM",
                          style: defaultHeaderTextStyleBold),
                      pw.Container(
                          color: PdfColors.black, height: 1, width: 150)
                    ]),
                pw.Spacer(),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text("CỘNG HOÀ XÃ HỘI CHỦ NGHĨA VIỆT NAM",
                          style: defaultHeaderTextStyleBold),
                      pw.Text("Độc lập - Tự do - Hạnh phúc",
                          style: defaultHeaderTextStyleBold),
                      pw.Container(
                          color: PdfColors.black, height: 1, width: 150)
                    ])
              ],
            ),
            pw.SizedBox(height: 24),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text("PHIẾU ĐÁNH GIÁ KẾT QUẢ RÈN LUYỆN",
                      style: defaultHeaderTextStyleBold.copyWith(fontSize: 13))
                ]),
            pw.SizedBox(height: 12),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text("Học kỳ: $semester",
                      style: defaultHeaderTextStyleBold),
                  pw.SizedBox(width: 24),
                  pw.Text("Năm học: $year", style: defaultHeaderTextStyleBold)
                ]),
            pw.SizedBox(height: 8),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.SizedBox(width: 24),
                  pw.Container(
                      width: 220,
                      height: 20,
                      child: pw.Text("Họ và tên: Lương Quốc Diễn",
                          style: defaultHeaderTextStyleRegular)),
                  pw.SizedBox(width: 24),
                  pw.Container(
                      width: 220,
                      height: 20,
                      child: pw.Text("Ngày sinh: 17/10/2002",
                          style: defaultHeaderTextStyleRegular)),
                  pw.SizedBox(width: 24),
                ]),
            pw.SizedBox(height: 4),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.SizedBox(width: 24),
                  pw.Container(
                      width: 220,
                      height: 20,
                      child: pw.Text("Mã số sinh viên: N20DCPT009",
                          style: defaultHeaderTextStyleRegular)),
                  pw.SizedBox(width: 24),
                  pw.Container(
                      width: 220,
                      height: 20,
                      child: pw.Text("Lớp: D20CQPTUD01-N",
                          style: defaultHeaderTextStyleRegular)),
                  pw.SizedBox(width: 24),
                ]),
            pw.SizedBox(height: 24),
            pw.SizedBox(
              height: headerHeight,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisSize: pw.MainAxisSize.max,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Container(
                          width: widthStt,
                          height: headerHeight,
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child:
                              pw.Text("TT", style: defaultHeaderTextStyleBold)),
                      pw.Container(
                          width: widthContent,
                          height: headerHeight,
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Text("Nội dung đánh giá",
                              style: defaultHeaderTextStyleBold)),
                      pw.Container(
                        width: widthPointRule,
                        height: headerHeight,
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColors.black)),
                        child: pw.Text("Điểm quy định",
                            textAlign: pw.TextAlign.center,
                            style: defaultHeaderTextStyleBold),
                      ),
                      pw.Container(
                        width: widthPointExt,
                        height: headerHeight,
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.black),
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: widthPointExt,
                              height: headerHeight * 0.25,
                              alignment: pw.Alignment.center,
                              decoration: pw.BoxDecoration(
                                  border:
                                      pw.Border.all(color: PdfColors.black)),
                              child: pw.Text(
                                "Điểm đánh giá",
                                textAlign: pw.TextAlign.center,
                                style: defaultHeaderTextStyleBold,
                              ),
                            ),
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Container(
                                  width: widthDetailPoint,
                                  height: headerHeight * 3 / 4,
                                  alignment: pw.Alignment.center,
                                  decoration: pw.BoxDecoration(
                                    color: PdfColors.white,
                                    border:
                                        pw.Border.all(color: PdfColors.black),
                                  ),
                                  child: pw.Text(
                                    "Sinh viên đánh giá",
                                    textAlign: pw.TextAlign.center,
                                    style: defaultHeaderTextStyleBold,
                                  ),
                                ),
                                pw.Container(
                                  width: widthDetailPoint,
                                  height: headerHeight * 3 / 4,
                                  alignment: pw.Alignment.center,
                                  decoration: pw.BoxDecoration(
                                    color: PdfColors.white,
                                    border:
                                        pw.Border.all(color: PdfColors.black),
                                  ),
                                  child: pw.Text(
                                    "Tập thể lớp đánh giá",
                                    textAlign: pw.TextAlign.center,
                                    style: defaultHeaderTextStyleBold,
                                  ),
                                ),
                                pw.Container(
                                  width: widthDetailPoint,
                                  height: headerHeight * 3 / 4,
                                  alignment: pw.Alignment.center,
                                  decoration: pw.BoxDecoration(
                                    color: PdfColors.white,
                                    border:
                                        pw.Border.all(color: PdfColors.black),
                                  ),
                                  child: pw.Text(
                                    "CVHT đánh giá",
                                    textAlign: pw.TextAlign.center,
                                    style: defaultHeaderTextStyleBold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            for (int i = 0; i < data.length; ++i)
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Container(
                    width: widthStt,
                    alignment: pw.Alignment.center,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      "${data[i].stt ?? ''}",
                      textAlign: pw.TextAlign.center,
                      style: defaultRowTextStyleRegular,
                    ),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    width: widthContent,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      data[i].content,
                      style: defaultRowTextStyleRegular,
                    ),
                  ),
                  pw.Container(
                    width: widthPointRule,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      "${data[i].pointRule ?? ''}",
                      style: defaultRowTextStyleRegular,
                    ),
                  ),
                  pw.Container(
                    width: widthDetailPoint,
                    alignment: pw.Alignment.center,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      "${data[i].pointSelf ?? '0'}",
                      style: defaultRowTextStyleRegular,
                    ),
                  ),
                  pw.Container(
                    width: widthDetailPoint,
                    alignment: pw.Alignment.center,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      "${data[i].pointFinal ?? '0'}",
                      style: defaultRowTextStyleRegular,
                    ),
                  ),
                  pw.Container(
                    width: widthDetailPoint,
                    alignment: pw.Alignment.center,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      "",
                      style: defaultRowTextStyleRegular,
                    ),
                  ),
                ],
              ),
          ];
        },
      ),
    );
    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/example.pdf");
    print(file.path);
    await file.writeAsBytes(await pdf.save());
    // dio.MultipartFile? multipartFile;
    // final fileBytes = await file.readAsBytes();
    // multipartFile = MultipartFile.fromBytes(
    //   fileBytes,
    //   filename: file.path.split('/').last,
    // );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    student = widget.stuCode;
    _cubit.fetchPoint(stuCode: student.stuCode);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppAppBar(title: "Chấm điểm"),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: HeaderUser.pointExt(student),
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<PointingCubit, PointingState>(
                    buildWhen: (prev, curr) {
                      return curr is FetchedPointState ||
                          curr is FetchingPointState;
                    },
                    builder: (context, state) {
                      if (state is FetchedPointState) {
                        initPDF(state.points);
                        return FormExtPoint(
                          points: state.points,
                          student: student,
                        );
                      }
                      return const Center(
                        child: Center(
                          child: AppProgress(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
