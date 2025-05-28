// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import '../../../../core/config/firebase/firebase_constants.dart';

// part 'sign_in_repo.g.dart';

// /// 🔐 Sign in repo provider
// @riverpod
// IAuthRepo authRepo(Ref ref) => AuthRepoImpl();

// /// 🔐 Sign in contract
// abstract interface class IAuthRepo {
//   Future<void> signIn({required String email, required String password});
// }

// /// 🔐 Signs user in using email and password
// final class AuthRepoImpl implements IAuthRepo {
//   @override
//   Future<void> signIn({required String email, required String password}) async {
//     await fbAuth.signInWithEmailAndPassword(email: email, password: password);
//   }
// }
