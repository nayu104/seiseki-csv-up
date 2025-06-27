import 'package:flutter/material.dart';

enum AttendanceStatus { none, attended, late, absent, early_leave }

class ClassDetailsScreen extends StatefulWidget {
  final String className;

  const ClassDetailsScreen({Key? key, required this.className})
    : super(key: key);

  @override
  State<ClassDetailsScreen> createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
  AttendanceStatus _status = AttendanceStatus.none;
  int _attendanceCount = 1;
  int _lateCount = 0;
  int _absentCount = 0;
  int _earlyLeaveCount = 0;

  void _setAttendanceStatus(AttendanceStatus newStatus) {
    if (_status != AttendanceStatus.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '本日のステータスは記録済みです。',
          ), // "Today's status has been recorded."
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    setState(() {
      _status = newStatus;
      String message;
      switch (newStatus) {
        case AttendanceStatus.attended:
          _attendanceCount++;
          message = '出席しました';
          break;
        case AttendanceStatus.late:
          _lateCount++;
          message = '遅刻として記録しました';
          break;
        case AttendanceStatus.absent:
          _absentCount++;
          message = '欠席として記録しました';
          break;
        case AttendanceStatus.early_leave:
          _earlyLeaveCount++;
          message = '早退として記録しました';
          break;
        case AttendanceStatus.none:
          return; // Do nothing
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.green),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.className)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            _buildMainAttendanceButton(),
            const SizedBox(height: 32),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatusButton(
                      context,
                      '出席',
                      _attendanceCount.toString(),
                      Colors.green,
                      AttendanceStatus.attended,
                    ),
                    _buildStatusButton(
                      context,
                      '遅刻',
                      _lateCount.toString(),
                      Colors.orange,
                      AttendanceStatus.late,
                    ),
                    _buildStatusButton(
                      context,
                      '欠席',
                      _absentCount.toString(),
                      Colors.red,
                      AttendanceStatus.absent,
                    ),
                    _buildStatusButton(
                      context,
                      '早退',
                      _earlyLeaveCount.toString(),
                      Colors.blueGrey,
                      AttendanceStatus.early_leave,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'シラバス', // Syllabus
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSyllabusItem('第1回', 'オリエンテーションと自己紹介'),
                    const Divider(),
                    _buildSyllabusItem('第2回', '復習'),
                    const Divider(),
                    _buildSyllabusItem('第3回', '復習'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainAttendanceButton() {
    bool isEnabled = _status == AttendanceStatus.none;
    String buttonText;
    IconData buttonIcon;

    switch (_status) {
      case AttendanceStatus.attended:
        buttonText = '出席済み';
        buttonIcon = Icons.check_circle;
        break;
      case AttendanceStatus.late:
        buttonText = '遅刻で記録済み';
        buttonIcon = Icons.watch_later;
        break;
      case AttendanceStatus.absent:
        buttonText = '欠席で記録済み';
        buttonIcon = Icons.cancel;
        break;
      case AttendanceStatus.early_leave:
        buttonText = '早退で記録済み';
        buttonIcon = Icons.hourglass_bottom;
        break;
      case AttendanceStatus.none:
        buttonText = '出席する';
        buttonIcon = Icons.check_circle_outline;
        break;
    }

    return Center(
      child: ElevatedButton.icon(
        onPressed:
            isEnabled
                ? () => _setAttendanceStatus(AttendanceStatus.attended)
                : null,
        icon: Icon(buttonIcon, size: 28),
        label: Text(buttonText),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isEnabled ? Colors.blueAccent : Colors.grey,
          disabledForegroundColor: Colors.white.withOpacity(0.8),
          disabledBackgroundColor: Colors.grey.withOpacity(0.6),
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
      ),
    );
  }

  Widget _buildStatusButton(
    BuildContext context,
    String title,
    String count,
    Color color,
    AttendanceStatus statusToSet,
  ) {
    return InkWell(
      onTap: () => _setAttendanceStatus(statusToSet),
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyllabusItem(String week, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$week: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(description, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
