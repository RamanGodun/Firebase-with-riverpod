import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/profile/domain_data/_profile_repository.dart';
import '../../../features/profile/domain_data/profile_repository_provider.dart';
import '../../../features/auth/_domain_data/auth_repository_providers.dart';

/// 📦 [diContainer] — global list of manually maintained providers
/// 🧼 Used in `ProviderScope(overrides: [...])` or just imported once
/// 🔧 Centralized registration of manual providers for Domain and Data layers
/// Analog of GetIt DI Container for Riverpod-based apps
//-----------------------------------------------------------
final List<Override> diContainer = [
  // Domain & Data layer providers
  profileRepositoryProvider.overrideWith((ref) => ProfileRepository()),

  profileRepositoryProvider, // ? or when use codegeneration
  authRepositoryProvider,

  // ...
  //Add more manual providers here as needed
  //

  //
];
