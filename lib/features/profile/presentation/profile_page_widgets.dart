part of 'profile__page.dart';

/// 📦 [_UserProfile] — displays user data and password change button
/// 🧼 Rendered after successful response from [profileProvider]

class _UserProfile extends StatelessWidget {
  final UserEntity user;
  const _UserProfile(this.user);
  //--------------------------

  @override
  Widget build(BuildContext context) {
    //
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KeyValueTextWidget(
            labelKey: LocaleKeys.profile_welcome,
            value: user.name,
            labelTextType: TextType.headlineSmall,
            valueTextType: TextType.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.xl),

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

          const SizedBox(height: AppSpacing.xxxs),
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

          const SizedBox(height: AppSpacing.xxxxl),
          CustomButton(
            type: ButtonType.filled,
            onPressed: () => context.goTo(RoutesNames.changePassword),
            label: LocaleKeys.change_password_title,
            isEnabled: true,
            isLoading: false,
          ),
        ],
      ),
    ).withPaddingHorizontal(AppSpacing.l);
  }
}
