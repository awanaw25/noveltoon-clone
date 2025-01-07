import 'package:flutter/material.dart';
import 'login_page.dart';
import 'notepad_page.dart'; // Import halaman notepad
import '../auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> novels = []; // Daftar novel yang telah disimpan

  // Fungsi ini digunakan untuk mengganti halaman sesuai tab yang dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Fungsi untuk menangani simpan novel dan menambahkannya ke daftar
  void _addNovel(Map<String, dynamic> novel) {
    setState(() {
      novels.add(novel); // Menambahkan novel ke daftar
    });
  }

  // Daftar halaman yang akan ditampilkan sesuai tab
  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Halaman Utama', style: TextStyle(fontSize: 24))),
    Center(child: Text('Rak Buku', style: TextStyle(fontSize: 24))),
    Center(child: Text('Search', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profil', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? _buildHomePage() // Menampilkan halaman baru untuk "Home"
          : _pages[_selectedIndex], // Menampilkan tab lainnya
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Rak Buku'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[700],
        onTap: _onItemTapped,
      ),
      // Footer dengan Notepad
      persistentFooterButtons: [
        NotepadFooter(onSave: _addNovel), // Mengirimkan _addNovel ke NotepadFooter
      ],
    );
  }

  // Menampilkan daftar novel di halaman utama secara horizontal
  Widget _buildHomePage() {
    return novels.isEmpty
        ? Center(child: Text('Belum ada novel baru.'))
        : ListView.builder(
            scrollDirection: Axis.horizontal, // Mengubah ke horizontal
            itemCount: novels.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman detail novel
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NovelDetailPage(
                          title: novels[index]['title'],
                          content: novels[index]['content'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          novels[index]['title'],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Text(
                          novels[index]['content'],
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}

// Widget Footer yang terdapat tombol 'Buat Novel Baru'
class NotepadFooter extends StatelessWidget {
  final Function(Map<String, dynamic>) onSave; // Fungsi untuk menerima callback

  NotepadFooter({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          // Menavigasi ke halaman Notepad
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotepadPage(onSave: onSave)),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text('Buat Novel Baru'),
      ),
    );
  }
}

// Halaman untuk melihat detail Novel
class NovelDetailPage extends StatelessWidget {
  final String title;
  final String content;

  NovelDetailPage({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text(content, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
