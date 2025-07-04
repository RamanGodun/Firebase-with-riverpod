import 'package:firebase_with_riverpod/core/foundation/errors_handling/utils/for_riverpod/show_dialog_when_error_x.dart';
import 'package:firebase_with_riverpod/core/foundation/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/foundation/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:firebase_with_riverpod/features/auth/utils_and_extensions_for_auth_feature/sign_up_submit_x.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/layers_shared/presentation_layer_shared/widgets_shared/buttons/text_button.dart';
import '../../../../core/foundation/localization/widgets/text_widget.dart';
import '../../../../core/foundation/localization/generated/locale_keys.g.dart';
import '../../../../core/foundation/navigation/app_routes/app_routes.dart';
import '../../../../core/foundation/theme/ui_constants/_app_constants.dart';
import '../../../../core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import '../../../../core/layers_shared/presentation_layer_shared/widgets_shared/buttons/filled_button.dart';
import '../../../form_fields/input_validation/_validation_enums.dart';
import '../../../form_fields/utils/use_auth_focus_nodes.dart';
import '../../../form_fields/widgets/_fields_factory.dart';
import '../../../form_fields/widgets/password_visibility_icon.dart';
import 'providers/sign_up_form_provider.dart';
import 'providers/signup_provider.dart';

part 'widgets_for_signup_page.dart';
part 'input_fields.dart';

/// 🔐 [SignUpPage] — screen that allows user to register a new account.

class SignUpPage extends HookConsumerWidget {
  ///-----------------------------------
  const SignUpPage({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //

    // ❗️ Declarative error handling
    ref.listenFailure(signupProvider, context);

    final focus = useSignUpFocusNodes();

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: ListView(
              shrinkWrap: true,
              children: [
                /// 📋 Logo and welcome text
                const _SignupHeader(),

                /// 🔢 Name input field
                _NameInputField(focus),
                const SizedBox(height: AppSpacing.m),

                /// 🔢 Email input field
                _EmailInputField(focus),
                const SizedBox(height: AppSpacing.m),

                /// 🔢 Password input field
                _PasswordInputField(focus),
                const SizedBox(height: AppSpacing.m),

                /// 🔢 Confirm password field
                _ConfirmPasswordInputField(focus),
                const SizedBox(height: AppSpacing.xxxl),

                /// 🔺 Submit button
                const _SignupSubmitButton(),
                const SizedBox(height: AppSpacing.xl),

                /// 🔄 Redirect to sign in
                const _SignupFooter(),
              ],
            ).withPaddingHorizontal(AppSpacing.xxxm),
          ),
        ),
      ),
    );
  }

  //
}
