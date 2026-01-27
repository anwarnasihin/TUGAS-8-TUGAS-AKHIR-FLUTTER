import 'package:finalproject/loading_transition.dart';
import 'package:flutter/material.dart';
// import 'package:google/google.dart'; // Baris ini sepertinya tidak perlu/error, saya komen dulu
import 'package:google_fonts/google_fonts.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // VARIABLE BARU UNTUK MENGATUR MATA PASSWORD
  bool _isObscure = true; 

  // Fungsi Login
  Future<void> _loginUser() async {
    try {
      // Loading indikator
      showDialog(
          context: context,
          builder: (context) => const Center(child: CircularProgressIndicator()));

      // PROSES LOGIN FIREBASE
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Tutup loading
      if (mounted) Navigator.pop(context);

      // JIKA BERHASIL -> Masuk ke Home
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoadingTransition(
              nextPage: Home(),
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Tutup loading dulu
      if (mounted) Navigator.pop(context);

      // JIKA GAGAL
      String errorMessage = "Username atau Password salah";

      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        errorMessage = "Email atau password salah";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Format email tidak valid";
      }

      // Tampilkan Alert Dialog Error
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Gagal Login"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 55,
                left: 22,
                right: 19,
              ),
              child: Image.asset(
                "assets/images/gambar1.png",
                width: 352,
                height: 330,
              ),
            ),

            const SizedBox(
              height: 44,
            ),

            //Input Email
            Padding(
              padding: const EdgeInsets.only(left: 27, right: 19),
              child: SizedBox(
                width: 354,
                height: 59.95,
                child: TextField(
                  controller: _emailController, //Controller
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: const TextStyle(
                      color: Color(0xffC0C0C0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xffC0C0C0),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xffC0C0C0),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 16.05,
            ),
            
            //Input Password (YANG KITA UBAH)
            Padding(
              padding: const EdgeInsets.only(left: 27, right: 19),
              child: SizedBox(
                width: 354,
                height: 59.95,
                child: TextField(
                  controller: _passwordController, //Controller
                  
                  // 1. Ubah ini agar dinamis (bisa berubah true/false)
                  obscureText: _isObscure, 
                  
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: const TextStyle(
                      color: Color(0xffC0C0C0),
                    ),
                    
                    // 2. Ubah icon biasa menjadi IconButton agar bisa diklik
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Logika: Jika obscure true (tertutup), tampilkan icon mata biasa
                        // Jika false (terbuka), tampilkan icon mata dicoret (off)
                        _isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color:  Colors.black, // Samakan warna dengan hint style
                      ),
                      onPressed: () {
                        // 3. Update state saat diklik
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xffC0C0C0),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xffC0C0C0),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 49.05,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 27, right: 19),
              child: SizedBox(
                width: 354,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3498DB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _loginUser, //Memanggil Fungsi Login
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 192,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Belum punya akun?",
                  style: GoogleFonts.montserrat(
                      fontSize: 15, color: Colors.black),
                ),

                //Navigasi ke halaman register
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoadingTransition(
                          nextPage: Register(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    " Register",
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: const Color(0xff3498DB), // Warna biru tema
                    ),
                  ),
                ),
                Text(
                  " sekarang!",
                  style: GoogleFonts.montserrat(
                      fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}