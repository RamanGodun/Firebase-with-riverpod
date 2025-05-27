part of 'profile_page.dart';

/// 📦 [_UserProfileWidget] — displays user data and password change button
/// 🧼 Rendered after successful response from [profileProvider]
class _UserProfileWidget extends StatelessWidget {
  final AppUser user;

  const _UserProfileWidget(this.user);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: TextWidget(
              '${AppStrings.welcome} ${user.name}',
              TextType.headlineSmall,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const TextWidget(AppStrings.profilePageTitle, TextType.titleMedium),
          const SizedBox(height: AppSpacing.s),
          TextWidget(
            '${AppStrings.profileEmailLabel} ${user.email}',
            TextType.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.s),
          TextWidget(
            '${AppStrings.profileIdLabel} ${user.id}',
            TextType.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.huge),
          CustomButton(
            type: ButtonType.filled,
            onPressed: () => context.goTo(RoutesNames.changePassword),
            label: AppStrings.changePassword,
            isEnabled: true,
            isLoading: false,
          ),
        ],
      ),
    ).withPaddingHorizontal(AppSpacing.l);
  }
}
