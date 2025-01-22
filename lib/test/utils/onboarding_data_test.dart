import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/utils/onboarding_data.dart';
import 'package:frontend/utils/onboardingInfo.dart';

void main() {
  group('OnboardingData Tests', () {
    test('Should contain exactly 3 items', () {
      final onboardingData = OnboardingData();

      // Pastikan jumlah item sesuai
      expect(onboardingData.items.length, 3);
    });

    test('Items should have correct properties', () {
      final onboardingData = OnboardingData();

      // Periksa setiap item untuk memastikan properti sesuai
      for (final item in onboardingData.items) {
        expect(item, isA<OnboardingInfo>());
        expect(item.title.isNotEmpty, true);
        expect(item.description.isNotEmpty, true);
        expect(item.image.isNotEmpty, true);
        expect(item.image.endsWith('.gif'), true); // Pastikan gambar berformat .gif
      }
    });

    test('Specific item properties are correct', () {
      final onboardingData = OnboardingData();
      final firstItem = onboardingData.items[0];

      // Periksa properti item pertama
      expect(firstItem.title, 'Unlimited Questions');
      expect(firstItem.description, 'High qualities questions and quizzes with hundreds of tests');
      expect(firstItem.image, 'assets/onboarding1.gif');
    });
  });
}
