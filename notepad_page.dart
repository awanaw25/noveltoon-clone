import 'package:flutter/material.dart';

class NotepadPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave; // Callback untuk menyimpan novel

  NotepadPage({required this.onSave});

  @override
  _NotepadPageState createState() => _NotepadPageState();
}

class _NotepadPageState extends State<NotepadPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Novel Baru'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Menyimpan novel jika semua data valid
              if (titleController.text.isNotEmpty &&
                  contentController.text.isNotEmpty) {
                Map<String, dynamic> newNovel = {
                  'title': titleController.text,
                  'content': contentController.text,
                };
                widget.onSave(newNovel); // Menyimpan novel menggunakan callback
                Navigator.pop(context); // Kembali ke halaman sebelumnya setelah menyimpan
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Silakan masukkan semua data novel')),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input untuk judul novel
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Judul Novel'),
            ),
            SizedBox(height: 16),
            // Textarea untuk menulis isi novel
            TextField(
              controller: contentController,
              maxLines: 10,
              decoration: InputDecoration(
                labelText: 'Isi Novel',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
