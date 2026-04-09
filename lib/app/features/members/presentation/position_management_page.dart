import 'package:flutter/material.dart';
import 'package:multi_desktop/app/features/login/data/enitity/student_entity.dart';
import 'package:multi_desktop/app/widget/app_avt.dart';
import 'package:multi_desktop/app/widget/app_progress.dart';
import 'package:multi_desktop/main.dart';
import 'package:multi_desktop/util/app_colors.dart';
import 'package:multi_desktop/util/pref/pref_utils.dart';
import 'package:multi_desktop/util/ui_util.dart';

class PositionManagementPage extends StatefulWidget {
  final List<StudentEntity> classMembers;

  const PositionManagementPage({
    super.key,
    required this.classMembers,
  });

  @override
  State<PositionManagementPage> createState() => _PositionManagementPageState();
}

class _PositionManagementPageState extends State<PositionManagementPage> {
  bool isLoading = true;
  List<StudentEntity> students = [];
  List<StudentEntity> filteredStudents = [];
  List<Map<String, dynamic>> positions = [];
  final TextEditingController searchController = TextEditingController();
  int currentUserRole = 6;

  @override
  void initState() {
    super.initState();
    currentUserRole = PrefUtil.instance.getInt("role") ?? 6;
    _loadData();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterStudents();
  }

  void _filterStudents() {
    final query = searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        filteredStudents = List.from(students);
      } else {
        filteredStudents = students.where((student) {
          final nameMatch =
              student.fullName?.toLowerCase().contains(query) ?? false;
          final codeMatch = student.stuCode.toLowerCase().contains(query);
          return nameMatch || codeMatch;
        }).toList();
      }
    });
  }

  Future<void> _loadData() async {
    try {
      // Load positions
      final posResponse = await service.getPositions();
      if (!posResponse.error) {
        positions = List<Map<String, dynamic>>.from(posResponse.data);
      }

      // Load students based on role
      if (currentUserRole == 7) {
        // Bí thư Liên Chi Đoàn sees ALL students
        final stuResponse = await service.getAllStudents();
        if (!stuResponse.error) {
          List<dynamic> rawStudents = stuResponse.data;
          students = rawStudents
              .map((e) => StudentEntity.fromJson(Map<String, dynamic>.from(e)))
              .toList();
        }
      } else {
        // Bí thư chi đoàn sees class members only
        students = List.from(widget.classMembers);
      }

      filteredStudents = List.from(students);
    } catch (e) {
      debugPrint("Error loading data: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  String _getPositionName(int? roleId) {
    if (roleId == null) return "Chưa xác định";
    for (var pos in positions) {
      if (pos['id'] == roleId) {
        return pos['name'] ?? "Chưa xác định";
      }
    }
    return "Chưa xác định";
  }

  List<Map<String, dynamic>> _getAvailablePositions() {
    if (currentUserRole == 7) {
      // Bí thư Liên Chi Đoàn can assign any position
      return positions;
    } else if (currentUserRole == 3) {
      // Bí thư chi đoàn cannot assign Bí thư Liên Chi Đoàn (id=7)
      return positions.where((p) => p['id'] != 7).toList();
    }
    return [];
  }

  Future<void> _updatePosition(StudentEntity student, int newRole) async {
    UIUtil.showDialogLoading(context);
    try {
      final response = await service.updatePosition({
        'mssv': student.stuCode,
        'role': newRole,
      });
      Navigator.pop(context); // Close loading dialog
      if (!response.error) {
        setState(() {
          student.role = newRole;
        });
        UIUtil.showToast("Cập nhật chức vụ thành công");
      } else {
        UIUtil.showWarningDialog(
          context: context,
          message: response.message,
        );
      }
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      UIUtil.showWarningDialog(
        context: context,
        message: "Có lỗi xảy ra. Vui lòng thử lại!",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontSize = 16;
    final availablePositions = _getAvailablePositions();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColor.colorMain,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  "Quản lý chức vụ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (currentUserRole == 7)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColor.colorMain.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColor.colorMain.withOpacity(0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.admin_panel_settings,
                            color: AppColor.colorMain, size: 18),
                        SizedBox(width: 6),
                        Text(
                          "Bí thư Liên Chi Đoàn",
                          style: TextStyle(
                            color: AppColor.colorMain,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (currentUserRole == 3)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue.withOpacity(0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shield, color: Colors.blue, size: 18),
                        SizedBox(width: 6),
                        Text(
                          "Bí thư chi đoàn",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // Search bar
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: searchController,
                cursorColor: AppColor.colorMain,
                decoration: InputDecoration(
                  hintText: "Tìm kiếm theo mã sinh viên hoặc tên...",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 15,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade400,
                  ),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey.shade400),
                          onPressed: () {
                            searchController.clear();
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Student count
            Row(
              children: [
                Text(
                  "Tổng số: ${filteredStudents.length} sinh viên",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                if (currentUserRole == 3) ...[
                  const SizedBox(width: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.amber.shade200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline,
                            size: 14, color: Colors.amber.shade700),
                        const SizedBox(width: 4),
                        Text(
                          "Không thể gán chức vụ Bí thư Liên Chi Đoàn",
                          style: TextStyle(
                            color: Colors.amber.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),

            // Table header
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: AppColor.colorMain.withOpacity(0.08),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      "STT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Họ tên",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Mã sinh viên",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Lớp",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Chức vụ",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            if (isLoading) const Expanded(child: Center(child: AppProgress())),
            if (!isLoading && filteredStudents.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Không tìm thấy sinh viên nào",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (!isLoading && filteredStudents.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: filteredStudents.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, i) {
                    StudentEntity student = filteredStudents[i];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      decoration: BoxDecoration(
                        color: i % 2 == 0
                            ? Colors.white
                            : Colors.grey.shade50,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200),
                        ),
                      ),
                      child: Row(
                        children: [
                          // STT
                          SizedBox(
                            width: 50,
                            child: Text(
                              (i + 1 < 10) ? "0${i + 1}" : "${i + 1}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: fontSize,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Avatar
                          AppCircleAvt(
                            url: student.avt ?? "",
                            width: size.width * 0.04,
                            height: size.width * 0.04,
                          ),
                          const SizedBox(width: 12),
                          // Name
                          Expanded(
                            flex: 3,
                            child: Text(
                              student.fullName ?? "",
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: fontSize,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Student code
                          Expanded(
                            flex: 2,
                            child: Text(
                              student.stuCode,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: fontSize,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Class
                          Expanded(
                            flex: 2,
                            child: Text(
                              student.classCode ?? "",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: fontSize,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Position dropdown
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey.shade300),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  value: availablePositions
                                          .any((p) => p['id'] == student.role)
                                      ? student.role
                                      : null,
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColor.colorMain,
                                  ),
                                  hint: Text(
                                    _getPositionName(student.role),
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                  items: availablePositions.map((pos) {
                                    return DropdownMenuItem<int>(
                                      value: pos['id'],
                                      child: Text(
                                        pos['name'],
                                        style: TextStyle(
                                          color: pos['id'] == student.role
                                              ? AppColor.colorMain
                                              : Colors.black87,
                                          fontWeight:
                                              pos['id'] == student.role
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    if (newValue != null &&
                                        newValue != student.role) {
                                      UIUtil.showDialogMessage(
                                        context: context,
                                        message:
                                            "Bạn có chắc muốn thay đổi chức vụ của ${student.fullName} thành ${_getPositionName(newValue)}?",
                                        onOk: () {
                                          _updatePosition(student, newValue);
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
