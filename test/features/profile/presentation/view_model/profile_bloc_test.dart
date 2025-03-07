import 'package:bloc_test/bloc_test.dart';
import 'package:clean_ease/features/profile/domain/entity/profile_entity.dart';
import 'package:clean_ease/features/profile/domain/use_case/get_profile_use_case.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_event.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_bloc_test.mocks.dart';

@GenerateMocks([GetProfileUseCase])
void main() {
  late ProfileBloc profileBloc;
  late MockGetProfileUseCase mockGetProfileUseCase;

  final fakeProfile = ProfileEntity(
    id: '123',
    fullname: 'Kisame Hoshigake',
    email: 'kisame@gmail.com',
    phone: '1234567890',
    image: 'https://example.com/samehada.jpg',
    address: 'Mist',
  );

  const failureMessage = "Failed to load user data";

  setUp(() {
    mockGetProfileUseCase = MockGetProfileUseCase();
    profileBloc = ProfileBloc(getProfileUseCase: mockGetProfileUseCase);
  });

  tearDown(() {
    profileBloc.close();
  });

  group('ProfileBloc', () {
    test('Initial state should be ProfileInitial', () {
      expect(profileBloc.state, ProfileInitial());
    });

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoading, ProfileLoaded] when LoadProfile succeeds',
      build: () {
        when(mockGetProfileUseCase()).thenAnswer((_) async => fakeProfile);
        return profileBloc;
      },
      act: (bloc) => bloc.add(LoadProfile()),
      expect: () => [
        ProfileLoading(),
        ProfileLoaded(profile: fakeProfile),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoading, ProfileError] when LoadProfile fails',
      build: () {
        when(mockGetProfileUseCase()).thenThrow(Exception(failureMessage));
        return profileBloc;
      },
      act: (bloc) => bloc.add(LoadProfile()),
      expect: () => [
        ProfileLoading(),
        ProfileError("Failed to load user: Exception: $failureMessage"),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'handles multiple LoadProfile events correctly',
      build: () {
        when(mockGetProfileUseCase()).thenAnswer((_) async => fakeProfile);
        return profileBloc;
      },
      act: (bloc) async {
        bloc.add(LoadProfile());
        bloc.add(LoadProfile());
      },
      expect: () => [
        ProfileLoading(),
        ProfileLoaded(profile: fakeProfile),
        ProfileLoading(),
        ProfileLoaded(profile: fakeProfile),
      ],
    );
  });
}
