import 'package:flutter/material.dart';
import '../shared_modules/errors_handling/either/either.dart';
import '../shared_modules/errors_handling/failures/failure_entity.dart';
import '../shared_modules/errors_handling/failures/failure_ui_entity.dart';
import '../shared_modules/errors_handling/utils/for_bloc/result_handler.dart';
import '../shared_modules/overlays/overlays_presentation/overlay_presets/overlay_presets.dart';

/// 🧩 [ResultFuture] — Represents async result with [Either<Failure, T>]
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// 🧩 [ResultFuture] — Represents async result with `Either<Failure, T>`
typedef DataMap = Map<String, dynamic>;

/// 🧰 [Result<T>] — Generic result handler wrapper
typedef Result<T> = ResultHandler<T>;

/// 📤 [SubmitCallback] — Button or form submission callback
typedef SubmitCallback = void Function(BuildContext context);

/// 🛑 [ExceptionHandler] — Maps exception to a typed [Failure]
typedef ExceptionHandler = Failure Function(dynamic error);

/// 🧾 [FieldUiState] — Compact record for field visibility & error display
typedef FieldUiState = ({String? errorText, bool isObscure});

/// 📦 Wraps child with EasyLocalization widget
typedef LocalizationWrapper = Widget Function(Widget child);

/// 📦 Navigation with params
typedef GoTo =
    void Function(
      String routeName, {
      Map<String, String> pathParameters,
      Map<String, dynamic> queryParameters,
    });

/// 🪧 [OverlayBannerFactory] — builds a custom banner for overlay display
/// Used to render UI based on overlay presets
typedef OverlayBannerFactory = Widget Function(OverlayUIPresets, String);

/// 💬 [ShowUserSnackbar] — displays a snackbar with optional icon
/// Commonly used for user feedback and UI actions
typedef ShowUserSnackbar =
    void Function({required String message, IconData? icon});

/// ❗ [ErrorDispatcher] — handles UI error display via [FailureUIEntity]
/// Passes context-bound error handler (e.g., `context.showError`)
typedef ErrorDispatcher = void Function(FailureUIEntity);
