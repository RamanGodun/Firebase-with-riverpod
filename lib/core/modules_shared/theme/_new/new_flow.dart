import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../localization/generated/locale_keys.g.dart';
import '../theme_styling/app_colors.dart';
import '_text_styles.dart';

// 🎨 Theme extension for font
class FontThemeExtension extends ThemeExtension<FontThemeExtension> {
  final FontFamilyType font;
  const FontThemeExtension({required this.font});

  @override
  FontThemeExtension copyWith({FontFamilyType? font}) {
    return FontThemeExtension(font: font ?? this.font);
  }

  @override
  FontThemeExtension lerp(ThemeExtension<FontThemeExtension>? other, double t) {
    if (other is! FontThemeExtension) return this;
    return t < 0.5 ? this : other;
  }
}

// 🧠 Theme TextTheme cache
abstract final class _TextThemeCache {
  static final _cache = <(FontFamilyType, Brightness), TextTheme>{};

  static TextTheme get(FontFamilyType font, Brightness brightness) =>
      _cache.putIfAbsent((font, brightness), () {
        final baseColor =
            brightness == Brightness.dark ? AppColors.white : AppColors.black;
        return AppTextStyles.getTextTheme(baseColor, font: font);
      });
}

// 🧱 Main theme class
@immutable
final class AppThemeScheme extends Equatable {
  final ThemeData light;
  final ThemeData dark;
  final ThemeMode mode;
  final FontFamilyType font;
  final Object identityKey;

  const AppThemeScheme({
    required this.light,
    required this.dark,
    required this.mode,
    required this.font,
    required this.identityKey,
  });

  factory AppThemeScheme.withFont(AppThemeScheme base, FontFamilyType newFont) {
    if (base.font == newFont) return base;

    final cached = ThemeEngine._fontVariants[(base, newFont)];
    if (cached != null) return cached;

    final updated = AppThemeScheme(
      mode: base.mode,
      font: newFont,
      identityKey: Object.hash(base.identityKey, newFont),
      light: base.light.copyWith(
        textTheme: _TextThemeCache.get(newFont, Brightness.light),
        extensions: <ThemeExtension<dynamic>>[
          FontThemeExtension(font: newFont),
        ],
      ),
      dark: base.dark.copyWith(
        textTheme: _TextThemeCache.get(newFont, Brightness.dark),
        extensions: <ThemeExtension<dynamic>>[
          FontThemeExtension(font: newFont),
        ],
      ),
    );

    ThemeEngine._fontVariants[(base, newFont)] = updated;
    return updated;
  }

  @override
  List<Object?> get props => [mode, font, identityKey];
}

// 🌐 Central Theme Engine
abstract final class ThemeEngine {
  ///--------

  ///
  static void init() {
    for (final scheme in [iosLight, iosGlassDark, androidAmoled]) {
      for (final font in FontFamilyType.values) {
        AppThemeScheme.withFont(scheme, font);
      }
    }
    print('[ThemeEngine] allVariants: ${_fontVariants.length}');
  }

  ///
  static Iterable<AppThemeScheme> get allVariants => _fontVariants.values;

  ///
  static final _fontVariants =
      <(AppThemeScheme, FontFamilyType), AppThemeScheme>{};

  static const ColorScheme _lightScheme = ColorScheme.light(
    primary: AppColors.lightPrimary,
    secondary: AppColors.lightAccent,
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    onPrimary: AppColors.white,
    onSecondary: AppColors.black,
    onBackground: AppColors.black,
    onSurface: AppColors.black,
    error: AppColors.forErrors,
  );

  static const ColorScheme _darkGlassScheme = ColorScheme.dark(
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkAccent,
    background: AppColors.darkOverlay,
    surface: AppColors.darkSurface,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onBackground: AppColors.white,
    onSurface: AppColors.white,
    error: AppColors.forErrors,
  );

  static const ColorScheme _darkAmoledScheme = ColorScheme.dark(
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkAccent,
    background: AppColors.black,
    surface: AppColors.darkSurface,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onBackground: AppColors.white,
    onSurface: AppColors.white,
    error: AppColors.forErrors,
  );

  static final AppThemeScheme iosLight = AppThemeScheme(
    mode: ThemeMode.light,
    font: FontFamilyType.sfPro,
    identityKey: const Object(),
    light: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.lightPrimary,
      cardColor: AppColors.lightOverlay,
      colorScheme: _lightScheme,
      textTheme: _TextThemeCache.get(FontFamilyType.sfPro, Brightness.light),
    ),
    dark: _emptyTheme,
  );

  static final AppThemeScheme iosGlassDark = AppThemeScheme(
    mode: ThemeMode.dark,
    font: FontFamilyType.sfPro,
    identityKey: const Object(),
    light: _emptyTheme,
    dark: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkOverlay,
      primaryColor: AppColors.darkPrimary,
      cardColor: AppColors.glassCard,
      colorScheme: _darkGlassScheme,
      textTheme: _TextThemeCache.get(FontFamilyType.sfPro, Brightness.dark),
    ),
  );

  static final AppThemeScheme androidAmoled = AppThemeScheme(
    mode: ThemeMode.dark,
    font: FontFamilyType.sfPro,
    identityKey: const Object(),
    light: _emptyTheme,
    dark: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.black,
      primaryColor: AppColors.darkPrimary,
      cardColor: AppColors.darkOverlay,
      colorScheme: _darkAmoledScheme,
      textTheme: _TextThemeCache.get(FontFamilyType.sfPro, Brightness.dark),
    ),
  );

  static final ThemeData _emptyTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(),
  );

  ///
  static final Map<Object, String> _labels = {
    iosLight.identityKey: LocaleKeys.theme_light,
    iosGlassDark.identityKey: LocaleKeys.theme_dark,
    androidAmoled.identityKey: LocaleKeys.theme_amoled,
  };

  static final Map<Object, String> _chosenLabels = {
    iosLight.identityKey: LocaleKeys.theme_light_enabled,
    iosGlassDark.identityKey: LocaleKeys.theme_dark_enabled,
    androidAmoled.identityKey: LocaleKeys.theme_amoled_enabled,
  };

  static String? getLabel(AppThemeScheme scheme) => _labels[scheme.identityKey];

  static String? getChosenLabel(AppThemeScheme scheme) =>
      _chosenLabels[scheme.identityKey];

  //
}
