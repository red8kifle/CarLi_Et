import 'package:flutter/material.dart';
import 'dart:io';
import '../../services/pdf_picker_service.dart';

class PdfUploadBoxWidget extends StatefulWidget {
  final String label;
  final Function(File?)? onFileSelected;
  final String? existingResumeUrl;

  const PdfUploadBoxWidget({
    required this.label,
    super.key,
    this.onFileSelected,
    this.existingResumeUrl,
  });

  @override
  State<PdfUploadBoxWidget> createState() => _PdfUploadBoxWidgetState();
}

class _PdfUploadBoxWidgetState extends State<PdfUploadBoxWidget> {
  File? _selectedFile;
  String? _fileName;
  final PdfPickerService _pickerService = PdfPickerService();
  bool _isLoading = false;

  Future<void> _pickPdf() async {
    setState(() => _isLoading = true);
    final file = await _pickerService.pickPdf();
    final name = await _pickerService.getFileName();
    setState(() {
      _selectedFile = file;
      _fileName = name;
      _isLoading = false;
    });
    if (widget.onFileSelected != null) {
      widget.onFileSelected!(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickPdf,
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : (_selectedFile != null)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.red,
                        size: 32,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Resume Uploaded",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            _fileName ?? "resume.pdf",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16,
                      ),
                    ],
                  )
                : (widget.existingResumeUrl != null &&
                      widget.existingResumeUrl!.isNotEmpty)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.red,
                        size: 32,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Resume Already Uploaded",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16,
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.red,
                        size: 32,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Upload Resume",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "* only PDF file",
                        style: TextStyle(color: Colors.grey[600], fontSize: 10),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
