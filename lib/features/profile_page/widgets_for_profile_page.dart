part of 'profile_page.dart';

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
            child: TextWidget('Welcome ${user.name}', TextType.headlineSmall),
          ),
          const SizedBox(height: AppSpacing.xl),
          const TextWidget('      Your Profile', TextType.titleMedium),
          const SizedBox(height: AppSpacing.s),
          TextWidget('Email: ${user.email}', TextType.bodyMedium),
          const SizedBox(height: AppSpacing.s),
          TextWidget('ID: ${user.id}', TextType.bodyMedium),
          const SizedBox(height: AppSpacing.huge),
          CustomButton(
            type: ButtonType.filled,
            onPressed: () => context.goTo(RoutesNames.changePassword),
            label: 'Change Password',
            isEnabled: true,
            isLoading: false,
          ),
        ],
      ),
    ).withPaddingHorizontal(AppSpacing.l);
  }
}

class _ErrorMessage extends StatelessWidget {
  final CustomError error;

  const _ErrorMessage({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextWidget(
        'code: ${error.code}\nplugin: ${error.plugin}\nmessage: ${error.message}',
        TextType.error,
        alignment: TextAlign.center,
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
