import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/base_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_riverpod/core/base_modules/navigation/utils/extensions/navigation_x_on_context.dart';
import 'package:firebase_with_riverpod/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_riverpod/core/base_modules/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show HookConsumerWidget;
import '../../../../core/base_modules/navigation/routes/app_routes.dart';
import '../../../../core/shared_presentation_layer/shared_widgets/buttons/filled_button.dart';
import '../../../auth/presentation/sign_in/sign_in_page.dart';
import '../../../../core/base_modules/form_fields/input_validation/validation_enums.dart';
import '../../../../core/base_modules/form_fields/utils/use_auth_focus_nodes.dart';
import '../../../../core/base_modules/localization/widgets/text_widget.dart';
import '../../../../core/base_modules/theme/ui_constants/_app_constants.dart';
import '../../../../core/base_modules/form_fields/widgets/_fields_factory.dart';
import '../../../../core/base_modules/form_fields/widgets/password_visibility_icon.dart';
import 'providers/change_password_form_provider.dart';
import 'providers/change_password_provider.dart';

part 'widgets_for_change_password.dart';
part 'x_on_ref_for_change_password.dart';

/// 🔐 [ChangePasswordPage] — Screen that allows the user to update their password.
//
final class ChangePasswordPage extends HookConsumerWidget {
  ///-------------------------------------------
  const ChangePasswordPage({super.key});

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
                //
                const _ChangePasswordInfo(),
                _PasswordField(focus: focus),
                _ConfirmPasswordField(focus: focus),
                const _ChangePasswordSubmitButton(),
                //
              ],
            ).withPaddingHorizontal(AppSpacing.l),
          ),
        ),
      ),
    );
  }

  //
}
