part of '_profile_page.dart';

/// 🔄 [_RefreshButton] — refreshes the profile data
class _RefreshButton extends ConsumerWidget {
  final String uid;
  const _RefreshButton({required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.refresh),
      onPressed: () => ref.invalidate(profileProvider(uid)),
    );
  }
}

/// 📦 [_UserProfile] — displays user data and password change button
/// 🧼 Rendered after successful response from [profileProvider]
class _UserProfile extends StatelessWidget {
  final AppUser user;

  const _UserProfile(this.user);

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
