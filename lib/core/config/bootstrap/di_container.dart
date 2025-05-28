import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/auth/_data/sign_in_repo.dart';
import '../../../features/auth/_data/sign_up_repo.dart';
import '../../../features/profile/domain_and_data/profile_repo_provider.dart';
import '../../../features/profile/domain_and_data/remote_data_source.dart';

/// 📦 [diContainer] — global list of manually maintained providers
/// 🧼 Used in `ProviderScope(overrides: [...])` or just imported once
/// 🔧 Centralized registration of manual providers for Domain and Data layers
/// Analog of GetIt DI Container for Riverpod-based apps
//-----------------------------------------------------------
final List<Override> diContainer = [
  profileRepoProvider.overrideWith(
    (ref) => ProfileRepoImpl(ProfileRemoteDataSourceImpl()),
  ),

  signInRepoProvider.overrideWith((ref) => SignInRepoImpl()),
  signUpRepoProvider.overrideWith((ref) => SignUpRepoImpl()),

  // ...
];
