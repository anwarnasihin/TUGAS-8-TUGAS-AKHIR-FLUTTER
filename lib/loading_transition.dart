import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Pastikan sudah install ini

class LoadingTransition extends StatefulWidget {
  final Widget nextPage; // Halaman tujuan (misal: Home, Detail, dll)

  const LoadingTransition({super.key, required this.nextPage});

  @override
  State<LoadingTransition> createState() => _LoadingTransitionState();
}

class _LoadingTransitionState extends State<LoadingTransition> {

  @override
  void initState() {
    super.initState();
    // Setting Timer 2 Detik
    Timer(const Duration(seconds: 1), () {
      // Pindah ke halaman tujuan dengan pushReplacement 
      // (agar kalau di-back, tidak balik ke loading ini)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.nextPage),
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
            // Animasi sesuai gambar request kamu (Batang Biru)
            const SpinKitWave(
              color: Color(0xff3498DB),
              size: 50.0,
              type: SpinKitWaveType.start, // Gaya gelombang
            ),
            const SizedBox(height: 20),
            const Text(
              "Mohon Tunggu...",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}