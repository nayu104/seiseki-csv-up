import 'package:flutter/material.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('前期'), // First Semester
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
      body: const TimetableGrid(),
    );
  }
}

class TimetableGrid extends StatelessWidget {
  const TimetableGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const days = ['月', '火', '水', '木', '金'];
    const periods = ['1', '2', '3', '4', '5'];

    return Column(
      children: [
        Container(
          height: 40,
          color: Colors.grey[200],
          child: Row(
            children: [
              const SizedBox(width: 40), // Placeholder for period numbers
              ...days.map(
                (day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: Column(
                  children:
                      periods
                          .map(
                            (period) =>
                                Expanded(child: Center(child: Text(period))),
                          )
                          .toList(),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: 25,
                  itemBuilder: (context, index) {
                    final col = index % 5;
                    final row = index ~/ 5;

                    if (row == 0 && col == 2) {
                      return _buildTappableClassCell(
                        context,
                        '数学',
                        Colors.lightBlue.withOpacity(0.5),
                      );
                    }
                    if (row == 2 && col == 2) {
                      return _buildTappableClassCell(
                        context,
                        'HCI',
                        Colors.orange.withOpacity(0.5),
                        hasBorder: true,
                      );
                    }

                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTappableClassCell(
    BuildContext context,
    String className,
    Color color, {
    bool hasBorder = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/class_details', arguments: className);
      },
      child: Container(
        margin: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          color: color,
          border:
              hasBorder
                  ? Border.all(color: Colors.orange, width: 2)
                  : Border.all(color: Colors.grey[300]!),
        ),
        child: Center(
          child: Text(
            className,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
