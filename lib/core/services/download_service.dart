import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DownloadService {
  final Dio _dio = Dio();

  Future<bool> downloadAndShare(String url, String fileName) async {
    try {
      // Show loading
      print('Downloading from: $url');

      // Get temporary directory
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/$fileName.pdf';

      // Download file
      await _dio.download(url, filePath);

      // Share file
      await Share.shareXFiles([
        XFile(filePath),
      ], text: 'Here is the resume for $fileName');

      return true;
    } catch (e) {
      print('Download error: $e');
      return false;
    }
  }

  Future<bool> saveToDownloads(String url, String fileName) async {
    try {
      final directory = await getDownloadsDirectory();
      if (directory == null) return false;

      final filePath = '${directory.path}/$fileName.pdf';
      await _dio.download(url, filePath);
      return true;
    } catch (e) {
      return false;
    }
  }
}
