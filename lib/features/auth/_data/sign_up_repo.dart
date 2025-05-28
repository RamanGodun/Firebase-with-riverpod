// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import '../../../../core/config/firebase/firebase_constants.dart';

// part 'sign_up_repo.g.dart';

// @riverpod
// IAuthRepo authRepo(Ref ref) => AuthRepoImpl();

// abstract interface class IAuthRepo {
//   Future<void> signup({
//     required String name,
//     required String email,
//     required String password,
//   });
// }

// final class AuthRepoImpl implements IAuthRepo {
//   @override
//   Future<void> signup({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     final userCredential = await fbAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     final user = userCredential.user!;
//     await usersCollection.doc(user.uid).set({'name': name, 'email': email});
//   }
// }
