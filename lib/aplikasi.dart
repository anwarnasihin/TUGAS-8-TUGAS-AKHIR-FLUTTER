import 'package:finalproject/loading_transition.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finalproject/login.dart';    
import 'package:finalproject/register.dart'; 
import 'package:finalproject/about_me.dart';
import 'package:finalproject/loading_transition.dart';


class Aplikasi extends StatefulWidget {
  const Aplikasi({super.key});

  @override
  State<Aplikasi> createState() => _AplikasiState();
}

class _AplikasiState extends State<Aplikasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(
              top: 135,
              left: 21,
              right: 20,
            ),
            child: Image.asset("assets/images/logo1.png",
            width: 352,
            height: 330,
            ),
            ),

            SizedBox(height: 42,),

            Text("Yuk, Membaca Bersama",
            style: GoogleFonts.arimo(
              fontSize: 21,
              fontWeight: FontWeight.bold
            ),
            ),

            Text("PM News",
            style: GoogleFonts.arimo(
              fontSize: 21,
              fontWeight: FontWeight.bold
            ),
            ),

            SizedBox(height: 25,),

            Text("Berita Terpercaya, Di Ujung Jari Anda",
            style: GoogleFonts.roboto(
              fontSize: 15,
            ),
            ),

            SizedBox(height: 39,),

            // MULAI CODE BUTTON LOGIN
            Container(
              width: 354, 
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // Membuat tombol jadi lonjong
                gradient: const LinearGradient( // Membuat warna gradasi
                  colors: [Color(0xff3498db), Color(0xff2980b9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [ // Membuat efek bayangan (glow)
                  BoxShadow(
                    color: const Color(0xff3498db).withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Transparan agar gradasi terlihat
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoadingTransition(
                      nextPage: Login(),
                    ),
                    ),
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            

            SizedBox(height: 21,),

            
            // TOMBOL REGISTER  
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // Bayangan halus
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xff3498db),
                  elevation: 0, // Hilangkan shadow bawaan tombol
                  side: const BorderSide(
                    color: Color(0xff3498db),
                    width: 2, // Garis pinggir lebih tebal
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoadingTransition(
                      nextPage: Register(),
                    ),
                    ),
                  );
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 50,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Go to",
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    color: Colors.black),
                  ),

                  //Navigasi ke halaman About Me
                  GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  LoadingTransition(
                      nextPage: AboutMe(),
                    ),
                    ),
                  );
                },
                child: Text(
                  " About Me",
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: Color(0xff3498DB),
                    fontWeight: FontWeight.bold // Warna biru tema
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 30,)
        ],
      ),
    );
  }
}