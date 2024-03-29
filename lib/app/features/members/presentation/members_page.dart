import 'package:flutter/material.dart';
import 'package:multi_desktop/app/features/login/data/enitity/student_entity.dart';
import 'package:multi_desktop/app/features/login/presentation/login_page.dart';
import 'package:multi_desktop/app/features/pointing/data/entity/data_gen_file.dart';
import 'package:multi_desktop/app/features/pointing/presentation/pointing_page.dart';
import 'package:multi_desktop/app/widget/app_button.dart';
import 'package:multi_desktop/app/widget/app_progress.dart';
import 'package:multi_desktop/main.dart';
import 'package:multi_desktop/util/app_colors.dart';
import 'package:multi_desktop/util/generate_file_module.dart';
import 'package:multi_desktop/util/pref/pref_utils.dart';
import 'package:multi_desktop/util/ui_util.dart';

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

  Future<void> startGenFile() async {
    List<StudentPoint> studentPoints = [];
    for (var e in members) {
      final points = await fetchPoint(stuCode: e.stuCode);
      studentPoints.add(StudentPoint(student: e, points: points));
    }
    await genFile(studentPoints, controllers);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMembers();
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
          mainAxisAlignment:
              (isLoading) ? MainAxisAlignment.center : MainAxisAlignment.start,
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
            if (isLoading)
              const Center(
                child: AppProgress(),
              ),
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
                        AppButton.buttonPrimary(
                          height: 45,
                          width: 200,
                          text: "Xuất file điểm rèn luyện",
                          onTap: () async {
                            bool? isSubmit = await UIUtil.showDialogInputFile(
                              context,
                              controllers: controllers,
                            );
                            if (isSubmit == true) {
                              UIUtil.showDialogLoading(context);
                              await startGenFile();
                              Navigator.pop(context);
                            }
                          },
                        ),
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
                        const SizedBox(
                          width: 12,
                        ),
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
                        itemCount: members!.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, i) {
                          StudentEntity member = members![i];
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
                                SizedBox(
                                  width: size.width * 0.04,
                                  height: size.width * 0.04,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(member.avt!),
                                  ),
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
                                const SizedBox(
                                  width: 12,
                                ),
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
