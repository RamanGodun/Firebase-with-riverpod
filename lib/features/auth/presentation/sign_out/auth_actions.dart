import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/failures_for_domain_and_presentation/to_ui_failures_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/utils/result_notifiers/result_notifier_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../profile/domain_and_data/profile_repo_provider.dart';
import '../../data_providers/sign_out_repo_provider.dart';
import '../../domain/auth_use_cases.dart';

/// 🧩 [AuthActions] — utility class for sign-out UI logic
/// ✅ Handles logout, overlay error, GoRouter redirect, cache cleanup
/// ─────────────────────────────────────────────────────────────────────
final class AuthActions {
  const AuthActions._();

  static Future<void> signOut({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    await ref.runVoid(
      SignOutUseCase(ref.read(signOutRepoProvider))(),
      onFailure: (f) => context.showError(f.toUIModel()),
      onSuccess: () {}, // GoRouter handles redirect automatically
    );

    ref.read(profileRepoProvider).clearCache();
  }
}
