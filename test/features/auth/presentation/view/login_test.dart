import 'package:clean_ease/features/auth/presentation/view/login.dart';
import 'package:clean_ease/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_test.mocks.dart';

@GenerateMocks([LoginBloc])
void main() {
  late MockLoginBloc mockLoginBloc;

  setUp(() {
    mockLoginBloc = MockLoginBloc();

    when(mockLoginBloc.stream).thenAnswer((_) =>
        Stream.value(const LoginState(isLoading: false, isSuccess: false)));

    when(mockLoginBloc.state)
        .thenReturn(const LoginState(isLoading: false, isSuccess: false));
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<LoginBloc>(
        create: (_) => mockLoginBloc,
        child: const Login(),
      ),
    );
  }

  group('Login Page Tests', () {
    testWidgets("Displays 'Login' title properly", (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text("Login").first, findsOneWidget);
    });

    testWidgets("Shows validation error when fields are empty",
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.widgetWithText(ElevatedButton, "Login"));
      await tester.pump();

      expect(find.text("Please enter your email"), findsOneWidget);
      expect(find.text("Please enter your password"), findsOneWidget);
    });

    testWidgets("Triggers login when valid credentials are entered",
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(
          find.byType(TextFormField).at(0), "test@email.com");
      await tester.enterText(find.byType(TextFormField).at(1), "password123");

      await tester.tap(find.widgetWithText(ElevatedButton, "Login"));
      await tester.pump();

      verify(mockLoginBloc.add(any)).called(1);
    });

    testWidgets("Toggles 'Remember Me' checkbox", (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final checkboxFinder = find.byType(Checkbox);

      expect(checkboxFinder, findsOneWidget);

      await tester.tap(checkboxFinder);
      await tester.pump();

      await tester.tap(checkboxFinder);
      await tester.pump();
    });
  });
}
