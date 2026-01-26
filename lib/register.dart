import 'package:finalproject/loading_transition.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isObscure = true;
//Controller untuk menampung teks input 
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

//Fungsi Register ke Firebase
Future<void> _registerUser() async {
    // Validasi sederhana: Cek password sama atau tidak
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password dan Konfirmasi tidak sama!")),
      );
      return;
    }

      try {
        // 1. Kita tampung hasil pembuatan akun ke variabel 'userCredential'
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // 2. Setelah akun jadi, langsung kita update Nama Lengkapnya
        // Mengambil text dari _nameController yang sudah kamu buat
        if (userCredential.user != null) {
          await userCredential.user!.updateDisplayName(_nameController.text.trim());
          await userCredential.user!.reload(); // Refresh user agar datanya update
        }

        // Jika sukses:
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registrasi Berhasil! Silakan Login.")),
          );

        // Pindah ke halaman Login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Jika Gagal (Misal email sudah dipakai)
      String message = "Terjadi kesalahan";
      if (e.code == 'weak-password') {
        message = "Password terlalu lemah (min 6 karakter)";
      } else if (e.code == 'email-already-in-use') {
        message = "Email sudah terdaftar";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
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
                top: 13,
                left: 26,
                right: 24
              ),
              child: Image.asset("assets/images/gambar2.png",
              width: 352,
              height: 330,
              ),
              ),
        
              SizedBox(height: 48,),
              // Input Nama Lengkap
              Padding(
                padding: EdgeInsets.only(left:27, right: 19),
                child: SizedBox(
                  width: 354,
                  height: 52,
                  child: TextField(
                    controller: _nameController,//Controller
                    decoration: InputDecoration(
                      hintText: "Nama Lengkap",
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
                        )
                      )
                    ),
                  ),
                ),
                ),

                SizedBox(height: 25,),
        
              //Input Email
              Padding(
                padding: EdgeInsets.only(left:27, right: 19),
                child: SizedBox(
                  width: 354,
                  height: 52,
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
                        )
                      )
                    ),
                  ),
                ),
                ),
        
                SizedBox(height: 25,),
        
                //input password
                Padding(
                padding: EdgeInsets.only(left: 27, right: 19),
                child: SizedBox(
                  width: 354,
                  height: 52,
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
        
                SizedBox(height: 24,),
                //Konfirmasi Password
                Padding(
                  padding: EdgeInsets.only(left: 27, right: 19),
                  child: SizedBox(
                    width: 354,
                    height: 52,
                    child: TextField(
                      controller: _confirmPasswordController,//Controller
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        hintText: "Konfirmasi Password",
                        hintStyle: TextStyle(
                          color: Color(0xffC0C0C0),
                        ),
        
                          //konfirmasi password
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: _isObscure ? Color(0xffC0C0C0) : Colors.black,
                          ),
                          onPressed: (){
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }, ),
        
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
        
                SizedBox(height: 24,),
                  // Button Register
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
                      onPressed: _registerUser, //Fungsi register
                      child: Text("Register",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                      ),
                  ),
                ),
        
                SizedBox(height: 110,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sudah punya akun? silahkan",
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      color: Colors.black),
                    ),
        
                    //Navigasi ke halaman Login
                    GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  LoadingTransition(
                        nextPage: Login(),
                      ),
                      ),
                    );
                  },
                  child: Text(
                    " Login",
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Color(0xff3498DB), // Warna biru tema
                    ),
                  ),
                ),
              ],
            ),
        SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}