import 'package:firebase_with_riverpod/core/base_modules/errors_handling/utils/for_riverpod/show_dialog_when_error_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show HookConsumerWidget;
import '../../../../core/shared_presentation_layer/widgets_shared/buttons/text_button.dart';
import '../../../../core/base_modules/navigation/app_routes/app_routes.dart';
import '../../../../core/base_modules/theme/ui_constants/app_colors.dart';
import '../../../../core/base_modules/form_fields/input_validation/validation_enums.dart';
import '../../../../core/base_modules/form_fields/utils/use_auth_focus_nodes.dart';
import '../../../../core/base_modules/form_fields/widgets/_fields_factory.dart';
import '../../../../core/base_modules/form_fields/widgets/password_visibility_icon.dart';
import '../../../../core/base_modules/localization/widgets/text_widget.dart';
import '../../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../../../core/shared_presentation_layer/widgets_shared/buttons/filled_button.dart';
import '../../../../core/base_modules/theme/ui_constants/_app_constants.dart';
import 'providers/signin_provider.dart';
import 'providers/sign_in_form_fields_provider.dart';
import '../../../../core/utils_shared/extensions/context_extensions/_context_extensions.dart';

part 'widgets_for_sign_in_page.dart';

/// 🔐 [SignInPage] — screen that allows user to sign in.
//
final class SignInPage extends HookConsumerWidget {
  ///-------------------------------------------
  const SignInPage({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final focus = useSignInFocusNodes();

    /// 🧠🔁 Intelligent failure listener (declarative side-effect for error displaying) with optional "Retry" logic.
    ref.listenRetryAwareFailure(
      signInProvider,
      context,
      ref: ref,
      onRetry: () => ref.submit(),
    );

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,

          /// used "LayoutBuilder+ConstrainedBox" pattern
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: FocusTraversalGroup(
                  ///
                  child: ListView(
                    children: [
                      //
                      const _SignInHeader(),
                      _SignInEmailInputField(focus),
                      _SignInPasswordInputField(focus),
                      const _SigninSubmitButton(),
                      const _SigninFooter(),
                      //
                    ],
                  ).withPaddingHorizontal(AppSpacing.xxxm),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  //
}

/// 📩 Handles form validation and submission to [signinProvider].
//
extension SignInRefX on WidgetRef {
  ///-------------------------------
  //
  /// 📩 Triggers sign-in logic based on current form state
  void submit() {
    final form = read(signInFormProvider);
    read(
      signInProvider.notifier,
    ).signin(email: form.email.value, password: form.password.value);
  }
}
