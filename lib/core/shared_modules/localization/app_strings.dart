/// 📄 [AppStrings] — centralized place for all static text constants
abstract final class AppStrings {
  AppStrings._();

  /// ===============================
  // 🏠 HOME PAGE
  // ===============================
  static const String appTitle = 'Firebase with BLoC/Cubit';
  static const String homePageAppBarTitle = '      Home Page';
  static const String homePageBodyMessage =
      'You can go to profile page and make some settings';

  /// ===============================
  // 👤 AUTH / FORM BUTTONS
  // ===============================
  static const String okButton = 'OK';
  static const String redirectToSignUp = 'Not a member?    ';
  static const String changePassword = 'Change Password';
  static const String submitting = 'Submitting...';

  /// ===============================
  // 🌗 THEME MODE TOGGLES
  // ===============================
  static const String lightModeEnabled = 'now is  "Light Mode"';
  static const String darkModeEnabled = 'now is  "Dark Mode"';

  /// ===============================
  // ❌ ERROR / NOT FOUND
  // ===============================
  static const String pageNotFoundTitle = 'Page Not Found';
  static const String pageNotFoundMessage =
      'Oops! The page you’re looking for does not exist.';
  static const String goToHomeButton = 'To Home Page';
  static const String errorDialogTitle = 'Error occurs';

  /// ===============================
  // ✍️ FORM FIELDS
  // ===============================
  static const String name = 'Name';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';

  /// ===============================
  // 🧑‍💼 PROFILE PAGE
  // ===============================
  static const String profilePageTitle = 'Profile';
  static const String profileNameLabel = '👤 Name:';
  static const String profileIdLabel = '🆔 ID:';
  static const String profileEmailLabel = '📧 Email:';
  static const String profilePointsLabel = '📊 Points:';
  static const String profileRankLabel = '🏆 Rank:';
  static const String profileErrorMessage = 'Oops!\nSomething went wrong.';
  static const String welcome = 'Welcome,';

  /// ===============================
  // 🔥 FIREBASE ERROR PAGE
  // ===============================
  static const String firebaseErrorTitle = 'Firebase Connection Error';
  static const String firebaseErrorMessage = 'Please try again later!';
  static const String retryButton = 'Retry';

  /// ===============================
  // 🔐 PASSWORD CHANGE PAGE
  // ===============================
  static const String passwordChangeTitle = 'Change Password';
  static const String passwordChangeWarning = 'If you change your password,';
  static const String passwordChangePrefix = 'you will be ';
  static const String passwordChangeSignedOut = 'signed out!';
  static const String reAuthSuccess = 'Successfully reauthenticated';

  // ===============================
  // 🔐 Reset Password
  // ===============================
  static const String resetPassword = 'Reset Password';
  static const String resetPasswordHeader = 'Reset your password';
  static const String resetPasswordSubHeader =
      'We will send you an email to reset it.';
  static const String resetPasswordSuccess =
      'Password reset email has been sent';
  static const String rememberPasswordPrompt = 'Remember password? ';

  /// ===============================
  // 🔐 SIGN IN PAGE
  // ===============================
  static const String signInHeader = 'Welcome Back!';
  static const String signInSubHeader = 'Please sign in to continue.';
  static const String signInTitle = 'Sign in to your account';
  static const String forgotPassword = 'Forgot Password?';
  static const String notAMember = 'Not a member?      ';
  static const String signInButton = 'Sign In';

  /// ===============================
  /// 🔐 SIGN UP PAGE
  /// ===============================
  static const String signUpHeader = 'Join Us!';
  static const String signUpSubHeader = 'Create an account to get started.';
  static const String alreadyHaveAccount = 'Already have an account?  ';
  static const String redirectToSignIn = 'Already a member?     ';
  static const String signUpButton = 'Sign Up';

  /// ===============================
  /// 🔐 REAUTH PAGE
  /// ===============================
  static const String reauthenticate = 'Reauthenticate';
  static const String reauthenticateTitle = 'Reauthentication';
  static const String reauthenticateDescription =
      'This is a security-sensitive operation, you must have recently signed in!';
  static const String passwordUpdated = 'password updating succeed';
  static const String redirectToSignInFromReAuthPage = 'Or you can go     ';
  static const String page = '   page';

  /// ===============================
  /// 🔐 EMAIL VERIFICATION PAGE
  /// ===============================
  static const String verifyEmailTitle = 'Email Verification';
  static const String verifyEmailSent = 'Verification email has been sent to';
  static const String verifyEmailNotFound = 'If you cannot find the email,';
  static const String verifyEmailCheckPrefix = 'Please check ';
  static const String verifyEmailSpam = 'SPAM';
  static const String verifyEmailCheckSuffix = ' folder.';
  static const String verifyEmailEnsureCorrect =
      'Ensure your email is correct.';
  static const String cancelButton = 'Cancel';
  static const String unknownEmail = 'Unknown';
  static const String or = 'OR';

  /// ===============================
  /// 🔐 Others
  /// ===============================
}
