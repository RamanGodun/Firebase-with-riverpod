import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/auth/data_providers/change_password_repo_provider.dart';
import '../../../features/auth/data_providers/email_verification_repo_provider.dart';
import '../../../features/auth/data_providers/sign_in_repo_provider.dart';
import '../../../features/auth/data_providers/sign_out_repo_provider.dart';
import '../../../features/auth/data_providers/sign_up_repo_provider.dart';
import '../../../features/auth/data_providers/reset_password_repo_provider.dart';
import '../../../features/profile/domain_and_data/profile_repo_provider.dart';
import '../../../features/profile/domain_and_data/remote_data_source.dart';
import '../../shared_modules/theme/provider_and_toggle_widget/theme_provider.dart';

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

  ///
  themeStorageProvider.overrideWith((ref) => GetStorage()),
  themeModeProvider.overrideWith(
    (ref) => ThemeModeNotifier(ref.watch(themeStorageProvider)),
  ),
  // ...
];
