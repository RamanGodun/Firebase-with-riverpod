import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/auth/sign_in/domain_and_data/sign_in_repo.dart';
import '../../../features/profile/domain_and_data/profile_repo_provider.dart';
import '../../../features/profile/domain_and_data/remote_data_source.dart';

/// 📦 [diContainer] — global list of manually maintained providers
/// 🧼 Used in `ProviderScope(overrides: [...])` or just imported once
/// 🔧 Centralized registration of manual providers for Domain and Data layers
/// Analog of GetIt DI Container for Riverpod-based apps
//-----------------------------------------------------------
final List<Override> diContainer = [
  // Domain & Data layer providers
  profileRepoProvider.overrideWith(
    (ref) => ProfileRepoImpl(ProfileRemoteDataSourceImpl()),
  ),

  authRepoProvider.overrideWith((ref) => AuthRepoImpl()),

  // ...
  //Add more manual providers here as needed
  //

  //
];
