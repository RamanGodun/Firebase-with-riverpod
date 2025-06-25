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
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecorationFactory.iosCard(isDark),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              const SizedBox(height: AppSpacing.l),

              KeyValueTextWidget(
                labelKey: LocaleKeys.profile_welcome,
                value: user.name,
                labelTextType: TextType.headlineSmall,
                valueTextType: TextType.headlineSmall,
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

              ThemePicker(
                key: ValueKey(Localizations.localeOf(context).languageCode),
              ),
              const SizedBox(height: AppSpacing.xl),

              CustomButton(
                onPressed: () => context.goTo(RoutesNames.changePassword),
                label: LocaleKeys.change_password_title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
