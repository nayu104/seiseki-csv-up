import 'package:flutter/material.dart';

class CsvUploadScreen extends StatefulWidget {
  const CsvUploadScreen({Key? key}) : super(key: key);

  @override
  State<CsvUploadScreen> createState() => _CsvUploadScreenState();
}

class _CsvUploadScreenState extends State<CsvUploadScreen> {
  bool _uploaded = false;

  void _showFeedbackDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('完了'),
            content: const Text('成績を登録しました。ホーム画面にもどりますか？'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // ダイアログを閉じる
                  Navigator.of(
                    context,
                  ).popUntil((route) => route.isFirst); // ホームへ
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CSVファイルアップロード')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('ファイルを選択（ダミー）')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  _uploaded
                      ? null
                      : () {
                        setState(() {
                          _uploaded = true;
                        });
                        _showFeedbackDialog();
                      },
              child: const Text('アップロード（ダミー）'),
            ),
            const SizedBox(height: 24),
            if (_uploaded)
              const Text(
                'アップロードが完了しました！',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('ホームに戻る'),
            ),
          ],
        ),
      ),
    );
  }
}
