import 'package:flutter_test/flutter_test.dart';

import 'package:quran/main.dart';

void main() {
  testWidgets('App renders Surah list', (WidgetTester tester) async {
    await tester.pumpWidget(const QuranApp());

    expect(find.text('Surah'), findsOneWidget);
    expect(find.text('Al-Fatihah'), findsOneWidget);
  });
}
