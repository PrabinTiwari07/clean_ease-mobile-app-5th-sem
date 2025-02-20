import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../domain/entity/profile_entity.dart';
import '../../domain/use_case/change_password_use_case.dart';
import '../../domain/use_case/get_profile_use_case.dart';
import '../../domain/use_case/logout_use_case.dart';
import '../../domain/use_case/update_profile_use_case.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final LogoutUseCase logoutUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.changePasswordUseCase,
    required this.logoutUseCase,
  }) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await getProfileUseCase();
        emit(ProfileLoaded(profile: profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        await updateProfileUseCase(event.profile);
        emit(ProfileUpdated());
        final updatedProfile = await getProfileUseCase();
        emit(ProfileLoaded(profile: updatedProfile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<ChangePassword>((event, emit) async {
      emit(ProfileLoading());
      try {
        await changePasswordUseCase(event.oldPassword, event.newPassword);
        emit(PasswordChanged());
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<Logout>((event, emit) async {
      await logoutUseCase();
      emit(ProfileLoggedOut());
    });
  }
}
