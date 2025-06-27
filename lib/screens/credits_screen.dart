import 'package:flutter/material.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('単位取得状況'), // Credit Acquisition Status
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // TODO: Implement drawer or menu functionality
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              '戻る', // Back
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        backgroundColor: Colors.grey[200],
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ユーザ様の履修状況', // Your Course Status
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            _buildCreditsTable(isCurrentUser: true),
            const SizedBox(height: 32),
            Text(
              'ユーザ様と同じ学科の履修状況', // Course Status for Same Department
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            _buildCreditsTable(isCurrentUser: false),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditsTable({required bool isCurrentUser}) {
    // Sample data, will be different for user vs department
    final data = isCurrentUser ? _userCreditsData : _departmentCreditsData;

    return DataTable(
      columnSpacing: 38.0,
      headingRowColor: MaterialStateColor.resolveWith(
        (states) => Colors.blueGrey[50]!,
      ),
      columns: const [
        DataColumn(
          label: Text(
            '科目分類\n(Category)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            '卒業要件単位\n(Required)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          numeric: true,
        ),
      ],
      rows:
          data.entries.map((entry) {
            return DataRow(
              cells: [
                DataCell(Text(entry.key)),
                DataCell(Text(entry.value.toString())),
              ],
            );
          }).toList(),
      border: TableBorder.all(color: Colors.grey[400]!, width: 1.5),
      dividerThickness: 1,
    );
  }
}

// Sample data maps
const Map<String, int> _userCreditsData = {
  '卒業要件': 1,
  '総合単位': 0,
  '必修': 1,
  '選択': 0,
  '他学科': 0,
  '単位未修': 0,
  '専門教育': 0,
};

const Map<String, int> _departmentCreditsData = {
  '卒業要件': 2,
  '総合単位': 1,
  '必修': 1,
  '選択': 0,
  '他学科': 0,
  '単位未修': 0,
  '専門教育': 0,
};
