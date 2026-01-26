import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> callPhone() async {
  final Uri phoneUri = Uri.parse('tel: ');

  await launchUrl(
    phoneUri,
    mode: LaunchMode.externalApplication,
  );
}

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: Colors.black87,
            ),
          ),
        ),
      ),
      title: const Text(
        'About Me',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 232, 233, 236),
      elevation: 0,
      ),

      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // background biar logo lega
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              
              child: ClipOval(
                child: Padding(
                  padding: const EdgeInsets.all(25), // jarak biar tidak mepet
                  child: Image.asset(
                    "assets/images/logo1.png",
                    fit: BoxFit.contain, // PENTING: tidak terpotong
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),
          Text(
            "PM News",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text("Ulasan tentang aplikasi"),
          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "PM News adalah aplikasi mobile berita yang saya bangun untuk menyajikan informasi terkini secara cepat, akurat, dan mudah diakses. "
              "Aplikasi ini dirancang agar pengguna dapat membaca berita terbaru kapan saja melalui tampilan yang sederhana, ringan, dan nyaman digunakan. "
              "Saya berkomitmen menghadirkan berita yang relevan, terpercaya, dan terus diperbarui setiap hari.",
              textAlign: TextAlign.justify,
            ),
          ),

          SizedBox(height: 30),

          Row(
            children: [
              SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Service Contact",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),

                  Row(
                    children: [
                      Icon(Icons.phone_rounded, size: 20),
                      SizedBox(width: 10),
                      Text("+62 823-XXX-XXX"),
                    ],
                  ),
                  SizedBox(height: 15),

                  Row(
                    children: [
                      Icon(Icons.public, size: 20),
                      SizedBox(width: 10),
                      Text("pmnews.com"),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 60),

         ElevatedButton.icon(
            onPressed: callPhone,
            icon: Icon(Icons.phone),
            label: Text(
              "Hubungi Saya",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 6,
            ),
          ),

        ],
      ),
    );
  }
}
