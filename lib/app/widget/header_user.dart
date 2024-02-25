import 'package:flutter/material.dart';
import 'package:multi_desktop/util/pref/pref_utils.dart';

class HeaderUser {
  static Widget get home => const HeaderUserHome();

  static Widget get pointExt => const HeaderUserPointExt();
}

class HeaderUserHome extends StatelessWidget {
  const HeaderUserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class HeaderUserPointExt extends StatelessWidget {
  const HeaderUserPointExt({super.key});

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
            backgroundImage:
                NetworkImage(PrefUtil.instance.getString("linkAvtCurr")!),
          ),
          const Padding(padding: EdgeInsets.only(left: 12)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                PrefUtil.instance.getString("stuNameCurr")!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                PrefUtil.instance.getString("stuCodeCurr")!,
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
