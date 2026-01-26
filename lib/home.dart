import 'package:finalproject/loading_transition.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'detail_news.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalproject/aplikasi.dart';
import 'package:finalproject/splash_screen.dart';
import 'package:finalproject/loading_transition.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // 1. AMBIL DATA USER YANG SEDANG LOGIN
  final User? user = FirebaseAuth.instance.currentUser;

  // Fungsi Logout
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoadingTransition(
          nextPage: Aplikasi(),
        ),
        ),
      );
    }
  }

  // Variabel Data
  List beritaTerhangat = [];
  List beritaLama = [];
  
  // Variabel Status (Penting agar tidak stuck loading)
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    ambilBerita();
  }

  Future<void> ambilBerita() async {
    // URL API Berita Teknologi (Menggunakan API Key Asli Anda)
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?category=technology&language=en&apiKey=b503e62626804318a7f6c66fe488e228');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          // Mengambil 5 berita pertama untuk bagian atas
          beritaTerhangat = data['articles'].take(5).toList();
          // Mengambil sisanya untuk bagian bawah
          beritaLama = data['articles'].skip(5).toList();
          isLoading = false; // Matikan loading setelah data dapat
        });
      } else {
        print("Gagal mengambil data. Status: ${response.statusCode}");
        setState(() {
          isLoading = false; // Tetap matikan loading agar user tahu ada error
        });
      }
    } catch (e) {
      print("Error koneksi: $e");
      setState(() {
        isLoading = false; // Matikan loading jika internet mati
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff1A202C),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "NewsApps",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // 2. UPDATE DRAWER DI SINI
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xff3498DB), // Warna biru tema kamu
              ),
              // TAMPILKAN NAMA ASLI (Jika kosong, tampilkan 'Pengguna')
              accountName: Text(
                user?.displayName ?? "Pengguna", 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              // TAMPILKAN EMAIL ASLI
              accountEmail: Text(
                user?.email ?? "Email tidak tersedia",
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Color(0xff3498DB)),
              ),
            ),
            
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
              },
            ),
            
            // TOMBOL LOGOUT
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                 _logout(); // Panggil fungsi logout
              },
            ),
          ],
        ),
      ),
      
      // LOGIKA TAMPILAN:
      // 1. Jika loading -> Tampilkan putaran loading
      // 2. Jika data kosong (selesai loading tapi tak ada berita) -> Tampilkan pesan error
      // 3. Jika ada data -> Tampilkan berita
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : beritaTerhangat.isEmpty
              ? const Center(child: Text("Tidak ada berita atau Internet error."))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Latest News",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Berita Terhangat (Horizontal)
                      // GANTI BLOK ListView.builder YANG HORIZONTAL DENGAN INI:
                      SizedBox(
                        height: 320,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: beritaTerhangat.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Navigasi ke halaman detail
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoadingTransition(
                                    nextPage: DetailNews(article: beritaTerhangat[index]),
                                  ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 300,
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                // Gunakan Stack agar bisa menumpuk Gambar, Bayangan, dan Teks
                                child: Stack(
                                  children: [
                                    // LAPISAN 1: GAMBAR (Paling Bawah)
                                    Positioned.fill(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.network(
                                          beritaTerhangat[index]['urlToImage'] ?? 'https://via.placeholder.com/400',
                                          fit: BoxFit.cover,
                                          // Fitur penting: Jika gambar error/diblokir (403), ganti dengan warna abu-abu
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[300],
                                              child: const Center(
                                                child: Icon(Icons.broken_image, color: Colors.grey),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    
                                    // LAPISAN 2: EFEK GELAP (Agar teks terbaca)
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.8), // Hitam pekat di bawah
                                              Colors.transparent,            // Bening di atas
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              
                                    // LAPISAN 3: TEKS (Paling Atas)
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            beritaTerhangat[index]['source']['name'] ?? 'NEWS',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            beritaTerhangat[index]['title'] ?? 'No Title',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Berita Lama (Vertical)
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Recent News",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: beritaLama.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoadingTransition(
                                    nextPage: DetailNews(article: beritaLama[index]),
                                    ),
                                  ),
                                );
                              },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      beritaLama[index]['urlToImage'] ??
                                          'https://via.placeholder.com/150',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: 100, 
                                          height: 100, 
                                          color: Colors.grey[300]
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          beritaLama[index]['source']['name'] ??
                                              'News',
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        Text(
                                          beritaLama[index]['title'] ??
                                              'No Title',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          beritaLama[index]['publishedAt'] ??
                                              'Today',
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
    );
  }
}