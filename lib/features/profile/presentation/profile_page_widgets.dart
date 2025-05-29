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
            child: KeyValueTextWidget(
              labelKey: LocaleKeys.profile_welcome,
              value: user.name,
              labelTextType: TextType.headlineSmall,
              valueTextType: TextType.headlineSmall,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const TextWidget(LocaleKeys.profile_title, TextType.titleMedium),
          const SizedBox(height: AppSpacing.s),
          KeyValueTextWidget(
            labelKey: LocaleKeys.profile_email,
            value: user.email,
            labelTextType: TextType.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.s),
          KeyValueTextWidget(
            labelKey: LocaleKeys.profile_id,
            value: user.id,
            labelTextType: TextType.bodyMedium,
          ),

          const SizedBox(height: AppSpacing.xxxl2),
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
