import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_desktop/app/features/login/data/enitity/student_entity.dart';
import 'package:multi_desktop/app/features/login/presentation/login_page.dart';
import 'package:multi_desktop/app/features/pointing/data/entity/data_gen_file.dart';
import 'package:multi_desktop/app/features/pointing/presentation/pointing_page.dart';
import 'package:multi_desktop/app/widget/app_avt.dart';
import 'package:multi_desktop/app/widget/app_button.dart';
import 'package:multi_desktop/app/widget/app_progress.dart';
import 'package:multi_desktop/main.dart';
import 'package:multi_desktop/network/model/base_response.dart';
import 'package:multi_desktop/util/app_colors.dart';
import 'package:multi_desktop/util/generate_file_module.dart';
import 'package:multi_desktop/util/pref/pref_utils.dart';
import 'package:multi_desktop/util/ui_util.dart';
import 'package:open_dir/open_dir.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  bool isLoading = true;

  List<StudentEntity> members = [];

  Future<void> getMembers() async {
    final response = await service.getMembers();
    if (!response.error) {
      setState(() {
        List<dynamic> rawMembers = response.data;
        members = [];
        for (var e in rawMembers) {
          members.add(StudentEntity.fromJson(e));
        }
        isLoading = false;
      });
    }
  }

  Future<void> getStatus() async {
    final response = await service.getStatusPoint();
    setState(() {
      isAllowPoint = int.parse(response.data.toString()) == 1;
    });
  }

  Future<void> startGenFile(
      {required Function(String) onGenerating,
      required Function onDone}) async {
    List<StudentPoint> studentPoints = [];

    for (var e in members) {
      onGenerating("Đang truy vấn điểm từ hệ thống...\n${e.fullName}");
      final points = await fetchPoint(stuCode: e.stuCode);
      studentPoints.add(StudentPoint(student: e, points: points));
    }
    final response = await service.getConfig();
    String nhhk = response.data['nhhk'];
    String semester = "I" * int.parse(nhhk.substring(4));
    String year =
        "${int.parse(nhhk.substring(0, 4))}-${int.parse(nhhk.substring(0, 4)) + 1}";
    final output = await getApplicationDocumentsDirectory();
    Directory("${output.path}/Multimedia-DRL").createSync();
    await genFile(
      studentPoints,
      controllers,
      nhhk: nhhk,
      semester: semester,
      year: year,
      onGenerating: (path) {
        onGenerating("Đang xuất file $path");
      },
      onDone: onDone,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMembers();
    getStatus();
  }

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  bool? isAllowPoint;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontSize = 18;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
                    await PrefUtil.instance.clear();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 48,
                    color: AppColor.colorMain,
                  ),
                )
              ],
            ),
            if (isLoading) const Center(child: AppProgress()),
            if (!isLoading)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Danh sách lớp",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                          ),
                        ),
                        const Spacer(),
                        AppButton.buttonSecondary(
                          height: 45,
                          width: 200,
                          text: "Mở thư mục điểm rèn luyện",
                          onTap: () async {
                            final output =
                                await getApplicationDocumentsDirectory();
                            if (Platform.isWindows) {
                              launch('${output.path}/Multimedia-DRL');
                            } else {
                              final openDirPlugin = OpenDir();
                              await openDirPlugin.openNativeDir(
                                  path: output.path);
                            }
                          },
                        ),
                        const SizedBox(width: 24),
                        AppButton.buttonPrimary(
                          height: 45,
                          width: 200,
                          text: "Xuất file điểm rèn luyện",
                          onTap: () async {
                            UIUtil.showDialogInputFile(
                              context,
                              controllers: controllers,
                              onClickOk: () async {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    bool isLoad = true;
                                    bool isDone = false;
                                    String? messageCurr;
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        if (isLoad) {
                                          isLoad = false;
                                          startGenFile(
                                            onGenerating: (message) {
                                              setState(() {
                                                messageCurr = message;
                                              });
                                            },
                                            onDone: () {
                                              setState(() {
                                                isDone = true;
                                                messageCurr = "Đã hoàn thành.";
                                                Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () => Navigator.pop(context),
                                                );
                                              });
                                            },
                                          );
                                        }
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          content: Container(
                                            width: size.width * 0.3,
                                            height: size.height * 0.3,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(200)),
                                            ),
                                            alignment: Alignment.center,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: isDone
                                                      ? const Icon(
                                                          Icons.check,
                                                          color: AppColor
                                                              .colorMain,
                                                          size: 48,
                                                        )
                                                      : const CircularProgressIndicator(
                                                          color: AppColor
                                                              .colorMain,
                                                          strokeWidth: 5,
                                                        ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  messageCurr ??
                                                      "Đang chuẩn bị...",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(width: 24),
                        if ([3, 4].contains(PrefUtil.instance.getInt("role")))
                          AppButton.buttonPrimary(
                            height: 45,
                            width: 300,
                            text: "Tạo mới đợt chấm điểm",
                            onTap: () async {
                              UIUtil.showDialogMessage(
                                context: context,
                                onOk: () async {
                                  UIUtil.showDialogLoading(context);
                                  BaseResponse response =
                                      await service.initPointing();
                                  Navigator.pop(context);
                                },
                                message:
                                    "Bạn có chắc muốn tạo mới đợt chấm?\nĐều này sẽ khiến toàn bộ dữ liệu của đợt chấm trước bị mất đi.",
                              );
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Mở chấm điểm:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 12),
                        isAllowPoint != null
                            ? Switch(
                                value: isAllowPoint!,
                                activeColor: AppColor.colorMain,
                                inactiveTrackColor: Colors.grey.shade300,
                                onChanged: (value) {
                                  setState(() {
                                    isAllowPoint = value;
                                    service.toggleStatus({
                                      'status': isAllowPoint! ? 1 : 0,
                                    });
                                  });
                                },
                              )
                            : const AppProgress(),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          width: size.width * 0.04,
                          height: size.width * 0.04,
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: size.width * 0.07,
                          alignment: Alignment.center,
                          child: Text(
                            "Số thứ tự",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          width: size.width * 0.4,
                          child: Text(
                            "Họ tên",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                          child: Text(
                            "Mã sinh viên",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: members.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, i) {
                          StudentEntity member = members[i];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppCircleAvt(
                                  url: member.avt!,
                                  width: size.width * 0.04,
                                  height: size.width * 0.04,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  width: size.width * 0.07,
                                  alignment: Alignment.center,
                                  child: Text(
                                    (i + 1 < 10) ? "0${i + 1}" : "${i + 1}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: fontSize,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                SizedBox(
                                  width: size.width * 0.4,
                                  child: Text(
                                    member.fullName!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: fontSize,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                SizedBox(
                                  width: size.width * 0.1,
                                  child: Text(
                                    member.stuCode,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: fontSize,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PointingPage(
                                          stuCode: member,
                                        ),
                                      ),
                                    ).then((value) {
                                      getMembers();
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 24,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.colorMain,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 2),
                                          blurRadius: 12,
                                        )
                                      ],
                                    ),
                                    child: const Text(
                                      "Chấm điểm",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
