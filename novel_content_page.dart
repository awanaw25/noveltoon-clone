import 'package:flutter/material.dart';

class NovelContentPage extends StatelessWidget {
  final String title;
  final List<String> genres;

  NovelContentPage({required this.title, required this.genres});

  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menulis Novel: $title')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input isi novel
            TextField(
              controller: contentController,
              maxLines: 20,
              decoration: InputDecoration(labelText: 'Tulis Cerita'),
            ),
            Spacer(),
            // Tombol untuk menyimpan dan kembali ke halaman utama
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // Simpan novel dan kembali ke halaman utama
                  String content = contentController.text;
                  // Di sini dapat diterapkan logika untuk menyimpan novel
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: Text('Save Novel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
