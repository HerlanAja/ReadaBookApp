import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/utils/constants.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:frontend/screens/auth/login.dart'; 

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  // Fungsi logout
  Future<void> _logout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      try {
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()), 
        );
      } catch (e) {
        // Tangani kesalahan logout di sini
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor, 
      appBar: AppBar(
        title: Text(
          'Profil',
          style: GoogleFonts.poppins(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: largePadding),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: secondaryColor.withOpacity(0.2),
                    backgroundImage: const NetworkImage(
                      'https://via.placeholder.com/150', // Ganti URL ini dengan foto profil pengguna
                    ),
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: primaryColor,
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: largePadding),
            // Nama
            Row(
              children: [
                const Icon(Icons.person, color: primaryColor),
                const SizedBox(width: smallPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama',
                      style: GoogleFonts.poppins(
                        fontSize: defaultFontSize,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Ujang Herlan',
                      style: GoogleFonts.poppins(
                        fontSize: defaultFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // Aksi edit nama
                  },
                  icon: const Icon(Icons.edit, color: primaryColor),
                ),
              ],
            ),
            const Divider(),
            // Info
            Row(
              children: [
                const Icon(Icons.info, color: primaryColor),
                const SizedBox(width: smallPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Info',
                      style: GoogleFonts.poppins(
                        fontSize: defaultFontSize,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Nothing',
                      style: GoogleFonts.poppins(
                        fontSize: defaultFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // Aksi edit info
                  },
                  icon: const Icon(Icons.edit, color: primaryColor),
                ),
              ],
            ),
            const Divider(),
            // Telepon
            Row(
              children: [
                const Icon(Icons.phone, color: primaryColor),
                const SizedBox(width: smallPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Telepon',
                      style: GoogleFonts.poppins(
                        fontSize: defaultFontSize,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '+62 858-4653-7024',
                      style: GoogleFonts.poppins(
                        fontSize: defaultFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            // Logout Icon Button aligned to the left
            Row(
              children: [
                const Icon(Icons.logout, color: primaryColor, size: 30),
                const SizedBox(width: smallPadding),
                TextButton(
                  onPressed: () => _logout(context), // Trigger logout
                  child: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                      fontSize: defaultFontSize,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(), // Tambahkan Divider di bawah bagian logout
          ],
        ),
      ),
    );
  }
}
