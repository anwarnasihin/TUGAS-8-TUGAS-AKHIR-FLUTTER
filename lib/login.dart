import 'package:finalproject/loading_transition.dart';
import 'package:flutter/material.dart';
import 'package:google/google.dart';
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
//Controller
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

  // Fungsi Login
  Future<void> _loginUser() async {
    try {
      // Loading indikator (opsional, biar keren)
      showDialog(
          context: context,
          builder: (context) => const Center(child: CircularProgressIndicator()));

      // PROSES LOGIN FIREBASE
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Tutup loading
      Navigator.pop(context);

      // JIKA BERHASIL -> Masuk ke Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoadingTransition(
          nextPage: Home(),
        ),
        ), 
      );

    } on FirebaseAuthException catch (e) {
      // Tutup loading dulu
      Navigator.pop(context);

      // JIKA GAGAL (Salah password / email ga ada)
      String errorMessage = "Username atau Password salah";
      
      // Cek kode error dari Firebase
      if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        errorMessage = "Email atau password salah"; // Peringatan salah email atau password
      } else if (e.code == 'invalid-email') {
        errorMessage = "Format email tidak valid";
      }

      // Tampilkan Alert Dialog Error
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(
                top: 55,
                left: 22,
                right: 19,
              ),
              child: Image.asset("assets/images/gambar1.png",
              width: 352,
              height: 330,
              ),
              ),
        
              SizedBox(height: 44,),
        
              //Input Email
              Padding(
                padding: EdgeInsets.only(left: 27, right: 19),
                child: SizedBox(
                  width: 354,
                  height: 59.95,
                  child: TextField(
                    controller: _emailController,//Controller
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Color(0xffC0C0C0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xffC0C0C0),
                          width: 1.0,
                        ),
                      ),
        
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xffC0C0C0),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                ),
        
              SizedBox(height: 16.05,),
              //Input Password
              Padding(
                padding: EdgeInsets.only(left: 27, right: 19),
                child: SizedBox(
                  width: 354,
                  height: 59.95,
                  child: TextField(
                    controller: _passwordController,//Controller
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Color(0xffC0C0C0),
                      ),
                      suffixIcon: Icon(Icons.visibility_outlined),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xffC0C0C0),
                          width: 1.0,
                        ),
                      ),
        
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xffC0C0C0),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                ),
        
                SizedBox(height: 49.05,),
        
                Padding(
                  padding: const EdgeInsets.only(left: 27, right: 19),
                  child: SizedBox(
                    width: 354,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff3498DB),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _loginUser,//Memanggil Fungsi Login 
                      child: Text("Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                      ),
                  ),
                ),
        
                SizedBox(height: 192,),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Belum punya akun?",
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Colors.black),
                    ),
        
                    //Navigasi ke halaman register
                    GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  LoadingTransition(
                        nextPage: Register(),
                      ),
                      ),
                    );
                  },
                  child: Text(
                    " Register",
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Color(0xff3498DB), // Warna biru tema
                      
                    ),
                  ),
                ),
                Text(" sekarang!",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Colors.black
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}