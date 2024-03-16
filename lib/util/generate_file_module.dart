import 'dart:io';

import 'package:excel/excel.dart';
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

Future<void> initPDF(
    {required List<PointExt> data,
    required int totalSelf,
    required StudentEntity student,
    required int totalFinal}) async {
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
  double headerHeight = 60;
  double widthStt = 20;
  double widthContent = 250;
  double widthPointRule = 50;
  double widthPointExt = 162;
  double widthPage = widthStt + widthContent + widthPointExt + widthPointRule;
  double widthDetailPoint = widthPointExt / 3;
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
  final output = await getApplicationDocumentsDirectory();
  final file =
      File("${output.path}/${student.stuCode} - ${student.fullName}.pdf");
  print(file.path);
  await file.writeAsBytes(await pdf.save());
}

var excel = Excel.createExcel();

Sheet sheetObject = excel['Sheet1'];

Future<void> genExcel(List<StudentPoint> data) async {
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
    } else if (totalFullFinal >= 80) {
      rank = 'Tốt';
    } else if (totalFullFinal >= 65) {
      rank = 'Khá';
    } else if (totalFullFinal >= 50) {
      rank = 'Trung bình';
    } else if (totalFullFinal >= 35) {
      rank = 'Yếu';
    } else {
      rank = 'Kém';
    }

    getCellData("K$indexGen").value = TextCellValue(rank);
    getCellData("K$indexGen").cellStyle = cellHeaderStyleRegularCt;

    getCellData("L$indexGen").value = const TextCellValue("");
    getCellData("L$indexGen").cellStyle = cellHeaderStyleRegularCt;
  }

  final output = await getApplicationDocumentsDirectory();
  final file = File("${output.path}/Bảng tổng hợp.xlsx");
  print(file.path);
  await file.writeAsBytes(excel.save()!);
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
