import 'package:flutter_test/flutter_test.dart';
import 'package:interntrack_tn/main.dart';

void main() {
  testWidgets('Home page displays correctly', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const InternTrackTN());

    // Verify greeting text appears
    expect(find.text('Good morning, Amal 👋'), findsOneWidget);
    expect(find.text('Ready to find your next opportunity?'), findsOneWidget);

    // Verify statistics cards exist
    expect(find.text('12'), findsWidgets); // Applications count
    expect(find.text('4'), findsWidgets); // Interviews count

    // Verify bottom navigation exists
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Applications'), findsWidgets);
    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
