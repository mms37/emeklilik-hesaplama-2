import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emeklilikhesap/main.dart'; // <-- Proje adınıza göre düzenleyin

void main() {
  testWidgets('Emeklilik yaşını doğru şekilde hesaplıyor mu', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final ageTextFieldFinder = find.byKey(ValueKey('age_field'));
    final workDaysTextFieldFinder = find.byKey(ValueKey('work_days_field'));
    final contributionDaysTextFieldFinder = find.byKey(ValueKey('contribution_days_field'));
    final calculateButtonFinder = find.text('Emeklilik Yaşı Hesapla');

    expect(ageTextFieldFinder, findsOneWidget);
    expect(workDaysTextFieldFinder, findsOneWidget);
    expect(contributionDaysTextFieldFinder, findsOneWidget);
    expect(calculateButtonFinder, findsOneWidget);

    await tester.enterText(ageTextFieldFinder, '30'); // Test için yaş girin
    await tester.enterText(workDaysTextFieldFinder, '10'); // Test için çalışma gün sayısı girin
    await tester.enterText(contributionDaysTextFieldFinder, '3000'); // Test için prim günü girin

    await tester.tap(calculateButtonFinder);
    await tester.pump();

    final resultTextFinder = find.text('Emekli olmak için 30 yılınız var.\n'
        'Kalan Çalışma Günü: 13050\n'
        'Kalan Prim Günü: 4200');
    expect(resultTextFinder, findsOneWidget);
  });

  testWidgets('Yetersiz prim günü için uygun mesaj veriyor mu', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final ageTextFieldFinder = find.byKey(ValueKey('age_field'));
    final workDaysTextFieldFinder = find.byKey(ValueKey('work_days_field'));
    final contributionDaysTextFieldFinder = find.byKey(ValueKey('contribution_days_field'));
    final calculateButtonFinder = find.text('Emeklilik Yaşı Hesapla');

    expect(ageTextFieldFinder, findsOneWidget);
    expect(workDaysTextFieldFinder, findsOneWidget);
    expect(contributionDaysTextFieldFinder, findsOneWidget);
    expect(calculateButtonFinder, findsOneWidget);

    await tester.enterText(ageTextFieldFinder, '50'); // Test için yaş girin
    await tester.enterText(workDaysTextFieldFinder, '15'); // Test için çalışma gün sayısı girin
    await tester.enterText(contributionDaysTextFieldFinder, '3000'); // Test için prim günü girin

    await tester.tap(calculateButtonFinder);
    await tester.pump();

    final resultTextFinder = find.text('Emekli olmak için yeterli şartları sağlamıyorsunuz.');
    expect(resultTextFinder, findsOneWidget);
  });
}
