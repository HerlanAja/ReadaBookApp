import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:frontend/utils/color.dart';
import 'package:frontend/screens/home/home_page.dart';
import 'package:frontend/providers/auth_provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: defaultBackgroundColor, // Background utama halaman
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        backgroundColor: defaultBackgroundColor,
        elevation: 0, // Menghapus bayangan pada AppBar
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: authProvider.form, // Gunakan form dari AuthProvider
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gambar bagian atas
                Image.asset(
                  'assets/signup.jpeg', // Sesuaikan path gambar
                  height: MediaQuery.of(context).size.height * 0.3,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                // Judul "Create Account"
                Text(
                  'Create Account',
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 10),

                // Subjudul
                Text(
                  'Sign up to start your journey.',
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Input field untuk email
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: defaultBackgroundColor,
                    labelText: 'Email',
                    labelStyle: GoogleFonts.poppins(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.email, color: primaryColor),
                  ),
                  onSaved: (value) => authProvider.enteredEmail = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Masukkan email yang valid.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Input field untuk password
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: defaultBackgroundColor,
                    labelText: 'Password',
                    labelStyle: GoogleFonts.poppins(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: primaryColor),
                  ),
                  onSaved: (value) =>
                      authProvider.enteredPassword = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Password harus lebih dari 6 karakter.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Tombol Register
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: authProvider.isLoading
                        ? null
                        : () async {
                            // Jalankan proses registrasi
                            await authProvider.submit();
                            if (authProvider.errorMessage == null) {
                              // Jika berhasil, arahkan ke HomePage
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                              authProvider.resetForm(); // Reset form
                            } else {
                              // Jika gagal, tampilkan pesan error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(authProvider.errorMessage!),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: authProvider.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Register',
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),

                // Teks untuk kembali ke halaman login
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                  child: Text(
                    'Already have an account? Log in.',
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
