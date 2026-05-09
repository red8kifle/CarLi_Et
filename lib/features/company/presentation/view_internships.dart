import 'package:flutter/material.dart';

class ViewInternships extends StatelessWidget {
  const ViewInternships({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Color(0xFF087E8B)),
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Text(
            "My Internships",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF087E8B),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Internship",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
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
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 120,
                    child: Card(
                      color: Color(0xFFE3F8F7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: const Text(
                          "Internship Title",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: const Text("Internship Description"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.edit),
                            SizedBox(width: 8),
                            Icon(Icons.delete),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
