import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/auth/data/change_password_repo.dart';
import '../../../features/auth/data/email_verification_repo.dart';
import '../../../features/auth/data/sign_in_repo.dart';
import '../../../features/auth/data/sign_out_repo.dart';
import '../../../features/auth/data/sign_up_repo.dart';
import '../../../features/auth/data/reset_password_repo.dart';
import '../../../features/profile/domain_and_data/profile_repo_provider.dart';
import '../../../features/profile/domain_and_data/remote_data_source.dart';

/// 📦 [diContainer] — global list of manually maintained providers
/// 🧼 Used in `ProviderScope(overrides: [...])` or just imported once
/// 🔧 Centralized registration of manual providers for Domain and Data layers
//-----------------------------------------------------------
final List<Override> diContainer = [
  ///
  signInRepoProvider.overrideWith((ref) => SignInRepoImpl()),
  signUpRepoProvider.overrideWith((ref) => SignUpRepoImpl()),
  signOutRepoProvider.overrideWith((ref) => SignOutRepoImpl()),

  changePasswordRepoProvider.overrideWith((ref) => ChangePasswordRepoImpl()),
  resetPasswordRepoProvider.overrideWith((ref) => ResetPasswordRepoImpl()),

  emailVerificationRepoProvider.overrideWith(
    (ref) => EmailVerificationRepoImpl(),
  ),

  profileRepoProvider.overrideWith(
    (ref) => ProfileRepoImpl(ProfileRemoteDataSourceImpl()),
  ),

  // ...
];
