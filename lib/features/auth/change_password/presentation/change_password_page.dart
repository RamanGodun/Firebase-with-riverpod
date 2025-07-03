import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/modules_shared/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_riverpod/core/modules_shared/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:firebase_with_riverpod/features/auth/utils_and_extensions_for_auth_feature/change_password_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show HookConsumerWidget;
import '../../../../core/layers_shared/presentation_layer_shared/widgets_shared/buttons/filled_button.dart';
import '../../../form_fields/input_validation/_validation_enums.dart';
import '../../../form_fields/utils/use_auth_focus_nodes.dart';
import '../../../../core/modules_shared/localization/widgets/text_widget.dart';
import '../../../../core/modules_shared/theme/ui_constants/_app_constants.dart';
import '../../../form_fields/widgets/_fields_factory.dart';
import '../../../form_fields/widgets/password_visibility_icon.dart';
import 'providers/change_password_form_provider.dart';
import 'providers/change_password_provider.dart';

part 'widgets_for_change_password.dart';

/// 🔐 [ChangePasswordPage] — Screen that allows the user to update their password.

class ChangePasswordPage extends HookConsumerWidget {
  ///-------------------------------------------
  const ChangePasswordPage({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //

    // 🔁 Declarative side-effect for ChangePassword
    ref.listenToPasswordChange(context);

    final focus = useChangePasswordFocusNodes();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: ListView(
              shrinkWrap: true,
              children: [
                const _ChangePasswordInfo(),
                const SizedBox(height: AppSpacing.xxxm),

                _PasswordField(focus: focus),
                const SizedBox(height: AppSpacing.m),

                _ConfirmPasswordField(focus: focus),
                const SizedBox(height: AppSpacing.xxxl),

                const _ChangePasswordSubmitButton(),
              ],
            ).withPaddingHorizontal(AppSpacing.l),
          ),
        ),
      ),
    );
  }

  //
}
