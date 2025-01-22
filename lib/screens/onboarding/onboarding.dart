import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/utils/color.dart';
import 'package:frontend/utils/onboarding_data.dart';
import 'package:frontend/screens/auth/login.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = OnboardingData();
  final pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      body: Column(
        children: [
          body(size, isPortrait),
          buildDots(),
          button(size),
        ],
      ),
    );
  }

  // Body
  Widget body(Size size, bool isPortrait) {
    return Expanded(
      child: Center(
        child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Images
                  Image.asset(
                    controller.items[currentIndex].image,
                    height: isPortrait ? size.height * 0.35 : size.height * 0.5,
                    width: size.width * 0.8,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: size.height * 0.02),
                  // Titles
                  Text(
                    controller.items[currentIndex].title,
                    style: GoogleFonts.poppins(
                      fontSize: isPortrait ? size.width * 0.06 : size.width * 0.04,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Description
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Text(
                      controller.items[currentIndex].description,
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: isPortrait ? size.width * 0.04 : size.width * 0.03,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Dots
  Widget buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.items.length,
        (index) => AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: currentIndex == index ? primaryColor : Colors.grey,
          ),
          height: 7,
          width: currentIndex == index ? 30 : 7,
          duration: const Duration(milliseconds: 700),
        ),
      ),
    );
  }

  // Button
  Widget button(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
      width: size.width * 0.9,
      height: size.height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: primaryColor,
      ),
      child: TextButton(
        onPressed: () {
          if (currentIndex == controller.items.length - 1) {
            // Navigasi ke halaman login
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          } else {
            setState(() {
              currentIndex++;
            });
          }
        },
        child: Text(
          currentIndex == controller.items.length - 1 ? "Get Started" : "Continue",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: size.width * 0.045,
          ),
        ),
      ),
    );
  }
}
