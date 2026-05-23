import 'package:flutter/material.dart';
import 'dart:io';
import '../../services/image_picker_service.dart';

class ImageUploadBoxWidget extends StatefulWidget {
  final String label;
  final Function(File?)? onImageSelected;
  final String? existingImageUrl;

  const ImageUploadBoxWidget({
    required this.label,
    super.key,
    this.onImageSelected,
    this.existingImageUrl,
  });

  @override
  State<ImageUploadBoxWidget> createState() => _ImageUploadBoxWidgetState();
}

class _ImageUploadBoxWidgetState extends State<ImageUploadBoxWidget> {
  File? _selectedImage;
  final ImagePickerService _pickerService = ImagePickerService();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    setState(() => _isLoading = true);
    final image = await _pickerService.pickImage();
    setState(() {
      _selectedImage = image;
      _isLoading = false;
    });
    if (widget.onImageSelected != null) {
      widget.onImageSelected!(image);
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
          onTap: _pickImage,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : (_selectedImage != null)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      _selectedImage!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                : (widget.existingImageUrl != null &&
                      widget.existingImageUrl!.isNotEmpty)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.existingImageUrl!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Upload",
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
