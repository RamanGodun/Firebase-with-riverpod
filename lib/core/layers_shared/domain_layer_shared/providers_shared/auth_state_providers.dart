import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils_shared/stream_change_notifier.dart'
    show StreamChangeNotifier;

/// 🧩 [authStateStreamProvider] — Riverpod [StreamProvider] for Firebase user changes
/// ✅ Emits a new [User?] on every authentication state change
/// 🧼 Used for reactive auth flows and route protection

final authStateStreamProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.userChanges();
});

////

////

/// 🔄 [authStateRefreshListenableProvider] — Provides [ChangeNotifier] for GoRouter's refreshListenable
/// ✅ Bridges Firebase [User] stream to GoRouter refresh mechanism
/// 🧼 Ensures router re-evaluates routes whenever auth state changes

final authStateRefreshListenableProvider = Provider<ChangeNotifier>((ref) {
  ///
  // 🟢 Watch the [authStateStreamProvider] stream for updates
  final stream = ref.watch(authStateStreamProvider.stream);
  // 🔔 Create a notifier to bridge the stream for imperative listeners (GoRouter)
  return StreamChangeNotifier(stream);
  //
});
