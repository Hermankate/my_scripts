import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../services/python_service.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  final TextEditingController _controller = TextEditingController();
  String _status = 'Enter a YouTube link to download the video';

  Future<void> _downloadVideo() async {
    String link = _controller.text;
    if (link.isEmpty) {
      setState(() {
        _status = 'Please provide a valid link!';
      });
      return;
    }

    try {
      Directory tempDir = await getApplicationDocumentsDirectory();
      String savePath = "${tempDir.path}/downloaded_video.mp4";

      setState(() {
        _status = 'Downloading...';
      });

      String result = await PythonService.downloadYouTubeVideo(link, savePath);
      setState(() {
        _status = result;
      });
    } catch (e) {
      setState(() {
        _status = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Download Video')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'YouTube Link',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _downloadVideo,
              child: const Text('Download'),
            ),
            const SizedBox(height: 20),
            Text(
              _status,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
