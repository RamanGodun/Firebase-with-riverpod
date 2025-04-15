/// * 📄[AppStrings] centralized place for all app text constants.
abstract class AppStrings {
  ///
  /// ===============================
  /// * 🏠 Home page
  // ===============================
  static const String appTitle = 'Firebase with BLoC/Cubit';
  static const String homePageAppBarTitle = '      Home Page';
  static const String homePageBodyMessage =
      'You can go to profile page and make some settings';

  /// ────────────────────────────────────────────────────────────────────
  /// * 🏠 Titles
  // ────────────────────────────────────────────────────────────────────

  /// ────────────────────────────────────────────────────────────────────
  /// * 🆗 Buttons texts
  // ────────────────────────────────────────────────────────────────────
  static const String okButton = 'OK';
  static const String signUpButton = 'Sign Up';
  static const String redirectToSignIn = 'Already a member? Sign In!';
  static const String signInButton = 'Sign In';
  static const String redirectToSignUp = 'Not a member? Sign Up!';

  /// ────────────────────────────────────────────────────────────────────
  /// * 🌗 Theme Mode Messages
  // ────────────────────────────────────────────────────────────────────
  static const String lightModeEnabled = 'now is  "Light Mode"';
  static const String darkModeEnabled = 'now is  "Dark Mode"';

  /// ────────────────────────────────────────────────────────────────────
  /// * ❌ Error / Not Found
  // ────────────────────────────────────────────────────────────────────
  static const String pageNotFoundTitle = 'Page Not Found';
  static const String pageNotFoundMessage =
      'Oops! The page you’re looking for does not exist.';
  static const String goToHomeButton = 'To Home Page';

  /// ────────────────────────────────────────────────────────────────────
  /// * 🧠 Info / Slogans
  // ────────────────────────────────────────────────────────────────────

  /// ────────────────────────────────────────────────────────────────────
  /// * 🧠 Form fields labels
  // ────────────────────────────────────────────────────────────────────
  static const String name = 'Name';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';

  /// ────────────────────────────────────────────────────────────────────
  /// * 🔍 PROFILE PAGE
  // ────────────────────────────────────────────────────────────────────
  static const String profilePageTitle = 'Profile';
  static const String profileNameLabel = '👤 Name:';
  static const String profileIdLabel = '🆔 ID:';
  static const String profileEmailLabel = '📧 Email:';
  static const String profilePointsLabel = '📊 Points:';
  static const String profileRankLabel = '🏆 Rank:';
  static const String profileErrorMessage = 'Oops!\nSomething went wrong.';

  // ===============================
  // ❌ Firebase Error Page
  // ===============================
  static const String firebaseErrorTitle = 'Firebase Connection Error';
  static const String firebaseErrorMessage = 'Please try again later!';
  static const String retryButton = 'Retry';

  /// ────────────────────────────────────────────────────────────────────
  /// * 🔍 OTHERS
  // ────────────────────────────────────────────────────────────────────

  ///
}
