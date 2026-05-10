import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final double width;

  const DropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.width = 0.85,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LABEL
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 6),

            // DROPDOWN
            DropdownButtonFormField<String>(
              initialValue: selectedValue,
              items: items.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: onChanged,

              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey.shade500),

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF087E8B),
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
