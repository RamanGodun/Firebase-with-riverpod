part of 'profile__page.dart';

/// 📦 [_UserProfile] — displays user data and password change button
/// 🧼 Rendered after successful response from [profileProvider]

class _UserProfile extends StatelessWidget {
  //---------------------------------------

  final UserEntity user;
  const _UserProfile(this.user);
  //

  @override
  Widget build(BuildContext context) {
    //
    final isDark = context.isDarkMode;

    return Center(
      child: BlurContainer(
        borderRadius: UIConstants.commonBorderRadius,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxm),
          padding: const EdgeInsets.all(AppSpacing.l),
          decoration: BoxDecorationFactory.iosCard(isDark),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child:
                        user.profileImage.isNotEmpty
                            ? FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loading.gif',
                              image: user.profileImage,
                              width: 96,
                              height: 96,
                              fit: BoxFit.cover,
                            )
                            : Container(
                              width: 96,
                              height: 96,
                              color: context.colorScheme.surfaceVariant,
                              child: const Icon(Icons.person, size: 48),
                            ),
                  ),
                  const SizedBox(width: AppSpacing.m),
                  Expanded(
                    child: KeyValueTextWidget(
                      labelKey: LocaleKeys.profile_welcome,
                      value: user.name,
                      labelTextType: TextType.headlineSmall,
                      valueTextType: TextType.headlineSmall,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.m),

              KeyValueTextWidget(
                labelKey: LocaleKeys.profile_email,
                value: user.email,
                labelTextType: TextType.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xxxs),
              KeyValueTextWidget(
                labelKey: LocaleKeys.profile_id,
                value: user.id,
                labelTextType: TextType.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.l),

              TextWidget(
                LocaleKeys.theme_choose_theme.tr(),
                TextType.titleSmall,
                fontWeight: FontWeight.w700,
              ),
              Row(
                children: [
                  ThemePicker(
                    key: ValueKey(Localizations.localeOf(context).languageCode),
                  ),
                  const ThemeToggler().withPaddingOnly(left: AppSpacing.l),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              CustomFilledButton(
                onPressed: () => context.goTo(RoutesNames.changePassword),
                label: LocaleKeys.change_password_title,
              ),
            ],
          ),
        ),
      ),
    ).withPaddingBottom(AppSpacing.massive);
  }
}
