import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/firebase/firebase_constants.dart';

part 'sign_out_repo.g.dart';

@riverpod
ISignOutRepo signOutRepo(Ref ref) => SignOutRepoImpl();

abstract interface class ISignOutRepo {
  Future<void> signOut();
}

final class SignOutRepoImpl implements ISignOutRepo {
  @override
  Future<void> signOut() async {
    await fbAuth.signOut();
  }
}