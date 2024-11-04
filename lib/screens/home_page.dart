import 'package:flutter/material.dart';
import 'login_page.dart';
import '../auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Fungsi ini digunakan untuk mengganti halaman sesuai tab yang dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow, // warna kuning untuk dashboard bawah
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Rak Buku',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[700],
        onTap: _onItemTapped,
      ),
    );
  }
}