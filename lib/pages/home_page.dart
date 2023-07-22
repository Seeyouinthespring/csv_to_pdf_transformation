import 'package:csv_to_pdf_transformation/services/file_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'chart_page.dart';
import '../components/action_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ActionButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  navigator.push(
                    MaterialPageRoute(
                      builder: (context) => ChartPage(
                        fileService: SystemFileService(result.files.single.path ?? ''),
                      ),
                    ),
                  );
                }
              },
              title: 'Upload .csv',
            ),
            ActionButton(
              onPressed: () async {
                await navigator.push(
                  MaterialPageRoute(
                    builder: (context) => ChartPage(
                      fileService: AssetFileService(),
                    ),
                  ),
                );
              },
              title: 'Use default .csv',
            ),
          ],
        ),
      ),
    );
  }
}
