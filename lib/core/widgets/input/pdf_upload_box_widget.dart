import 'package:flutter/material.dart';

class PdfUploadBoxWidget extends StatelessWidget {
  final String label;

  const PdfUploadBoxWidget({
    required this.label,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            label,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.picture_as_pdf, color: Colors.red),
              const SizedBox(height: 1),
              const Text("or drag and drop", style: TextStyle(color: Color(0xFF8F8D8D), fontSize: 12)),
              const SizedBox(height: 1),
              const Text("* only PDF file", style: TextStyle(color: Color(0xFF8F8D8D), fontSize: 7)),
            ],
          ),
        ),
      ],
    );
  }
}