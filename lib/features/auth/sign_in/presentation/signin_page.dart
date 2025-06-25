import 'package:firebase_with_riverpod/core/modules_shared/errors_handling/utils/for_riverpod/show_dialog_when_error_x.dart';
import 'package:firebase_with_riverpod/core/modules_shared/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/modules_shared/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:firebase_with_riverpod/features/auth/utils_and_extensions_for_auth_feature/sign_in_submit_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show HookConsumerWidget;
import '../../../../core/layers_shared/presentation_layer_shared/widgets_shared/buttons/text_button.dart';
import '../../../../core/modules_shared/navigation/app_routes/app_routes.dart';
import '../../../../core/modules_shared/theme/ui_constants/app_colors.dart';
import '../../../form_fields/input_validation/_validation_enums.dart';
import '../../../form_fields/utils/use_auth_focus_nodes.dart';
import '../../../form_fields/widgets/_fields_factory.dart';
import '../../../form_fields/widgets/password_visibility_icon.dart';
import '../../../../core/modules_shared/localization/widgets/text_widget.dart';
import '../../../../core/modules_shared/localization/generated/locale_keys.g.dart';
import '../../../../core/layers_shared/presentation_layer_shared/widgets_shared/buttons/custom_buttons.dart';
import '../../../../core/modules_shared/theme/ui_constants/_app_constants.dart';
import 'providers/_signin_provider.dart';
import 'providers/sign_in_form_fields_provider.dart';
import '../../../../core/utils_shared/extensions/context_extensions/_context_extensions.dart';

part 'widgets_for_signin_page.dart';

/// 🔐 [SignInPage] — screen that allows user to sign in.

class SignInPage extends HookConsumerWidget {
  ///-----------------------------------
  const SignInPage({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final focus = useSignInFocusNodes();

    // 🔁 Declarative side-effect for error displaying
    ref.listenFailure(signInProvider, context);

    /// used "LayoutBuilder + ConstrainedBox + IntrinsicHeight" pattern
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: FocusTraversalGroup(
                  child: ListView(
                    children: [
                      /// Logo and welcome messages
                      const SizedBox(height: AppSpacing.huge),
                      const FlutterLogo(size: AppSpacing.massive),
                      const SizedBox(height: AppSpacing.xxl),
                      const TextWidget(
                        LocaleKeys.sign_in_header,
                        TextType.headlineSmall,
                      ),
                      const TextWidget(
                        LocaleKeys.sign_in_sub_header,
                        TextType.bodyMedium,
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      ///
                      _SignInEmailInputField(focus),
                      const SizedBox(height: AppSpacing.m),

                      _SignInPasswordInputField(focus),
                      const SizedBox(height: AppSpacing.xxxl),

                      ///
                      const _SigninSubmitButton(),
                      const SizedBox(height: AppSpacing.l),

                      ///
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
