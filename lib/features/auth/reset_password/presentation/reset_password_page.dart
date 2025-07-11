import 'package:firebase_with_riverpod/core/foundation/localization/generated/locale_keys.g.dart'
    show LocaleKeys;
import 'package:firebase_with_riverpod/core/foundation/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/foundation/overlays/overlays_dispatcher/overlay_dispatcher_provider.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:firebase_with_riverpod/features/auth/utils_and_extensions_for_auth_feature/reset_password_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useFocusNode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show HookConsumerWidget;
import '../../../../core/shared_presentation_layer/widgets_shared/buttons/text_button.dart';
import '../../../../core/foundation/localization/widgets/text_widget.dart';
import '../../../../core/foundation/navigation/app_routes/app_routes.dart';
import '../../../../core/foundation/theme/ui_constants/_app_constants.dart';
import '../../../../core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import '../../../../core/shared_presentation_layer/widgets_shared/buttons/filled_button.dart';
import '../../../form_fields/input_validation/_validation_enums.dart';
import '../../../form_fields/widgets/_fields_factory.dart';
import 'providers/reset_password_form_provider.dart';
import 'providers/reset_password_provider.dart';

part 'widgets_for_reset_password_page.dart';

/// 🔐 [ResetPasswordPage] — screen that allows user to request password reset
/// 📩 Sends reset link to user's email using [ResetPasswordProvider]

class ResetPasswordPage extends ConsumerWidget {
  ///------------------------------------------
  const ResetPasswordPage({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    // 👂 Declarative listener for success/failure
    ref.listenToResetPassword(context);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: ListView(
            shrinkWrap: true,
            children: const [
              //
              _ResetPasswordHeader(),

              _ResetPasswordEmailInputField(),
              SizedBox(height: AppSpacing.huge),

              _ResetPasswordSubmitButton(),
              SizedBox(height: AppSpacing.xxxs),

              _ResetPasswordFooter(),
            ],
          ).withPaddingHorizontal(AppSpacing.l),
        ),
      ),
    );
  }

  //
}
