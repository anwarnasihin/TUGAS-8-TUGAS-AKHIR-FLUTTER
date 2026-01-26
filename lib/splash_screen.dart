import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finalproject/aplikasi.dart'; 
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    // Logika Timer: Tunggu 3 detik, lalu pindah ke halaman Aplikasi
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Aplikasi()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Sesuaikan warna background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tampilkan Logo saja
            Image.asset(
              "assets/images/logo1.png",
              width: 180, 
              height: 180,
            ),
            const SizedBox(height: 20),
            // Tampilkan Teks Judul (Opsional)
            Text(
              "Aplikasi PM News",
              style: GoogleFonts.arimo(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            Text(
              "Splash Screen",
              style: GoogleFonts.arimo(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            // Indikator Loading (Opsional, agar terlihat sedang memuat)
            const SpinKitWave(
              color: Color(0xff3498db), // Warna biru tema aplikasi
              size: 40.0,               // Ukuran animasi
            ),
          ],
        ),
      ),
    );
  }
}