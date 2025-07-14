import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// import '../../../utils_shared/stream_change_notifier.dart'
// show StreamChangeNotifier;

/// 🧩 [authStateStreamProvider] — Riverpod [StreamProvider] for Firebase user changes
/// ✅ Emits a new [User?] on every authentication state change
/// 🧼 Used for reactive auth flows and route protection

final authStateStreamProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.userChanges();
});

