import 'package:flutter_test/flutter_test.dart';
import 'package:islami/main.dart';

void main() {
  testWidgets('shows onboarding on startup', (WidgetTester tester) async {
    await tester.pumpWidget(IslamiApp(isFirstOpen: true));
    await tester.pump();

    expect(find.text('Welcome To Islmi App'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });
}
