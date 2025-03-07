import 'package:clean_ease/features/auth/presentation/view/register.dart';
import 'package:clean_ease/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:clean_ease/features/auth/presentation/view_model/signup/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_test.mocks.dart';

@GenerateMocks([RegisterBloc])
void main() {
  late MockRegisterBloc mockRegisterBloc;

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();

    when(mockRegisterBloc.stream).thenAnswer(
      (_) => Stream.value(
        const RegisterState(
          isLoading: false,
          isSuccess: false,
          errorMessage: '',
          isOtpSent: false,
          isOtpVerified: false,
        ),
      ),
    );

    when(mockRegisterBloc.state).thenReturn(
      const RegisterState(
        isLoading: false,
        isSuccess: false,
        errorMessage: '',
        isOtpSent: false,
        isOtpVerified: false,
      ),
    );
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<RegisterBloc>(
        create: (_) => mockRegisterBloc,
        child: const Register(),
      ),
    );
  }

  group('Register Page Tests', () {
    testWidgets("Displays 'Sign Up' button", (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.widgetWithText(ElevatedButton, "Sign Up"), findsOneWidget);
    });

    testWidgets("Displays 'Full Name' text field", (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.widgetWithText(TextFormField, "Full Name"), findsOneWidget);
    });

    testWidgets("Displays 'Already have an account? Signin' message",
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(
          find.byWidgetPredicate((widget) =>
              widget is RichText &&
              widget.text.toPlainText().contains("Already have an account?")),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is RichText &&
              widget.text.toPlainText().contains("Signin")),
          findsOneWidget);
    });
  });
}
