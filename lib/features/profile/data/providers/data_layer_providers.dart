import 'package:cloud_firestore/cloud_firestore.dart'
    show CollectionReference, FirebaseFirestore;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/utils_shared/user_auth/firebase_auth_providers.dart';
import '../../domain/repo_contract.dart';
import '../implementation_of_profile_fetch_repo.dart';
import '../remote_database_contract.dart';
import '../remote_database_impl.dart';

part 'data_layer_providers.g.dart';

/// 🗃️ [usersCollectionProvider] — Firestore users collection reference
/// ✅ Provides access to the `users` collection for remote profile operations
//
@riverpod
CollectionReference<Map<String, dynamic>> usersCollection(Ref ref) =>
    FirebaseFirestore.instance.collection('users');

////
////

/// 🧩 [profileRepoProvider] — provides instance of [ProfileRepoImpl]
/// 🧠 Injects [IProfileRemoteDatabase] from [profileRemoteDataSourceProvider]
/// ✅ Adds caching, failure mapping, and DTO → Entity conversion
//
@riverpod
IProfileRepo profileRepo(Ref ref) {
  final remote = ref.watch(profileRemoteDataSourceProvider);
  return ProfileRepoImpl(remote);
}

////
////

/// 🔌 [profileRemoteDataSourceProvider] — provides instance of [ProfileRemoteDatabaseImpl]
/// 🧱 Handles direct Firestore access for fetching or creating user profile
//
@riverpod
IProfileRemoteDatabase profileRemoteDataSource(Ref ref) {
  final usersCollection = ref.watch(usersCollectionProvider);
  final fbAuth = ref.watch(firebaseAuthProvider);
  return ProfileRemoteDatabaseImpl(usersCollection, fbAuth);
}
