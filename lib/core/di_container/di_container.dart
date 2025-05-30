import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import '../../features/auth/data_providers/change_password_repo_provider.dart';
import '../../features/auth/data_providers/email_verification_repo_provider.dart';
import '../../features/auth/data_providers/sign_in_repo_provider.dart';
import '../../features/auth/data_providers/sign_out_repo_provider.dart';
import '../../features/auth/data_providers/sign_up_repo_provider.dart';
import '../../features/auth/data_providers/reset_password_repo_provider.dart';
import '../../features/profile/domain_and_data/profile_repo_provider.dart';
import '../../features/profile/domain_and_data/remote_data_source.dart';
import '../shared_modules/overlays/overlay_dispatcher/_overlay_dispatcher.dart';
import '../shared_modules/overlays/overlay_dispatcher/dispatcher_provider.dart';
import '../shared_modules/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import '../shared_modules/theme/provider_and_toggle_widget/theme_provider.dart';

/// 🌍 Global singleton DI container
/// ───────────────────────────────────────
late final ProviderContainer globalContainer;
// ✅ Used both inside the widget tree (`ProviderScope.parent`)
// ✅ And outside context (e.g., background logic, isolate, utilities)
// 🧩 Instantiated once during bootstrap: `StartUpHandler._initDI()`

///

/// 📦 [diContainer] — global list of manually maintained providers
//----------------------------------------------------------------
final List<Override> diContainer = [
  // 🧼 Used in `ProviderScope(overrides: [...])` or just imported once
  // 🔧 Centralized registration of manual providers for Domain and Data layers

  /// ── Auth Repositories ───

  // Handles email/password sign-in
  signInRepoProvider.overrideWith((ref) => SignInRepoImpl()),
  // Handles user registration
  signUpRepoProvider.overrideWith((ref) => SignUpRepoImpl()),
  // Handles user sign-out
  signOutRepoProvider.overrideWith((ref) => SignOutRepoImpl()),
  // Changes user password
  changePasswordRepoProvider.overrideWith((ref) => ChangePasswordRepoImpl()),
  // Sends reset link to email
  resetPasswordRepoProvider.overrideWith((ref) => ResetPasswordRepoImpl()),
  // Sends verification email
  emailVerificationRepoProvider.overrideWith(
    (ref) => EmailVerificationRepoImpl(),
  ),

  /// ── Profile Layer ───

  // Fetches and updates user profile data
  profileRepoProvider.overrideWith(
    (ref) => ProfileRepoImpl(ProfileRemoteDataSourceImpl()),
  ),

  /// ── Theme Management ───

  // Persists theme mode
  themeStorageProvider.overrideWith((ref) => GetStorage()),
  // Controls current theme mode
  themeModeProvider.overrideWith(
    (ref) => ThemeModeNotifier(ref.watch(themeStorageProvider)),
  ),

  /// ── Overlay System ───

  // Handles showing/hiding overlays
  overlayDispatcherProvider.overrideWith(
    (ref) => OverlayDispatcher(
      onOverlayStateChanged: ref.read(overlayStatusProvider.notifier).update,
    ),
  ),

  // ...
];
