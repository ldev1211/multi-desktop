import 'package:flutter/material.dart';
import 'package:multi_desktop/app/features/login/data/enitity/student_entity.dart';

class HeaderUser {
  static Widget pointExt(StudentEntity studentEntity) =>
      HeaderUserPointExt(student: studentEntity);
}

class HeaderUserHome extends StatelessWidget {
  const HeaderUserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class HeaderUserPointExt extends StatelessWidget {
  HeaderUserPointExt({super.key, required this.student});

  StudentEntity student;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(student.avt!),
          ),
          const Padding(padding: EdgeInsets.only(left: 12)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                student.fullName!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                student.stuCode,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Danh sách hoạt động",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
