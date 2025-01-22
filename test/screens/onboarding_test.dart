import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/screens/onboarding/onboarding.dart';
import 'package:frontend/screens/auth/login.dart';

void main() {
  group('OnboardingPage Widget Tests', () {
    testWidgets('Displays first onboarding item by default', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingPage()));

      // Pastikan halaman pertama ditampilkan
      expect(find.text('Title 1'), findsOneWidget); // Ganti dengan judul slide pertama
      expect(find.text('Description 1'), findsOneWidget); // Ganti dengan deskripsi slide pertama
    });

    testWidgets('Navigates to the next page when "Continue" is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingPage()));

      // Tekan tombol "Continue"
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Pastikan halaman kedua ditampilkan
      expect(find.text('Title 2'), findsOneWidget); // Ganti dengan judul slide kedua
      expect(find.text('Description 2'), findsOneWidget); // Ganti dengan deskripsi slide kedua
    });

    testWidgets('Navigates to login page on "Get Started"', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingPage()));

      // Pindah ke halaman terakhir
      for (int i = 0; i < 2; i++) { // Sesuaikan jumlah halaman
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();
      }

      // Tekan tombol "Get Started"
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Pastikan navigasi ke halaman login
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('Dots update on page change', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingPage()));

      // Pastikan dot pertama aktif
      final firstDot = find.byType(AnimatedContainer).at(0);
      final firstDotSize = tester.getSize(firstDot);
      expect(firstDotSize.width, 30);

      // Tekan tombol "Continue" dan periksa dot berikutnya
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      final secondDot = find.byType(AnimatedContainer).at(1);
      final secondDotSize = tester.getSize(secondDot);
      expect(secondDotSize.width, 30);
    });
  });
}
