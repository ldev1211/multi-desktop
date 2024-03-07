import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_desktop/app/features/login/data/enitity/student_entity.dart';
import 'package:multi_desktop/app/features/pointing/data/entity/form_ext_point.dart';
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

  Future<void> initPDF() async {
    final font = await rootBundle.load("fonts/Lora-Regular.ttf");
    final fontBold = await rootBundle.load("fonts/Lora-Bold.ttf");
    final ttfRegular = pw.Font.ttf(font);
    final ttfBold = pw.Font.ttf(fontBold);
    final pdf = pw.Document();
    final defaultHeaderTextStyleBold =
        pw.TextStyle(fontSize: 10, font: ttfBold, color: PdfColors.black);
    final defaultHeaderTextStyleRegular =
        pw.TextStyle(fontSize: 11, font: ttfRegular, color: PdfColors.black);
    String nhhk = "20222";
    String semester = "I" * int.parse(nhhk.substring(4));
    String year =
        "${int.parse(nhhk.substring(0, 4))}-${int.parse(nhhk.substring(0, 4)) + 1}";
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        build: (pw.Context context) {
          return pw
              .Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
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
            ]),
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
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisSize: pw.MainAxisSize.max,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Container(
                            alignment: pw.Alignment.center,
                            height: 50,
                            width: 25,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.black)),
                            child: pw.Text("TT",
                                style: defaultHeaderTextStyleBold)),
                        pw.Container(
                            width: 250,
                            height: 50,
                            alignment: pw.Alignment.center,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.black)),
                            child: pw.Text("Nội dung đánh giá",
                                style: defaultHeaderTextStyleBold)),
                        pw.Container(
                            width: 50,
                            height: 50,
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 6),
                            alignment: pw.Alignment.center,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.black)),
                            child: pw.Text("Điểm quy định",
                                textAlign: pw.TextAlign.center,
                                style: defaultHeaderTextStyleBold)),
                        pw.Container(
                            height: 50,
                            alignment: pw.Alignment.center,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.black)),
                            child: pw.Column(
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Container(
                                      width: 200,
                                      height: 50,
                                      padding: const pw.EdgeInsets.symmetric(
                                          horizontal: 6),
                                      alignment: pw.Alignment.center,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: PdfColors.black)),
                                      child: pw.Text("Điểm đánh giá",
                                          textAlign: pw.TextAlign.center,
                                          style: defaultHeaderTextStyleBold)),
                                  pw.Row()
                                ])),
                      ])
                ])
          ]);
        }));
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
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    student = widget.stuCode;
    _cubit.fetchPoint(stuCode: student.stuCode);
    initPDF();
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
              // if (pdfData != null)
              //   PDFView(
              //     pdfData: pdfData,
              //     enableSwipe: true,
              //     swipeHorizontal: true,
              //     autoSpacing: false,
              //     pageFling: false,
              //     onRender: (_pages) {
              //       // setState(() {
              //       //   pages = _pages;
              //       //   isReady = true;
              //       // });
              //     },
              //     onError: (error) {
              //       print(error.toString());
              //     },
              //     onPageError: (page, error) {
              //       print('$page: ${error.toString()}');
              //     },
              //     onViewCreated: (PDFViewController pdfViewController) {
              //       // _controller.complete(pdfViewController);
              //     },
              //     onPageChanged: (int? page, int? total) {
              //       print('page change: $page/$total');
              //     },
              //   )
            ],
          ),
        ),
      ),
    );
  }
}
