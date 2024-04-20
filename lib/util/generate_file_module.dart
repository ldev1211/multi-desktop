import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart' hide Border, BorderStyle;
import 'package:flutter/services.dart';
import 'package:multi_desktop/app/features/login/data/enitity/student_entity.dart';
import 'package:multi_desktop/app/features/pointing/data/entity/data_gen_file.dart';
import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';
import 'package:multi_desktop/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

String nhhk = "20222";
String semester = "I" * int.parse(nhhk.substring(4));
String year =
    "${int.parse(nhhk.substring(0, 4))}-${int.parse(nhhk.substring(0, 4)) + 1}";
double headerHeight = 60;
double widthStt = 20;
double widthContent = 250;
double widthPointRule = 50;
double widthPointExt = 162;
double widthPage = widthStt + widthContent + widthPointExt + widthPointRule;
double widthDetailPoint = widthPointExt / 3;
Future<void> initPDF({
  required List<PointExt> data,
  required int totalSelf,
  required StudentEntity student,
  required int totalFinal,
  required Function(String) onGenerating,
}) async {
  final output = await getApplicationDocumentsDirectory();
  String finalPath =
      "${output.path}/Multimedia-DRL/${student.stuCode} - ${student.fullName}.pdf";
  onGenerating(finalPath);
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
      pw.TextStyle(fontSize: 7, font: ttfRegular, color: PdfColors.black);
  final defaultRowTextStyleBold =
      pw.TextStyle(fontSize: 7, font: ttfBold, color: PdfColors.black);

  DateTime now = DateTime.now();
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
                    pw.Container(color: PdfColors.black, height: 1, width: 150)
                  ]),
              pw.Spacer(),
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text("CỘNG HOÀ XÃ HỘI CHỦ NGHĨA VIỆT NAM",
                        style: defaultHeaderTextStyleBold),
                    pw.Text("Độc lập - Tự do - Hạnh phúc",
                        style: defaultHeaderTextStyleBold),
                    pw.Container(color: PdfColors.black, height: 1, width: 150)
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
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text("Học kỳ: $semester", style: defaultHeaderTextStyleBold),
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
                  width: widthPage * 0.4,
                  child: pw.Text("Họ và tên: ${student.fullName}",
                      style: defaultHeaderTextStyleRegular)),
              pw.Spacer(),
              pw.Container(
                  width: widthPage * 0.4,
                  child: pw.Text("Ngày sinh: ${student.birthDay}",
                      style: defaultHeaderTextStyleRegular)),
              pw.SizedBox(width: 24),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.SizedBox(width: 24),
              pw.Container(
                  width: widthPage * 0.4,
                  height: 20,
                  child: pw.Text("Mã số sinh viên: ${student.stuCode}",
                      style: defaultHeaderTextStyleRegular)),
              pw.Spacer(),
              pw.Container(
                  width: widthPage * 0.4,
                  height: 20,
                  child: pw.Text("Lớp: ${student.classCode}",
                      style: defaultHeaderTextStyleRegular)),
              pw.SizedBox(width: 24),
            ],
          ),
          pw.SizedBox(height: 12),
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
                      child: pw.Text(
                        "TT",
                        style: defaultHeaderTextStyleBold,
                      ),
                    ),
                    pw.Container(
                      width: widthContent,
                      height: headerHeight,
                      alignment: pw.Alignment.center,
                      decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.black)),
                      child: pw.Text(
                        "Nội dung đánh giá",
                        style: defaultHeaderTextStyleBold,
                      ),
                    ),
                    pw.Container(
                      width: widthPointRule,
                      height: headerHeight,
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.all(8),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black),
                      ),
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
                                border: pw.Border.all(color: PdfColors.black)),
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
                                  border: pw.Border.all(color: PdfColors.black),
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
                                padding: const pw.EdgeInsets.all(4),
                                decoration: pw.BoxDecoration(
                                  color: PdfColors.white,
                                  border: pw.Border.all(color: PdfColors.black),
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
                                  border: pw.Border.all(color: PdfColors.black),
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
          pw.Table(
            tableWidth: pw.TableWidth.max,
            columnWidths: {
              0: pw.FixedColumnWidth(widthStt),
              1: pw.FixedColumnWidth(widthContent),
              2: pw.FixedColumnWidth(widthPointRule),
              3: pw.FixedColumnWidth(widthDetailPoint),
              4: pw.FixedColumnWidth(widthDetailPoint),
              5: pw.FixedColumnWidth(widthDetailPoint),
            },
            border: pw.TableBorder.all(),
            children: [
              for (int i = 0; i <= data.length; ++i)
                pw.TableRow(
                  verticalAlignment: pw.TableCellVerticalAlignment.middle,
                  children: [
                    pw.Container(
                      width: widthStt,
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        (i < data.length) ? "${data[i].stt ?? ''}" : "",
                        textAlign: pw.TextAlign.center,
                        style: defaultRowTextStyleRegular,
                      ),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(8),
                      width: widthContent,
                      child: pw.Text(
                        (i < data.length) ? data[i].content : "TỔNG CỘNG",
                        style: (i == data.length ||
                                data[i].type == TypeRow.HEADER ||
                                data[i].type == TypeRow.TOTAL)
                            ? defaultRowTextStyleBold
                            : defaultRowTextStyleRegular,
                      ),
                    ),
                    pw.Container(
                      width: widthPointRule,
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        (i < data.length)
                            ? (data[i].pointRule != null)
                                ? "${data[i].pointRule} điểm"
                                : ''
                            : '100',
                        style: i == data.length || data[i].type == TypeRow.TOTAL
                            ? defaultRowTextStyleBold
                            : defaultRowTextStyleRegular,
                      ),
                    ),
                    pw.Container(
                      width: widthDetailPoint,
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        (i < data.length)
                            ? (data[i].type == TypeRow.HEADER ||
                                    data[i].pointRule == null)
                                ? ""
                                : "${data[i].pointSelf ?? '0'}"
                            : totalSelf.toString(),
                        style: defaultRowTextStyleRegular,
                      ),
                    ),
                    pw.Container(
                      width: widthDetailPoint,
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        (i < data.length)
                            ? (data[i].type == TypeRow.HEADER ||
                                    data[i].pointRule == null)
                                ? ""
                                : "${data[i].pointFinal ?? '0'}"
                            : totalFinal.toString(),
                        style: defaultRowTextStyleRegular,
                      ),
                    ),
                    pw.Container(
                      width: widthDetailPoint,
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        "",
                        style: defaultRowTextStyleRegular,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                "TP.HCM, Ngày ${(now.day < 10) ? "0${now.day}" : now.day} tháng ${(now.month < 10) ? "0${now.month}" : now.month} năm ${now.year}",
                style: defaultRowTextStyleRegular.copyWith(fontSize: 10),
              )
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              pw.Container(
                width: widthPage * 0.2,
                child: pw.Column(
                  children: [
                    pw.Text(
                      "XÁC NHẬN CỦA CỐ VẤN HỌC TẬP",
                      textAlign: pw.TextAlign.center,
                      style: defaultHeaderTextStyleBold,
                    ),
                    pw.SizedBox(height: 70),
                    pw.Text("............................")
                  ],
                ),
              ),
              pw.Container(
                width: widthPage * 0.2,
                child: pw.Column(
                  children: [
                    pw.Text(
                      "TM. BAN CÁN SỰ\nLỚP TRƯỞNG",
                      textAlign: pw.TextAlign.center,
                      style: defaultHeaderTextStyleBold,
                    ),
                    pw.SizedBox(height: 70),
                    pw.Text("............................")
                  ],
                ),
              ),
              pw.Container(
                width: widthPage * 0.2,
                child: pw.Column(
                  children: [
                    pw.Text(
                      "TM. BCH CHI ĐOÀN\nBÍ THƯ",
                      textAlign: pw.TextAlign.center,
                      style: defaultHeaderTextStyleBold,
                    ),
                    pw.SizedBox(height: 70),
                    pw.Text("............................")
                  ],
                ),
              ),
              pw.Container(
                width: widthPage * 0.2,
                child: pw.Column(
                  children: [
                    pw.Text(
                      "SINH VIÊN",
                      textAlign: pw.TextAlign.center,
                      style: defaultHeaderTextStyleBold,
                    ),
                    pw.SizedBox(height: 85),
                    pw.Text("............................")
                  ],
                ),
              ),
            ],
          ),
        ];
      },
    ),
  );

  final file = File(finalPath);
  await file.writeAsBytes(await pdf.save());
}

var excel = Excel.createExcel();

Sheet sheetObject = excel['Sheet1'];

Future<void> genMeetingForm({
  required String nhhk,
  required String classCode,
  required String time,
  required String secretary,
  required String secretaryPosition,
  required String endTime,
  required String meetingLeader,
  required String meetingLeaderPosition,
  required List<StudentPoint> studentPoint,
  required List<int> totals,
  required location,
}) async {
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
  final defaultRowTextStyleBold =
      pw.TextStyle(fontSize: 10, font: ttfBold, color: PdfColors.black);
  DateTime now = DateTime.now();
  double columnWidth = widthPage / 4.0;
  double rowHeight = 25;
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
                  pw.Text(
                    "HỌC VIỆN CÔNG NGHỆ BCVN\nCƠ SỞ TẠI TP.HỒ CHÍ MINH",
                    textAlign: pw.TextAlign.center,
                    style: defaultHeaderTextStyleRegular,
                  ),
                  pw.Text(
                    "LỚP SINH VIÊN: ${studentPoint.first.student.classCode!}",
                    textAlign: pw.TextAlign.center,
                    style: defaultHeaderTextStyleBold,
                  ),
                  pw.Container(color: PdfColors.black, height: 1, width: 150)
                ],
              ),
              pw.Spacer(),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    "CỘNG HOÀ XÃ HỘI CHỦ NGHĨA VIỆT NAM",
                    style: defaultHeaderTextStyleBold,
                  ),
                  pw.Text(
                    "Độc lập - Tự do - Hạnh phúc",
                    style: defaultHeaderTextStyleBold,
                  ),
                  pw.Container(
                    color: PdfColors.black,
                    height: 1,
                    width: 150,
                  )
                ],
              )
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                "TP.HCM, Ngày ${(now.day < 10) ? "0${now.day}" : now.day} tháng ${(now.month < 10) ? "0${now.month}" : now.month} năm ${now.year}",
                style: defaultRowTextStyleRegular.copyWith(
                  fontSize: 10,
                  fontStyle: pw.FontStyle.italic,
                ),
              )
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                "BIÊN BẢN HỌP LỚP\nVỀ VIỆC ĐÁNH GIÁ KẾT QUẢ RÈN LUYỆN SINH VIÊN",
                textAlign: pw.TextAlign.center,
                style: defaultHeaderTextStyleBold.copyWith(fontSize: 13),
              )
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                "Học kỳ: $semester",
                style: defaultHeaderTextStyleRegular,
              ),
              pw.SizedBox(width: 24),
              pw.Text(
                "Năm học: $year",
                style: defaultHeaderTextStyleRegular,
              )
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.SizedBox(width: 24),
              pw.Container(
                  width: widthPage * 0.4,
                  child: pw.Text(
                      "Lớp sinh viên: ${studentPoint.first.student.classCode!}",
                      style: defaultHeaderTextStyleRegular)),
              pw.Spacer(),
              pw.Container(
                  width: widthPage * 0.4,
                  child: pw.Text("Khoa: Công nghệ thông tin 2",
                      style: defaultHeaderTextStyleRegular)),
              pw.SizedBox(width: 24),
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Text(
            "I. Thời gian, địa điểm:",
            style: defaultRowTextStyleBold,
          ),
          pw.Text(
            "1. Thời gian: $time",
            style: defaultRowTextStyleRegular,
          ),
          pw.Text(
            "2. Địa điểm: $location",
            style: defaultRowTextStyleRegular,
          ),
          pw.Text(
            "II. Thành phần tham dự:",
            style: defaultRowTextStyleBold,
          ),
          pw.Text(
            "1. Chủ trì cuộc họp: $meetingLeader      -      $meetingLeaderPosition",
            style: defaultRowTextStyleRegular,
          ),
          pw.Text(
            "2. Thư ký cuộc họp: $secretary      -      $secretaryPosition",
            style: defaultRowTextStyleRegular,
          ),
          pw.Text(
            "3. Tổng số sinh viên của lớp: ${studentPoint.length}, có mặt: ${studentPoint.length}, vắng mặt: 0",
            style: defaultRowTextStyleRegular,
          ),
          pw.Text(
            "III. Nội dung:",
            style: defaultRowTextStyleBold,
          ),
          pw.Text(
            "1. Đánh giá kết quả điểm rèn luyện cho sinh viên học kỳ $semester năm học $year",
            style: defaultRowTextStyleRegular,
          ),
          pw.Text(
            "2. Lớp trưởng thay mặt lớp đọc điểm từng tiêu chí, nhận xét từng sinh viên về quá trình rèn luyện trong học kỳ $semester năm học $year (có bản tổng hợp kết quả rèn luyện kèm theo). Sau khi đánh giá, kết quả phân loại như sau:",
            style: defaultRowTextStyleRegular,
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("Phân loại", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child:
                    pw.Text("Số lượng SV", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("Tỷ lệ (%)", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("Ghi chú", style: defaultHeaderTextStyleBold),
              ),
            ],
          ),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("Xuất sắc", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child:
                    pw.Text("${totals[0]}", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text(
                    '${totals[0].toDouble() / studentPoint.length * 100}',
                    style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("", style: defaultHeaderTextStyleBold),
              ),
            ],
          ),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("Tốt", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child:
                    pw.Text("${totals[1]}", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text(
                    '${totals[1].toDouble() / studentPoint.length * 100}',
                    style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("", style: defaultHeaderTextStyleBold),
              ),
            ],
          ),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("Khá", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child:
                    pw.Text("${totals[2]}", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text(
                    '${totals[2].toDouble() / studentPoint.length * 100}',
                    style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("", style: defaultHeaderTextStyleBold),
              ),
            ],
          ),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("Trung bình", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child:
                    pw.Text("${totals[3]}", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text(
                    '${totals[3].toDouble() / studentPoint.length * 100}',
                    style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("", style: defaultHeaderTextStyleBold),
              ),
            ],
          ),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("Yếu", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child:
                    pw.Text("${totals[4]}", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text(
                    '${totals[4].toDouble() / studentPoint.length * 100}',
                    style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("", style: defaultHeaderTextStyleBold),
              ),
            ],
          ),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("Kém", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child:
                    pw.Text("${totals[5]}", style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text(
                    '${totals[5].toDouble() / studentPoint.length * 100}',
                    style: defaultHeaderTextStyleBold),
              ),
              pw.Container(
                width: columnWidth,
                height: rowHeight,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Text("", style: defaultHeaderTextStyleBold),
              ),
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Text(
            "IV. Kiến nghị, đề xuất (nếu có):",
            style: defaultRowTextStyleBold,
          ),
          pw.Text(
            "Thống nhất 100% với kết quả đánh giá trên",
            style: defaultRowTextStyleRegular,
          ),
          pw.Text(
            "Cuộc họp kết thúc vào lúc $endTime cùng ngày",
            style: defaultRowTextStyleRegular,
          ),
          pw.SizedBox(height: 24),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              pw.Container(
                width: widthPage / 2,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      "CỐ VẤN HỌC TẬP\nCHỦ TRÌ",
                      textAlign: pw.TextAlign.center,
                      style: defaultHeaderTextStyleBold,
                    ),
                    pw.Text(
                      "(Ký và ghi rõ họ tên)",
                      textAlign: pw.TextAlign.center,
                      style: defaultRowTextStyleRegular.copyWith(
                        fontStyle: pw.FontStyle.italic,
                      ),
                    ),
                    pw.SizedBox(height: 60),
                    pw.Text(
                      meetingLeader,
                      textAlign: pw.TextAlign.center,
                      style: defaultHeaderTextStyleBold,
                    ),
                  ],
                ),
              ),
              pw.Container(
                width: widthPage / 2,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      "THAY MẶT BAN CÁN SỰ LỚP\nTHƯ KÝ",
                      textAlign: pw.TextAlign.center,
                      style: defaultHeaderTextStyleBold,
                    ),
                    pw.Text(
                      "(Ký và ghi rõ họ tên)",
                      textAlign: pw.TextAlign.center,
                      style: defaultRowTextStyleRegular.copyWith(
                        fontStyle: pw.FontStyle.italic,
                      ),
                    ),
                    pw.SizedBox(height: 60),
                    pw.Text(
                      secretary,
                      textAlign: pw.TextAlign.center,
                      style: defaultHeaderTextStyleBold,
                    ),
                  ],
                ),
              )
            ],
          )
        ];
      },
    ),
  );
  final output = await getApplicationDocumentsDirectory();
  final file = File("${output.path}/Multimedia-DRL/Biển bản họp lớp.pdf");
  await file.writeAsBytes(await pdf.save());
}

Future<void> genFile(
    List<StudentPoint> data, List<TextEditingController> controllers,
    {required Function(String) onGenerating, required Function onDone}) async {
  CellStyle cellHeaderStyleBold = CellStyle(
    backgroundColorHex: '#FFFFFFFF',
    bold: true,
    fontSize: 12,
    bottomBorder: Border(borderStyle: BorderStyle.Thin),
    topBorder: Border(borderStyle: BorderStyle.Thin),
    rightBorder: Border(borderStyle: BorderStyle.Thin),
    leftBorder: Border(borderStyle: BorderStyle.Thin),
    fontFamily: getFontFamily(FontFamily.Arial),
  );
  CellStyle cellHeaderStyleBoldCt = CellStyle(
    backgroundColorHex: '#FFFFFFFF',
    fontSize: 12,
    textWrapping: TextWrapping.WrapText,
    bold: true,
    bottomBorder: Border(borderStyle: BorderStyle.Thin),
    topBorder: Border(borderStyle: BorderStyle.Thin),
    rightBorder: Border(borderStyle: BorderStyle.Thin),
    leftBorder: Border(borderStyle: BorderStyle.Thin),
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
    fontFamily: getFontFamily(FontFamily.Arial),
  );
  CellStyle cellHeaderStyleRegular = CellStyle(
    backgroundColorHex: '#FFFFFFFF',
    fontSize: 12,
    bottomBorder: Border(borderStyle: BorderStyle.Thin),
    topBorder: Border(borderStyle: BorderStyle.Thin),
    rightBorder: Border(borderStyle: BorderStyle.Thin),
    leftBorder: Border(borderStyle: BorderStyle.Thin),
    fontFamily: getFontFamily(FontFamily.Arial),
  );
  CellStyle cellHeaderStyleRegularCt = CellStyle(
    backgroundColorHex: '#FFFFFFFF',
    bottomBorder: Border(borderStyle: BorderStyle.Thin),
    topBorder: Border(borderStyle: BorderStyle.Thin),
    rightBorder: Border(borderStyle: BorderStyle.Thin),
    leftBorder: Border(borderStyle: BorderStyle.Thin),
    fontSize: 12,
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
    fontFamily: getFontFamily(FontFamily.Arial),
  );

  merge("B1", "C1", cellHeaderStyleBoldCt, 'Mẫu 2: Tổng hợp KQRL');
  merge(("A2"), ("F2"), cellHeaderStyleRegularCt,
      'HỌC VIỆN CÔNG NGHỆ BƯU CHÍNH VIỄN THÔNG');
  merge(("A3"), ("F3"), cellHeaderStyleBoldCt,
      'HỌC VIỆN CÔNG NGHỆ BƯU CHÍNH VIỄN THÔNG');
  merge(("G2"), ("L2"), cellHeaderStyleRegularCt,
      'CỘNG HOÀ XÃ HỘI CHỦ NGHĨA VIỆT NAM');
  merge(("G3"), ("L3"), cellHeaderStyleBoldCt, 'Độc lập - Tự do - Hạnh phúc');

  DateTime now = DateTime.now();
  merge(("F5"), ("L5"), cellHeaderStyleRegularCt,
      'Tp. Hồ Chí Minh, ngày ${now.day.toString().padLeft(2, '0')} tháng ${now.month.toString().padLeft(2, '0')} năm ${now.year}');

  merge(('A9'), ('C9'), cellHeaderStyleRegular,
      'Lớp: ${data[0].student.classCode}');

  merge(('F9'), ('I9'), cellHeaderStyleRegular, 'Khoa: Công nghệ thông tin 2');

  merge(('A10'), ('B10'), cellHeaderStyleRegular,
      'Học kỳ: ${nhhk.substring(0, 1)}');

  merge(('F10'), ('H10'), cellHeaderStyleRegular, 'Năm học: $year');

  merge("A7", "L7", cellHeaderStyleBoldCt.copyWith(fontSizeVal: 15),
      "TỔNG HỢP KẾT QUẢ RÈN LUYỆN CỦA SINH VIÊN");

  merge("A12", "A13", cellHeaderStyleBoldCt, 'TT');

  merge("B12", "C13", cellHeaderStyleBoldCt, "Họ và tên");

  merge("D12", "D13", cellHeaderStyleBoldCt, "Mã sinh viên");

  merge("E12", "J12", cellHeaderStyleBoldCt, "Điểm đánh giá");

  getCellData("E13").value = const TextCellValue("Nội dung 1");
  getCellData("E13").cellStyle = cellHeaderStyleBoldCt;
  getCellData("F13").value = const TextCellValue("Nội dung 2");
  getCellData("F13").cellStyle = cellHeaderStyleBoldCt;
  getCellData("G13").value = const TextCellValue("Nội dung 3");
  getCellData("G13").cellStyle = cellHeaderStyleBoldCt;
  getCellData("H13").value = const TextCellValue("Nội dung 4");
  getCellData("H13").cellStyle = cellHeaderStyleBoldCt;
  getCellData("I13").value = const TextCellValue("Nội dung 5");
  getCellData("I13").cellStyle = cellHeaderStyleBoldCt;
  getCellData("J13").value = const TextCellValue("Tổng điểm");
  getCellData("J13").cellStyle = cellHeaderStyleBoldCt;
  merge("K12", "K13", cellHeaderStyleBoldCt, "XẾP LOẠI RÈN LUYỆN");
  merge("L12", "L13", cellHeaderStyleBoldCt, "GHI CHÚ");

  List<int> totalRank = [0, 0, 0, 0, 0, 0];

  for (int i = 0; i < data.length; ++i) {
    StudentPoint studentPoint = data[i];
    int indexGen = 14 + i;
    int totalSelf = 0;
    int totalFinal = 0;
    int totalFullSelf = 0;
    int totalFullFinal = 0;
    List<int> pointContentTotal = [];
    for (var e in studentPoint.points) {
      if (e.type == TypeRow.TOTAL) {
        e.pointSelf = totalSelf;
        e.pointFinal = totalFinal;
        pointContentTotal.add(totalFinal);
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

    await initPDF(
      student: studentPoint.student,
      data: studentPoint.points,
      totalSelf: totalFullSelf,
      totalFinal: totalFullFinal,
      onGenerating: (path) {
        onGenerating(path);
      },
    );
    getCellData("A$indexGen").value = TextCellValue("${i + 1}");
    getCellData("A$indexGen").cellStyle = cellHeaderStyleRegularCt;

    getCellData("B$indexGen").value = TextCellValue(studentPoint
        .student.fullName!
        .split(' ')
        .sublist(0, studentPoint.student.fullName!.split(' ').length - 1)
        .join(' '));
    getCellData("B$indexGen").cellStyle = cellHeaderStyleRegularCt;

    getCellData("C$indexGen").value =
        TextCellValue(studentPoint.student.fullName!.split(' ').last);
    getCellData("C$indexGen").cellStyle = cellHeaderStyleRegularCt;

    getCellData("D$indexGen").value =
        TextCellValue(studentPoint.student.stuCode);
    getCellData("D$indexGen").cellStyle = cellHeaderStyleRegularCt;

    getCellData("E$indexGen").value =
        TextCellValue(pointContentTotal[0].toString());
    getCellData("E$indexGen").cellStyle = cellHeaderStyleRegularCt;

    getCellData("F$indexGen").value =
        TextCellValue(pointContentTotal[1].toString());
    getCellData("F$indexGen").cellStyle = cellHeaderStyleRegularCt;

    getCellData("G$indexGen").value =
        TextCellValue(pointContentTotal[2].toString());
    getCellData("G$indexGen").cellStyle = cellHeaderStyleRegularCt;

    getCellData("H$indexGen").value =
        TextCellValue(pointContentTotal[3].toString());
    getCellData("H$indexGen").cellStyle = cellHeaderStyleRegularCt;

    getCellData("I$indexGen").value =
        TextCellValue(pointContentTotal[4].toString());
    getCellData("I$indexGen").cellStyle = cellHeaderStyleRegularCt;

    getCellData("J$indexGen").value = TextCellValue(totalFullFinal.toString());
    getCellData("J$indexGen").cellStyle = cellHeaderStyleRegularCt;

    String rank = '';
    if (totalFullFinal >= 90) {
      rank = 'Xuất sắc';
      totalRank[0]++;
    } else if (totalFullFinal >= 80) {
      rank = 'Tốt';
      totalRank[1]++;
    } else if (totalFullFinal >= 65) {
      rank = 'Khá';
      totalRank[2]++;
    } else if (totalFullFinal >= 50) {
      totalRank[3]++;
      rank = 'Trung bình';
    } else if (totalFullFinal >= 35) {
      totalRank[4]++;
      rank = 'Yếu';
    } else {
      totalRank[5]++;
      rank = 'Kém';
    }

    getCellData("K$indexGen").value = TextCellValue(rank);
    getCellData("K$indexGen").cellStyle = cellHeaderStyleRegularCt;

    getCellData("L$indexGen").value = const TextCellValue("");
    getCellData("L$indexGen").cellStyle = cellHeaderStyleRegularCt;
  }

  int indexRowCont = 13 + data.length + 2;

  getCellData("B$indexRowCont").value = const TextCellValue("Danh sách có");
  getCellData("B$indexRowCont").cellStyle = cellHeaderStyleRegularCt;

  getCellData("C$indexRowCont").value = TextCellValue("${data.length}");
  getCellData("C$indexRowCont").cellStyle = cellHeaderStyleRegularCt;

  getCellData("D$indexRowCont").value = const TextCellValue("Sinh viên");
  getCellData("D$indexRowCont").cellStyle = cellHeaderStyleRegularCt;

  indexRowCont++;
  getCellData("A$indexRowCont").value = const TextCellValue(
      "Lưu ý: Kết quả điểm rèn luyện được phân thành các loại: Xuất sắc, Tốt, Khá, Trung bình, Yếu, Kém");
  getCellData("A$indexRowCont").cellStyle = cellHeaderStyleRegularCt;

  indexRowCont++;

  merge('C$indexRowCont', 'F$indexRowCont', cellHeaderStyleRegular,
      "_ Loại Xuất sắc: Từ 90- đến 100 điểm");
  getCellData('H$indexRowCont').value = TextCellValue(totalRank[0].toString());
  getCellData('H$indexRowCont').cellStyle = cellHeaderStyleRegularCt;
  getCellData('I$indexRowCont').value = const TextCellValue("Sinh viên");
  getCellData('I$indexRowCont').cellStyle = cellHeaderStyleRegular;
  getCellData('J$indexRowCont').value =
      DoubleCellValue(totalRank[0].toDouble() / data.length * 100);
  getCellData('J$indexRowCont').cellStyle = cellHeaderStyleRegular;
  getCellData('K$indexRowCont').value = const TextCellValue("%");
  getCellData('K$indexRowCont').cellStyle = cellHeaderStyleRegular;
  indexRowCont++;

  merge('C$indexRowCont', 'F$indexRowCont', cellHeaderStyleRegular,
      "_ Loại Tốt: Từ 80 đến dưới 90 điểm");
  getCellData('H$indexRowCont').value = TextCellValue(totalRank[1].toString());
  getCellData('H$indexRowCont').cellStyle = cellHeaderStyleRegularCt;
  getCellData('I$indexRowCont').value = const TextCellValue("Sinh viên");
  getCellData('I$indexRowCont').cellStyle = cellHeaderStyleRegular;
  getCellData('J$indexRowCont').value =
      DoubleCellValue(totalRank[1].toDouble() / data.length * 100);
  getCellData('J$indexRowCont').cellStyle = cellHeaderStyleRegular;
  getCellData('K$indexRowCont').value = const TextCellValue("%");
  getCellData('K$indexRowCont').cellStyle = cellHeaderStyleRegular;
  indexRowCont++;

  merge('C$indexRowCont', 'F$indexRowCont', cellHeaderStyleRegular,
      "_ Loại Khá: Từ 65 đến dưới 80 điểm");
  getCellData('H$indexRowCont').value = TextCellValue(totalRank[2].toString());
  getCellData('H$indexRowCont').cellStyle = cellHeaderStyleRegularCt;
  getCellData('I$indexRowCont').value = const TextCellValue("Sinh viên");
  getCellData('I$indexRowCont').cellStyle = cellHeaderStyleRegular;
  getCellData('J$indexRowCont').value =
      DoubleCellValue(totalRank[2].toDouble() / data.length * 100);
  getCellData('J$indexRowCont').cellStyle = cellHeaderStyleRegular;
  getCellData('K$indexRowCont').value = const TextCellValue("%");
  getCellData('K$indexRowCont').cellStyle = cellHeaderStyleRegular;
  indexRowCont++;

  merge('C$indexRowCont', 'F$indexRowCont', cellHeaderStyleRegular,
      "_ Loại Trung bình: Từ 50 đến dưới 65 điểm");
  getCellData('H$indexRowCont').value = TextCellValue(totalRank[3].toString());
  getCellData('H$indexRowCont').cellStyle = cellHeaderStyleRegularCt;
  getCellData('I$indexRowCont').value = const TextCellValue("Sinh viên");
  getCellData('I$indexRowCont').cellStyle = cellHeaderStyleRegular;
  getCellData('J$indexRowCont').value =
      DoubleCellValue(totalRank[3].toDouble() / data.length * 100);
  getCellData('J$indexRowCont').cellStyle = cellHeaderStyleRegular;
  getCellData('K$indexRowCont').value = const TextCellValue("%");
  getCellData('K$indexRowCont').cellStyle = cellHeaderStyleRegular;
  indexRowCont++;

  merge('C$indexRowCont', 'F$indexRowCont', cellHeaderStyleRegular,
      "_ Loại Yếu: Từ 35 đến dưới 50 điểm");
  getCellData('H$indexRowCont').value = TextCellValue(totalRank[4].toString());
  getCellData('H$indexRowCont').cellStyle = cellHeaderStyleRegularCt;
  getCellData('I$indexRowCont').value = const TextCellValue("Sinh viên");
  getCellData('I$indexRowCont').cellStyle = cellHeaderStyleRegular;
  getCellData('J$indexRowCont').value =
      DoubleCellValue(totalRank[4].toDouble() / data.length * 100);
  getCellData('J$indexRowCont').cellStyle = cellHeaderStyleRegular;
  getCellData('K$indexRowCont').value = const TextCellValue("%");
  getCellData('K$indexRowCont').cellStyle = cellHeaderStyleRegular;
  indexRowCont++;

  merge('C$indexRowCont', 'F$indexRowCont', cellHeaderStyleRegular,
      "_ Loại kém: Dưới 35 điểm");
  getCellData('H$indexRowCont').value = TextCellValue(totalRank[5].toString());
  getCellData('H$indexRowCont').cellStyle = cellHeaderStyleRegularCt;
  getCellData('I$indexRowCont').value = const TextCellValue("Sinh viên");
  getCellData('I$indexRowCont').cellStyle = cellHeaderStyleRegular;
  getCellData('J$indexRowCont').value =
      DoubleCellValue(totalRank[5].toDouble() / data.length * 100);
  getCellData('J$indexRowCont').cellStyle = cellHeaderStyleRegular;
  getCellData('K$indexRowCont').value = const TextCellValue("%");
  getCellData('K$indexRowCont').cellStyle = cellHeaderStyleRegular;

  indexRowCont += 2;

  merge(
    'A$indexRowCont',
    'C$indexRowCont',
    cellHeaderStyleBoldCt,
    "Khoa đào tạo",
  );
  merge(
    'E$indexRowCont',
    'H$indexRowCont',
    cellHeaderStyleBoldCt,
    "Cô vấn học tập",
  );
  merge(
    'I$indexRowCont',
    'L$indexRowCont',
    cellHeaderStyleBoldCt,
    "Lớp trưởng",
  );
  indexRowCont++;
  merge(
    'E$indexRowCont',
    'H$indexRowCont',
    cellHeaderStyleRegularCt,
    "(Ký và ghi rõ họ tên)",
  );
  merge(
    'I$indexRowCont',
    'L$indexRowCont',
    cellHeaderStyleRegularCt,
    "(Ký và ghi rõ họ tên)",
  );

  genMeetingForm(
      nhhk: nhhk,
      classCode: data.first.student.classCode!,
      time: controllers[4].text,
      endTime: controllers[5].text,
      secretary: controllers[2].text,
      secretaryPosition: controllers[3].text,
      totals: totalRank,
      meetingLeader: controllers[0].text,
      meetingLeaderPosition: controllers[1].text,
      studentPoint: data,
      location: controllers[6].text);

  final output = await getApplicationDocumentsDirectory();
  final file = File("${output.path}/Multimedia-DRL/Bảng tổng hợp.xlsx");
  await file.writeAsBytes(excel.save()!);
  onDone();
}

Data getCellData(String string) {
  return sheetObject.cell(getCell(string));
}

void merge(String start, String end, CellStyle style, String value) {
  sheetObject.merge(getCell(start), getCell(end),
      customValue: TextCellValue(value));
  sheetObject.setMergedCellStyle(getCell(start), style);
}

CellIndex getCell(String string) {
  return CellIndex.indexByString(string);
}

Future<List<PointExt>> fetchPoint({required String stuCode}) async {
  final response = await service.getPointExt(stuCode);
  List<PointExt> points = response.data;
  return points;
}
