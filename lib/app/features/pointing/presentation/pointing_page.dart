import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart' hide Border, BorderStyle;
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

  Future<void> initPDF(
      List<PointExt> data, int totalSelf, int totalFinal) async {
    genExcel();
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
    String nhhk = "20222";
    String semester = "I" * int.parse(nhhk.substring(4));
    String year =
        "${int.parse(nhhk.substring(0, 4))}-${int.parse(nhhk.substring(0, 4)) + 1}";
    double headerHeight = 60;
    double rowHeight = 30;
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
              ],
            ),
            pw.SizedBox(height: 4),
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
                                  padding: const pw.EdgeInsets.all(4),
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
                          style:
                              i == data.length || data[i].type == TypeRow.TOTAL
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
    // dio.MultipartFile? multipartFile;
    // final fileBytes = await file.readAsBytes();
    // multipartFile = MultipartFile.fromBytes(
    //   fileBytes,
    //   filename: file.path.split('/').last,
    // );
  }

  Future<void> genExcel() async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];
    CellStyle cellHeaderStyleBold = CellStyle(
      backgroundColorHex: '#FFFFFFFF',
      bold: true,
      leftBorder: Border(borderStyle: BorderStyle.Thin),
      rightBorder: Border(borderStyle: BorderStyle.Thin),
      topBorder: Border(borderStyle: BorderStyle.Thin),
      bottomBorder: Border(borderStyle: BorderStyle.Thin),
      fontSize: 14,
      fontFamily: getFontFamily(FontFamily.Arial),
    );
    CellStyle cellHeaderStyleRegular = CellStyle(
      backgroundColorHex: '#FFFFFFFF',
      fontSize: 14,
      leftBorder: Border(borderStyle: BorderStyle.Thin),
      rightBorder: Border(borderStyle: BorderStyle.Thin),
      topBorder: Border(borderStyle: BorderStyle.Thin),
      bottomBorder: Border(borderStyle: BorderStyle.Thin),
      fontFamily: getFontFamily(FontFamily.Arial),
    );

    sheetObject.merge(CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: 1),
        CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0),
        customValue: const TextCellValue('Mẫu 2: Tổng hợp KQRL'));
    sheetObject
        .cell(CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: 1))
        .cellStyle = cellHeaderStyleBold;
    sheetObject.merge(CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: 1),
        CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0),
        customValue: const TextCellValue('Mẫu 2: Tổng hợp KQRL'));

    sheetObject.merge(
        CellIndex.indexByString("A2"), CellIndex.indexByString("F2"),
        customValue:
            const TextCellValue('HỌC VIỆN CÔNG NGHỆ BƯU CHÍNH VIỄN THÔNG'));
    sheetObject.setMergedCellStyle(
        CellIndex.indexByString('A2'),
        cellHeaderStyleRegular.copyWith(
            horizontalAlignVal: HorizontalAlign.Center,
            verticalAlignVal: VerticalAlign.Center));

    sheetObject.merge(
        CellIndex.indexByString("A3"), CellIndex.indexByString("F3"),
        customValue:
            const TextCellValue('HỌC VIỆN CÔNG NGHỆ BƯU CHÍNH VIỄN THÔNG'));
    sheetObject.setMergedCellStyle(
        CellIndex.indexByString('A3'),
        cellHeaderStyleBold.copyWith(
            horizontalAlignVal: HorizontalAlign.Center,
            verticalAlignVal: VerticalAlign.Center));
    final output = await getApplicationDocumentsDirectory();
    final file =
        File("${output.path}/${student.stuCode} - ${student.fullName}.xlsx");
    print(file.path);
    await file.writeAsBytes(excel.save()!);
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
                        initPDF(
                            state.points, state.totalSelf, state.totalFinal);
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
