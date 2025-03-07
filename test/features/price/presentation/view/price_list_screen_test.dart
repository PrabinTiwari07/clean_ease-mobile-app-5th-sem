import 'package:clean_ease/features/price/presentation/view/price_list_screen.dart';
import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_bloc.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'price_list_screen_test.mocks.dart';

@GenerateMocks([ServiceBloc])
void main() {
  late MockServiceBloc mockServiceBloc;

  final List<ServiceEntity> fakeServices = [
    ServiceEntity(
      serviceId: '1',
      title: 'Laundry Service',
      category: 'Cleaning',
      price: 15.0,
      description: 'Fast and reliable laundry service',
      image: '/images/laundry.jpg',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    ServiceEntity(
      serviceId: '2',
      title: 'Plumbing Service',
      category: 'Repair',
      price: 50.0,
      description: 'Professional plumbing solutions',
      image: '/images/plumbing.jpg',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  setUp(() {
    mockServiceBloc = MockServiceBloc();

    when(mockServiceBloc.state).thenReturn(ServiceInitial());

    when(mockServiceBloc.stream)
        .thenAnswer((_) => Stream.value(ServiceInitial()));
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<ServiceBloc>.value(
        value: mockServiceBloc,
        child: const PriceListScreen(),
      ),
    );
  }

  group('Price Page Tests', () {
    testWidgets('Displays list of services when loaded',
        (WidgetTester tester) async {
      when(mockServiceBloc.state)
          .thenReturn(ServicesLoaded(services: fakeServices));
      when(mockServiceBloc.stream).thenAnswer(
          (_) => Stream.value(ServicesLoaded(services: fakeServices)));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Laundry Service'), findsOneWidget);
      expect(find.text('\$15.00'), findsOneWidget);
      expect(find.text('Plumbing Service'), findsOneWidget);
      expect(find.text('\$50.00'), findsOneWidget);
    });

    testWidgets('Displays "No services available" when service list is empty',
        (WidgetTester tester) async {
      when(mockServiceBloc.state)
          .thenReturn(ServicesLoaded(services: const []));
      when(mockServiceBloc.stream)
          .thenAnswer((_) => Stream.value(ServicesLoaded(services: const [])));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('No services available'), findsOneWidget);
    });

    testWidgets('Displays error message when state is ServiceError',
        (WidgetTester tester) async {
      when(mockServiceBloc.state)
          .thenReturn(ServiceError(message: 'Error loading services'));
      when(mockServiceBloc.stream).thenAnswer(
          (_) => Stream.value(ServiceError(message: 'Error loading services')));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Error loading services'), findsOneWidget);
    });
  });
}
