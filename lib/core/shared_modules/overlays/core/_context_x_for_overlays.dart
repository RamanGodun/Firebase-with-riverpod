import 'package:firebase_with_riverpod/core/di_container/di_context_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/overlays/core/_overlay_base_methods.dart';
import 'package:flutter/material.dart';
import '../../errors_handling/failures/failure_ui_entity.dart';
import '../../localization/code_base_for_both_options/_app_localizer.dart';
import '../../localization/generated/locale_keys.g.dart';
import '../overlays_dispatcher/_overlay_dispatcher.dart';
import '../overlays_dispatcher/overlay_dispatcher_provider.dart'
    show overlayDispatcherProvider;
import '../overlays_presentation/overlay_presets/overlay_presets.dart';
import 'enums_for_overlay_module.dart';

/// 🎯 [ContextXForOverlays] — Unified extension for overlay DSL and dispatcher access
/// ✅ Use `context.showSnackbar(...)` / `context.showBanner(...)` directly

extension ContextXForOverlays on BuildContext {
  //------------------------------------------

  /// 🔌 Lazily access the shared [IOverlayDispatcher] via DI container
  OverlayDispatcher get dispatcher => readDI(overlayDispatcherProvider);

  /// 🧠 Handles displaying [FailureUIEntity] as banner/snackbar/dialog
  /// 📌 Uses [OverlayUIPresets] and [ShowAs] to configure appearance and behavior
  void showError(
    FailureUIEntity model, {
    ShowAs showAs = ShowAs.infoDialog,
    OverlayUIPresets preset = const OverlayErrorUIPreset(),
    bool isDismissible = false,
    OverlayPriority priority = OverlayPriority.high,
  }) {
    //

    switch (showAs) {
      case ShowAs.banner:
        showBanner(
          message: model.localizedMessage,
          icon: model.icon,
          preset: preset,
          isError: true,
          isDismissible: isDismissible,
          priority: priority,
        );
        break;
      //
      case ShowAs.snackbar:
        showSnackbar(
          message: model.localizedMessage,
          preset: preset,
          isError: true,
          icon: model.icon,
          isDismissible: isDismissible,
          priority: priority,
        );
        break;
      //
      case ShowAs.dialog:
        showAppDialog(
          title: AppLocalizer.t(LocaleKeys.errors_errors_general_title),
          content: model.localizedMessage,
          confirmText: AppLocalizer.t(LocaleKeys.buttons_ok),
          cancelText: AppLocalizer.t(LocaleKeys.buttons_cancel),
          preset: preset,
          isError: true,
          isDismissible: isDismissible,
          priority: priority,
        );
        break;
      //
      case ShowAs.infoDialog:
        showAppDialog(
          isInfoDialog: true,
          title: AppLocalizer.t(LocaleKeys.errors_errors_general_title),
          content: model.localizedMessage,
          confirmText: AppLocalizer.t(LocaleKeys.buttons_ok),
          cancelText: AppLocalizer.t(LocaleKeys.buttons_cancel),
          preset: preset,
          isError: false,
          isDismissible: isDismissible,
          priority: priority,
        );
        break;
      //
    }
  }

  /// 💬 Shows a platform-adaptive dialog manually triggered by user
  void showUserDialog({
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isDismissible = true,
    bool isInfoDialog = false,
  }) {
    showAppDialog(
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      preset: preset,
      isError: false,
      isDismissible: isDismissible,
      isInfoDialog: isInfoDialog,
      priority: OverlayPriority.userDriven,
    );
  }

  /// 🪧 Shows a banner overlay triggered manually by user
  void showUserBanner({
    required String message,
    IconData? icon,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isDismissible = true,
  }) {
    showBanner(
      message: message,
      icon: icon,
      preset: preset,
      isError: false,
      isDismissible: isDismissible,
      priority: OverlayPriority.userDriven,
    );
  }

  /// 💬 Shows a platform-adaptive snackbar manually triggered by user
  void showUserSnackbar({
    required String message,
    IconData? icon,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    OverlayPriority priority = OverlayPriority.userDriven,
  }) {
    showSnackbar(
      message: message,
      icon: icon,
      preset: preset,
      isError: false,
      isDismissible: true,
      priority: priority,
    );
  }

  //
}
