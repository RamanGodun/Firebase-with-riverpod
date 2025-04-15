/// 📄 [AppStrings] — centralized place for all static text constants
abstract class AppStrings {
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
  static const String signUpButton = 'Sign Up';
  static const String signInButton = 'Sign In';
  static const String redirectToSignUp = 'Not a member? Sign Up!';
  static const String redirectToSignIn = 'Already a member? Sign In!';
  static const String submitting = 'Submitting...';
  static const String changePassword = 'Change Password';

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
  static const String reAuthSuccess =  'Successfully reauthenticated';

  ///
}
