import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // 1. IMPORT INI

class DetailNews extends StatelessWidget {
  final Map article;

  const DetailNews({super.key, required this.article});

  // Fungsi untuk membuka link di browser
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. GAMBAR BACKGROUND
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 350,
            child: Image.network(
              article['urlToImage'] ?? 'https://via.placeholder.com/400',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey[300]);
              },
            ),
          ),

          // 2. TOMBOL BACK (Bulat Transparan)
          Positioned(
            top: 40,
            left: 15,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),

          // 3. KONTEN BERITA
          Positioned.fill(
            top: 300,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kategori & Tanggal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            article['source']['name'] ?? 'News',
                            style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          article['publishedAt']?.substring(0, 10) ?? '',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Judul
                    Text(
                      article['title'] ?? 'No Title',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Deskripsi
                    Text(
                      article['description'] ?? 'No description available.',
                      style: const TextStyle(
                          fontSize: 16, height: 1.5, color: Colors.black54),
                    ),
                    const SizedBox(height: 15),

                    // Konten (yang terpotong)
                    Text(
                      (article['content'] ?? '')
                          .replaceAll(RegExp(r'\[\+\d+ chars\]'), ''), 
                      // ^ Trik untuk menghilangkan tulisan [+4660 chars] biar bersih
                      style: const TextStyle(
                          fontSize: 16, height: 1.5, color: Colors.black54),
                    ),
                    
                    const SizedBox(height: 30),

                    // TOMBOL BACA SELENGKAPNYA
                    // TOMBOL "CIAMIK" (Gradient + Shadow + Icon)
                    Container(
                      width: double.infinity,
                      height: 55, // Tinggi tombol pas
                      decoration: BoxDecoration(
                        // 1. EFEK GRADASI (Biru Terang ke Biru Gelap/Hitam)
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff3498DB), // Biru (sesuai header drawer Anda)
                            Color(0xff1A202C), // Hitam (sesuai tema gelap)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30), // Membuatnya bulat (Pill shape)
                        // 2. EFEK BAYANGAN (Glowing effect di bawah)
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff3498DB).withOpacity(0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 8), // Bayangan agak ke bawah
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (article['url'] != null) {
                            _launchUrl(article['url']);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, // PENTING: Transparan agar gradient terlihat
                          shadowColor: Colors.transparent,     // Hilangkan shadow bawaan tombol
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Read Full Story",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1, // Memberi jarak antar huruf agar elegan
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward_rounded, color: Colors.white), // Ikon panah
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}