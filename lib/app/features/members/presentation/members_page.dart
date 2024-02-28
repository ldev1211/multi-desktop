import 'package:flutter/material.dart';
import 'package:multi_desktop/app/features/login/data/enitity/student_entity.dart';
import 'package:multi_desktop/app/widget/app_progress.dart';
import 'package:multi_desktop/main.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  bool isLoading = true;

  List<StudentEntity>? members;

  Future<void> getMembers() async {
    final response = await service.getMembers();
    if (!response.error) {
      setState(() {
        List<dynamic> rawMembers = response.data;
        members = [];
        for (var e in rawMembers) {
          members!.add(StudentEntity.fromJson(e));
        }
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment:
              (isLoading) ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            if (isLoading)
              const Center(
                child: AppProgress(),
              ),
            if (!isLoading)
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Danh sách lớp",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: members!.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, i) {
                          StudentEntity member = members![i];
                          return Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(member.avt!),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  member.fullName!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  member.stuCode,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 24,
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
