// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _pl = {
  "app": {
    "title": "Firebase z Riverpod"
  },
  "languages": {
    "switched_to_pl": "Język zmieniono na 🇵🇱 polski",
    "switched_to_en": "Język zmieniono na 🇬🇧 angielski",
    "switched_to_ua": "Język zmieniono na 🇺🇦 ukraiński"
  },
  "buttons": {
    "ok": "OK",
    "sign_in": "Zaloguj się",
    "sign_up": "Zarejestruj się",
    "sign_out": "Wyloguj się",
    "submitting": "Wysyłanie...",
    "retry": "Spróbuj ponownie",
    "redirect_to_sign_up": "Nie masz konta?   ",
    "redirect_to_sign_in": "Masz już konto?   ",
    "cancel": "Anuluj",
    "go_to_home": "Na stronę główną",
    "reset_password": "Zresetuj hasło"
  },
  "errors": {
    "page_not_found_title": "Strony nie znaleziono",
    "page_not_found_message": "Ups! Strona, której szukasz, nie istnieje.",
    "error_dialog": "Wystąpił błąd",
    "firebase_title": "Błąd połączenia z Firebase",
    "firebase_message": "Spróbuj ponownie później!",
    "errors_general_title": "Wystąpił błąd"
  },
  "failure": {
    "firebase": {
      "doc_missing": "Brak profilu użytkownika.",
      "wrong_password": "Nieprawidłowe hasło.",
      "user_not_found": "Użytkownik nie został znaleziony.",
      "invalid_credential": "Nieprawidłowe dane logowania. Sprawdź poprawność i spróbuj ponownie.",
      "generic": "Wystąpił błąd Firebase.",
      "email_in_use": "Ten adres e-mail jest już używany.",
      "invalid_email": "Nieprawidłowy format adresu e-mail.",
      "missing_email": "Brak pola e-mail.",
      "no_current_user": "Brak aktualnie zalogowanego użytkownika.",
      "operation_not_allowed": "Ta operacja nie jest dozwolona przez Firebase.",
      "requires_recent_login": "Aby kontynuować, musisz się ponownie zalogować.",
      "too_many_requests": "Zbyt wiele prób. Spróbuj ponownie później.",
      "user_disabled": "To konto zostało dezaktywowane.",
      "weak_password": "Hasło jest zbyt słabe."
    },
    "format": {
      "error": "Odebrano nieprawidłowy format danych."
    },
    "network": {
      "no_connection": "Brak połączenia z Internetem.",
      "timeout": "Limit czasu połączenia został przekroczony. Spróbuj ponownie później."
    },
    "auth": {
      "unauthorized": "Twoja sesja wygasła. Zaloguj się ponownie."
    },
    "email_verification": {
      "timeout": "Weryfikacja e-maila trwała zbyt długo. Spróbuj ponownie później."
    },
    "plugin": {
      "missing": "Wykryto brakujący plugin. Skontaktuj się z pomocą techniczną."
    },
    "unknown": "Wystąpił nieoczekiwany błąd. Spróbuj ponownie."
  },
  "form": {
    "name": "Imię",
    "email": "Email",
    "password": "Hasło",
    "confirm_password": "Potwierdź hasło"
  },
  "pages": {
    "home": "     Strona główna",
    "home_message": "Możesz przejść do profilu i zmienić ustawienia",
    "profile": "Profil",
    "change_password": "Zmień hasło",
    "reset_password": "Zresetuj hasło",
    "verify_email": "Weryfikacja e-maila",
    "sign_in": "Zaloguj się do konta",
    "sign_up": "Dołącz do nas!",
    "reauthentication": "Ponowna autoryzacja"
  },
  "profile": {
    "title": "Profil",
    "name": "👤 Imię:",
    "id": "🆔 ID:",
    "email": "📧 Email:",
    "points": "📊 Punkty:",
    "rank": "🏆 Ranga:",
    "error": "Ups!\nCoś poszło nie tak.",
    "welcome": "Witaj,"
  },
  "reset_password": {
    "header": "Zresetuj swoje hasło",
    "sub_header": "Wyślemy Ci e-mail z linkiem do resetowania.",
    "success": "E-mail resetujący hasło został wysłany",
    "remember": "Pamiętasz hasło?   "
  },
  "change_password": {
    "title": "Zmień hasło",
    "warning": "Jeśli zmienisz hasło,",
    "prefix": "zostaniesz ",
    "signed_out": "wylogowany!",
    "success": "Pomyślnie uwierzytelniono ponownie"
  },
  "sign_in": {
    "header": "Witaj ponownie!",
    "sub_header": "Zaloguj się, aby kontynuować.",
    "forgot_password": "Nie pamiętasz hasła?",
    "not_member": "Nie masz konta?",
    "button": "Zaloguj się"
  },
  "sign_up": {
    "sub_header": "Utwórz konto, aby rozpocząć.",
    "already_have_account": "Masz już konto?",
    "button": "Zarejestruj się"
  },
  "reauth": {
    "label": "Ponowna autoryzacja",
    "description": "To operacja wymagająca bezpieczeństwa — musisz być ostatnio zalogowany!",
    "password_updated": "Hasło zostało zaktualizowane",
    "redirect_note": "Lub możesz przejść do     ",
    "page": "   strony"
  },
  "verify_email": {
    "sent": "E-mail weryfikacyjny został wysłany do",
    "not_found": "Jeśli nie widzisz wiadomości,",
    "check_prefix": "Sprawdź folder ",
    "spam": "SPAM",
    "check_suffix": ".",
    "ensure_correct": "Upewnij się, że Twój e-mail jest poprawny.",
    "unknown": "Nieznany",
    "or": "LUB"
  },
  "theme": {
    "light_enabled": "Obecnie \"Tryb jasny\"",
    "dark_enabled": "Obecnie \"Tryb ciemny\""
  }
};
static const Map<String,dynamic> _uk = {
  "app": {
    "title": "Файрбейс з Riverpod"
  },
  "languages": {
    "switched_to_pl": "Мову змінено на 🇵🇱 польську",
    "switched_to_en": "Мову змінено на 🇬🇧 англійську",
    "switched_to_ua": "Мову змінено на 🇺🇦 українську"
  },
  "buttons": {
    "ok": "ОК",
    "sign_in": "Увійти",
    "sign_up": "Зареєструватися",
    "sign_out": "Вийти",
    "submitting": "Надсилання...",
    "retry": "Повторити",
    "redirect_to_sign_up": "Ще не маєте акаунту?  ",
    "redirect_to_sign_in": "Вже маєте акаунт?   ",
    "cancel": "Скасувати",
    "go_to_home": "На головну",
    "reset_password": "Скинути пароль"
  },
  "errors": {
    "page_not_found_title": "Сторінку не знайдено",
    "page_not_found_message": "Ой! Сторінка, яку ви шукаєте, не існує.",
    "error_dialog": "Сталася помилка",
    "firebase_title": "Помилка з'єднання з Firebase",
    "firebase_message": "Будь ласка, спробуйте пізніше!",
    "errors_general_title": "Виникла помилка"
  },
  "failure": {
    "firebase": {
      "doc_missing": "Профіль користувача відсутній.",
      "wrong_password": "Неправильний пароль.",
      "user_not_found": "Користувача не знайдено.",
      "invalid_credential": "Некоректні облікові дані. Будь ласка, перевірте введене і спробуйте ще раз.",
      "generic": "Сталася помилка Firebase.",
      "email_in_use": "Ця електронна адреса вже використовується.",
      "invalid_email": "Некоректний формат електронної пошти.",
      "missing_email": "Поле електронної пошти відсутнє.",
      "no_current_user": "Немає поточного авторизованого користувача.",
      "operation_not_allowed": "Цю дію заборонено налаштуваннями Firebase.",
      "requires_recent_login": "Для виконання цієї дії потрібно нещодавно увійти до системи.",
      "too_many_requests": "Забагато запитів. Спробуйте пізніше.",
      "user_disabled": "Обліковий запис деактивовано.",
      "weak_password": "Пароль занадто слабкий."
    },
    "format": {
      "error": "Отримано некоректний формат даних."
    },
    "network": {
      "no_connection": "Немає підключення до Інтернету.",
      "timeout": "Час очікування перевищено. Спробуйте пізніше."
    },
    "auth": {
      "unauthorized": "Сесію завершено. Увійдіть знову."
    },
    "email_verification": {
      "timeout": "Підтвердження електронної пошти зайняло надто багато часу. Спробуйте пізніше."
    },
    "plugin": {
      "missing": "Виявлено відсутній плагін. Зверніться до служби підтримки."
    },
    "unknown": "Сталася непередбачувана помилка. Спробуйте пізніше."
  },
  "form": {
    "name": "Ім'я",
    "email": "Електронна пошта",
    "password": "Пароль",
    "confirm_password": "Підтвердження пароля"
  },
  "pages": {
    "home": "     Головна сторінка",
    "home_message": "Ви можете перейти на сторінку профілю і зробити налаштування",
    "profile": "Профіль",
    "change_password": "Зміна пароля",
    "reset_password": "Скинути пароль",
    "verify_email": "Підтвердження електронної пошти",
    "sign_in": "Увійдіть до свого акаунту",
    "sign_up": "Приєднуйтесь до нас!",
    "reauthentication": "Повторна аутентифікація"
  },
  "profile": {
    "title": "Профіль",
    "name": "👤 Ім'я:",
    "id": "🆔 ІН:",
    "email": "📧 Електронна пошта:",
    "points": "📊 Бали:",
    "rank": "🏆 Ранг:",
    "error": "Ой! Щось пішло не так.",
    "welcome": "Вітаємо,"
  },
  "reset_password": {
    "header": "Скидання пароля",
    "sub_header": "Ми надішлемо вам лист для скидання пароля.",
    "success": "Лист для скидання пароля надіслано",
    "remember": "Згадали пароль?   "
  },
  "change_password": {
    "title": "Зміна пароля",
    "warning": "Якщо ви зміните пароль,",
    "prefix": "ви будете ",
    "signed_out": "вилогінені з системи!",
    "success": "Успішна повторна аутентифікація"
  },
  "sign_in": {
    "header": "З поверненням!",
    "sub_header": "Увійдіть, щоб продовжити.",
    "forgot_password": "Забули пароль?",
    "not_member": "Ще не зареєстровані?",
    "button": "Увійти"
  },
  "sign_up": {
    "sub_header": "Створіть акаунт, щоб почати.",
    "already_have_account": "Вже маєте акаунт?",
    "button": "Зареєструватися"
  },
  "reauth": {
    "label": "Повторна аутентифікація",
    "description": "Це операція, чутлива до безпеки, ви повинні нещодавно увійти!",
    "password_updated": "Пароль успішно оновлено",
    "redirect_note": "Або ви можете перейти на     ",
    "page": "   сторінку"
  },
  "verify_email": {
    "sent": "Лист з підтвердженням надіслано на",
    "not_found": "Якщо ви не знайшли листа,",
    "check_prefix": "Перевірте папку ",
    "spam": "СПАМ",
    "check_suffix": " .",
    "ensure_correct": "Переконайтесь, що електронна адреса правильна.",
    "unknown": "Невідомо",
    "or": "АБО"
  },
  "theme": {
    "light_enabled": "Зараз увімкнено \"Світлу тему\"",
    "dark_enabled": "Зараз увімкнено \"Темну тему\""
  }
};
static const Map<String,dynamic> _en = {
  "app": {
    "title": "Firebase with Riverpod"
  },
  "languages": {
    "switched_to_pl": "Language switched to 🇵🇱 Polish",
    "switched_to_en": "Language switched to 🇬🇧 English",
    "switched_to_ua": "Language switched to 🇺🇦 Ukrainian"
  },
  "buttons": {
    "ok": "OK",
    "sign_in": "Sign In",
    "sign_up": "Sign Up",
    "sign_out": "Sign Out",
    "submitting": "Submitting...",
    "retry": "Retry",
    "redirect_to_sign_up": "Not a member?   ",
    "redirect_to_sign_in": "Already a member?  ",
    "cancel": "Cancel",
    "go_to_home": "To Home Page",
    "reset_password": "Reset Password"
  },
  "errors": {
    "page_not_found_title": "Page Not Found",
    "page_not_found_message": "Oops! The page you’re looking for does not exist.",
    "error_dialog": "Error occurs",
    "firebase_title": "Firebase Connection Error",
    "firebase_message": "Please try again later!",
    "errors_general_title": "An error occurred"
  },
  "failure": {
    "firebase": {
      "doc_missing": "User profile is missing.",
      "wrong_password": "Wrong password.",
      "user_not_found": "User not found.",
      "invalid_credential": "Invalid credentials. Please check your input and try again.",
      "generic": "A Firebase error occurred.",
      "email_in_use": "Email is already in use.",
      "invalid_email": "Invalid email format.",
      "missing_email": "Missing email field.",
      "no_current_user": "No current user signed in.",
      "operation_not_allowed": "Operation not allowed by Firebase.",
      "requires_recent_login": "Please reauthenticate to continue.",
      "too_many_requests": "Too many attempts. Please try again later.",
      "user_disabled": "This account is disabled.",
      "weak_password": "Password is too weak."
    },
    "format": {
      "error": "Invalid data format received."
    },
    "network": {
      "no_connection": "No internet connection.",
      "timeout": "Connection timed out. Please try again later."
    },
    "auth": {
      "unauthorized": "Your session has expired. Please sign in again."
    },
    "email_verification": {
      "timeout": "Email verification took too long. Please try again later."
    },
    "plugin": {
      "missing": "Missing plugin detected. Please contact support."
    },
    "unknown": "An unexpected error occurred. Please try again."
  },
  "form": {
    "name": "Name",
    "email": "Email",
    "password": "Password",
    "confirm_password": "Confirm Password"
  },
  "pages": {
    "home": "     Home Page",
    "home_message": "You can go to profile page and make some settings",
    "profile": "Profile",
    "change_password": "Change Password",
    "reset_password": "Reset Password",
    "verify_email": "Email Verification",
    "sign_in": "Sign in to your account",
    "sign_up": "Join Us!",
    "reauthentication": "Reauthentication"
  },
  "profile": {
    "title": "Profile",
    "name": "👤 Name:",
    "id": "🆔 ID:",
    "email": "📧 Email:",
    "points": "📊 Points:",
    "rank": "🏆 Rank:",
    "error": "Oops!\nSomething went wrong.",
    "welcome": "Welcome,"
  },
  "reset_password": {
    "header": "Reset your password",
    "sub_header": "We will send you an email to reset it.",
    "success": "Password reset email has been sent",
    "remember": "Remember password?    "
  },
  "change_password": {
    "title": "Change Password",
    "warning": "If you change your password,",
    "prefix": "you will be ",
    "signed_out": "signed out!",
    "success": "Successfully reauthenticated"
  },
  "sign_in": {
    "header": "Welcome Back!",
    "sub_header": "Please sign in to continue.",
    "forgot_password": "Forgot Password?",
    "not_member": "Not a member?",
    "button": "Sign In"
  },
  "sign_up": {
    "sub_header": "Create an account to get started.",
    "already_have_account": "Already have an account?",
    "button": "Sign Up"
  },
  "reauth": {
    "label": "Reauthenticate",
    "description": "This is a security-sensitive operation, you must have recently signed in!",
    "password_updated": "password updating succeed",
    "redirect_note": "Or you can go     ",
    "page": "   page"
  },
  "verify_email": {
    "sent": "Verification email has been sent to",
    "not_found": "If you cannot find the email,",
    "check_prefix": "Please check ",
    "spam": "SPAM",
    "check_suffix": " folder.",
    "ensure_correct": "Ensure your email is correct.",
    "unknown": "Unknown",
    "or": "OR"
  },
  "theme": {
    "light_enabled": "now is  \"Light Mode\"",
    "dark_enabled": "now is  \"Dark Mode\""
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"pl": _pl, "uk": _uk, "en": _en};
}
