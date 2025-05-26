// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../features/auth/data/auth_repo_impl.dart';
// import '../features/auth/domain/use_cases/sign_in_use_case.dart';
// import '../features/auth/domain/auth_repo.dart';
// import '../features/auth/data/remote_data_source_impl.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../data/auth/_auth_repository.dart';

// final remoteDataSourceProvider = Provider((ref) => AuthRemoteDataSourceImpl(...));
// final authRepoProvider = Provider<AuthRepo>((ref) => AuthRepoImpl(ref.read(remoteDataSourceProvider)));
// final signInUseCaseProvider = Provider((ref) => SignInUseCase(ref.read(authRepoProvider)));

// final authRepositoryProvider = Provider<AuthRepository>((ref) {
//   return AuthRepositoryImpl();
// });

// Провайдер для SignInUseCase
// final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
//   final authRepository = ref.read(authRepositoryProvider);
//   return SignInUseCase(authRepository);
// });
