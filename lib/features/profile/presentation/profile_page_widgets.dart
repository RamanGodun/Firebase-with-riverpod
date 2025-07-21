part of 'profile__page.dart';

/// [_ProfileAppBar] — Top bar with profile title, language and sign-out actions.
//
final class _ProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  ///----------------------------
  const _ProfileAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(
      title: LocaleKeys.profile_title,
      actionWidgets: [LanguageToggleButton(), SignOutIconButton()],
    );
  }
}

////

////

/// 🎨 [_ThemeSection] — UI section for selecting app theme and toggling appearance.
//
final class _ThemeSection extends StatelessWidget {
  const _ThemeSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          LocaleKeys.theme_choose_theme.tr(),
          TextType.titleMedium,
          fontWeight: FontWeight.w700,
        ),
        Row(
          children: [
            ThemePicker(
              key: ValueKey(Localizations.localeOf(context).languageCode),
            ),
            const ThemeTogglerIcon().withPaddingOnly(left: AppSpacing.l),
          ],
        ),
      ],
    );
  }
}

////

////

/// 🔒 [_ChangePasswordButton] — Navigates user to Change Password screen.
//
final class _ChangePasswordButton extends StatelessWidget {
  const _ChangePasswordButton();

  @override
  Widget build(BuildContext context) {
    return CustomFilledButton(
      onPressed: () => context.goTo(RoutesNames.changePassword),
      label: LocaleKeys.change_password_title,
    );
  }
}
