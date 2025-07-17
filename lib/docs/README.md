# 📦 firebase_with_riverpod

Blueprint Flutter project integrating Firebase with Riverpod and Clean Architecture. 
Built to scale with modular features, full testability, modern design, and strict architectural boundaries.

---

## 🚀 Stack Overview

| Layer            | Tech                                              |
|------------------|---------------------------------------------------|
| **Architecture** | Clean Architecture, Modular Structure             |
| **State**        | Riverpod (async + codegen)                        |
| **Firebase**     | Auth, Firestore, FirebaseOptions via `.env`       |
| **Routing**      | `go_router` + strongly typed paths                |
| **UI**           | Cupertino + Material, glassmorphism, accessibility|
| **Forms**        | Declarative, reusable, validated by templates     |


---


## 🧾 Architectural Decisions

See [`ADR.md`](./ADR.md) for rationale behind architectural choices, 
Riverpod usage, and Firebase integration patterns.


---


## ⚙️ Firebase Configuration

Create a `.env` file in the project root:

```env
FIREBASE_API_KEY=...
FIREBASE_APP_ID=...
FIREBASE_PROJECT_ID=...
FIREBASE_MESSAGING_SENDER_ID=...
FIREBASE_STORAGE_BUCKET=...
FIREBASE_AUTH_DOMAIN=...
FIREBASE_IOS_BUNDLE_ID=...
```

Load Firebase config via platform-aware utility:

```dart
final options = EnvFirebaseOptions.currentPlatform;
```

---

## 🔐 Authentication Flow

Handled via `AuthRepository`, providers, and UI hooks:

- ✅ Email/password Sign Up
- ✅ Email/password Sign In
- 🔁 Email Verification (with polling)
- 📩 Reset Password
- ✏️ Change Password
- 🔒 Re-authentication for sensitive flows

Reactive status tracked with `authStateStreamProvider`, and access via `fbAuth.currentUser`.

---

## 🧪 Testing Strategy

Follows the **Testing Pyramid**:

- ✅ **Unit tests** (80%) — providers, validators, repos
- 🧩 **Widget tests** (15%) — UI validation
- 🔁 **Integration tests** (5%) — edge-to-edge flows

> ✅ `mockito`, `build_runner`, `very_good_analysis` used for best practices

---

## 🎨 Theming & UX

Dynamic theming powered by `ThemeModeNotifier`:

- 🌓 Light/Dark toggle with persistence (via `GetStorage`)
- 🍏 Typography: SF Pro Text (Apple-like)
- 🧼 Glassmorphism-inspired cards/buttons
- ♿ Full accessibility support (tap size, contrast, semantics)

---

## 🧭 Navigation

Routing via `go_router` with typed names:

- All routes defined in `routes_names.dart`
- `Router` configured in `core/router/router.dart`
- Navigation via `context.goTo(...)` extension
- Supports `pathParameters` and `queryParameters`

---

## 📦 Firebase Layer

- `authRepository` handles all `firebase_auth` logic
- `profileRepository` fetches user data from `usersCollection`
- Constants in `firebase_constants.dart` for easy access:
  - `fbAuth` — instance of `FirebaseAuth`
  - `usersCollection` — Firestore reference

---

## 📄 Forms System

Forms are:
- Declaratively generated using templates (`FormTemplates`)
- Validated in `FormStateNotifier`
- Controlled with `formStateNotifierProvider`

> ✅ Fully testable, reactive, and reusable

---

## 🧩 UI Components

Reusable, animated and styled with accessibility:

- `CustomButton` — text/filled with animation + states
- `TextWidget` — wraps `Text` with type-safe styles
- `CustomAppBar` — flexible app bar
- `MiniWidgets` — error/loading inline blocks

---

## 📚 Extensions

Organized and extensive set of extensions:

- `context_extensions` — navigation, media, padding, theme, snackbar
- `general_extensions` — string, datetime, formatting, widget layout, animation, border, etc.

> 🧼 Keeps widget code concise and declarative

---

## 🛠 Dev Setup

Install dependencies:
```bash
flutter pub get
```

Generate code:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Run app:
```bash
flutter run
```

---

## ♻️ Scalability & Modularity

The architecture is modular by design and easily scalable:

- 🔌 Features can be extracted into packages
- 🧱 Presentation is fully decoupled from logic
- 🧪 All business logic testable in isolation
- 🧼 Strong boundaries between layers

---

## Project files TREE

``` tree
lib/
|
├── app_bootstrap_and_config
│   ├── app_bootstrap.dart
│   ├── app_config
│   │   ├── constants
│   │   │   ├── config_constants_barrel.dart
│   │   │   ├── environment_flags.dart
│   │   │   ├── info_constants.dart
│   │   │   ├── platform_requirements.dart
│   │   │   └── timing_config.dart
│   │   └── firebase
│   │       ├── env.dart
│   │       ├── firebase_constants.dart
│   │       ├── firebase_options_env.dart
│   │       └── firebase_utils.dart
|   |
│   ├── di_container
│   │   ├── di_config_async.dart
│   │   ├── di_config_sync.dart
│   │   ├── di_container.dart
│   │   └── read_di_x_on_context.dart
│   ├── docs
│   │   ├── bootstrap_with_splash_screen.md
│   │   └── advanced_bootstrap.md
|   |
│   ├── local_storage_init.dart
│   ├── platform_validation.dart
│   └── remote_db_init.dart
|
|
├── core
│   ├── base_modules
│   │   ├── animation
│   │   │   ├── overlays_animation
│   │   │   │   ├── animation_engines
│   │   │   │   │   ├── _animation_engine.dart
│   │   │   │   │   ├── animation_base_engine.dart
│   │   │   │   │   ├── engine_configs.dart
│   │   │   │   │   ├── fallback_engine.dart
│   │   │   │   │   └── platform_based_engines
│   │   │   │   │       ├── _engine_mapper_x.dart
│   │   │   │   │       ├── android_animation_engine.dart
│   │   │   │   │       └── ios_animation_engine.dart
│   │   │   │   ├── animation_wrapper
│   │   │   │   │   ├── animated_overlay_shell.dart
│   │   │   │   │   ├── animated_overlay_wrapper.dart
│   │   │   │   │   └── overlay_animation_x_for_widget.dart
│   │   │   │   └── animation.md
│   │   │   └── widget_animation_x.dart
|   |   |
│   │   ├── errors_handling
│   │   │   ├── either
│   │   │   │   ├── either_extensions
│   │   │   │   │   ├── __eithers_facade.dart
│   │   │   │   │   ├── _either_x.dart
│   │   │   │   │   ├── either_async_x.dart
│   │   │   │   │   ├── either_getters_x.dart
│   │   │   │   │   └── for_tests_either_x.dart
│   │   │   │   ├── either_primitives.dart
│   │   │   │   └── either.dart
│   │   │   ├── enums
│   │   │   │   ├── error_plugins.dart
│   │   │   │   └── failure_key.dart
│   │   │   ├── Errors handling FLOW.md
│   │   │   ├── failures
│   │   │   │   ├── extensions
│   │   │   │   │   ├── failure_diagnostics_x.dart
│   │   │   │   │   ├── failure_type_x.dart
│   │   │   │   │   └── to_ui_failure_x.dart
│   │   │   │   ├── failure_model.dart
│   │   │   │   ├── failure_subclasses
│   │   │   │   │   ├── firebase_failures.dart
│   │   │   │   │   ├── generic_failure.dart
│   │   │   │   │   ├── network_and_api_failures.dart
│   │   │   │   │   ├── unknown_failure.dart
│   │   │   │   │   └── usecase_and_cache_failures.dart
│   │   │   │   └── failure_ui_model.dart
│   │   │   ├── README for errors_handling module.md
│   │   │   └── utils
│   │   │       ├── exceptions_to_failures_mapper
│   │   │       │   ├── _exceptions_to_failures_mapper.dart
│   │   │       │   ├── dio_cases.dart
│   │   │       │   ├── domain_cases.dart
│   │   │       │   ├── firebase_cases.dart
│   │   │       │   ├── network_cases.dart
│   │   │       │   └── platform_cases.dart
│   │   │       ├── failure_utils.dart
│   │   │       ├── for_bloc
│   │   │       │   ├── consumable_x.dart
│   │   │       │   ├── consumable.dart
│   │   │       │   ├── One_time_error_displaying.md
│   │   │       │   ├── result_handler_async.dart
│   │   │       │   └── result_handler.dart
│   │   │       ├── for_riverpod
│   │   │       │   ├── safe_async_state.dart
│   │   │       │   └── show_dialog_when_error_x.dart
│   │   │       ├── observers
│   │   │       │   ├── loggers
│   │   │       │   │   ├── crash_analytics_logger.dart
│   │   │       │   │   ├── errors_log_util.dart
│   │   │       │   │   └── failure_logger_x.dart
│   │   │       │   └── result_loggers
│   │   │       │       ├── async_result_logger.dart
│   │   │       │       └── result_logger_x.dart
│   │   │       └── unit.dart
|   |   |
│   │   ├── localization
│   │   │   ├── app_localization.dart
│   │   │   ├── app_localizer.dart
│   │   │   ├── extensions
│   │   │   │   ├── string_x.dart
│   │   │   │   └── text_from_string_x.dart
│   │   │   ├── generated
│   │   │   │   ├── codegen_loader.g.dart
│   │   │   │   └── locale_keys.g.dart
│   │   │   ├── localization_logger.dart
│   │   │   ├── Localization_README.md
│   │   │   ├── when_app_without_localization
│   │   │   │   ├── app_strings.dart
│   │   │   │   └── fallback_keys.dart
│   │   │   └── widgets
│   │   │       ├── key_value_text_widget.dart
│   │   │       ├── language_option.dart
│   │   │       ├── language_toggle_button.dart
│   │   │       └── text_widget.dart
|   |   |
│   │   ├── logging
│   │   │   ├── _App_logging.md
│   │   │   ├── for_bloc
│   │   │   │   └── bloc_observer.dart
│   │   │   └── for_riverpod
│   │   │       ├── async_value_xx.dart
│   │   │       └── riverpod_observer.dart
|   |   |
│   │   ├── navigation
│   │   │   ├── app_routes
│   │   │   │   ├── app_routes.dart
│   │   │   │   ├── route_paths.dart
│   │   │   │   └── routes_names.dart
│   │   │   ├── core
│   │   │   │   ├── go_router_provider.dart
│   │   │   │   └── router_factory.dart
│   │   │   ├── extensions
│   │   │   │   ├── failure_navigation_x.dart
│   │   │   │   ├── navigation_x.dart
│   │   │   │   └── result_navigation_x.dart
│   │   │   └── utils
│   │   │       ├── page_transition.dart
│   │   │       └── routes_redirection_service.dart
|   |   |
│   │   ├── overlays
│   │   │   ├── core
│   │   │   │   ├── _context_x_for_overlays.dart
│   │   │   │   ├── _overlay_base_methods.dart
│   │   │   │   ├── enums_for_overlay_module.dart
│   │   │   │   ├── global_overlay_handler.dart
│   │   │   │   ├── platform_mapper.dart
│   │   │   │   └── tap_through_overlay_barrier.dart
│   │   │   ├── overlays_dispatcher
│   │   │   │   ├── _overlay_dispatcher.dart
│   │   │   │   ├── overlay_conflicts_strategy.md
│   │   │   │   ├── overlay_dispatcher_provider.dart
│   │   │   │   ├── overlay_entries
│   │   │   │   │   ├── _overlay_entries_registry.dart
│   │   │   │   │   ├── banner_overlay_entry.dart
│   │   │   │   │   ├── dialog_overlay_entry.dart
│   │   │   │   │   └── snackbar_overlay_entry.dart
│   │   │   │   ├── overlay_logger.dart
│   │   │   │   ├── overlay_navigation_observer.dart
│   │   │   │   ├── overlay_status_cubit.dart
│   │   │   │   └── policy_resolver.dart
│   │   │   ├── Overlays_flow.md
│   │   │   └── overlays_presentation
│   │   │       ├── overlay_presets
│   │   │       │   ├── overlay_preset_props.dart
│   │   │       │   └── overlay_presets.dart
│   │   │       └── widgets
│   │   │           ├── android
│   │   │           │   ├── android_banner.dart
│   │   │           │   ├── android_dialog.dart
│   │   │           │   └── android_snackbar.dart
│   │   │           ├── ios
│   │   │           │   ├── ios_banner.dart
│   │   │           │   ├── ios_dialog.dart
│   │   │           │   └── ios_snackbar.dart
│   │   │           └── simple_animated_banner
│   │   │               ├── overlay_service.dart
│   │   │               └── overlay_widget.dart
|   |   |
│   │   └── theme
│   │       ├── _theme_preferences.dart
│   │       ├── app_theme_variants.dart
│   │       ├── extensions
│   │       │   ├── text_style_x.dart
│   │       │   ├── theme_mode_x.dart
│   │       │   └── theme_x.dart
│   │       ├── text_theme
│   │       │   ├── font_family_enum.dart
│   │       │   └── text_theme_factory.dart
│   │       ├── theme_builder_x.dart
│   │       ├── theme_props_inherited_w.dart
│   │       ├── theme_provider
│   │       │   ├── theme_config_provider.dart
│   │       │   └── theme_storage_provider.dart
│   │       ├── ui_constants
│   │       │   ├── _app_constants.dart
│   │       │   ├── app_colors.dart
│   │       │   ├── app_icons.dart
│   │       │   ├── app_shadows.dart
│   │       │   └── app_spacing.dart
│   │       └── widgets_and_utils
│   │           ├── barrier_filter.dart
│   │           ├── blur_wrapper.dart
│   │           ├── box_decorations
│   │           │   ├── _box_decorations_factory.dart
│   │           │   ├── android_card_bd.dart
│   │           │   ├── android_dialog_bd.dart
│   │           │   ├── ios_buttons_bd.dart
│   │           │   ├── ios_card_bd.dart
│   │           │   └── ios_dialog_bd.dart
│   │           ├── theme_cache_mixin.dart
│   │           └── theme_toggle_widgets
│   │               ├── theme_picker.dart
│   │               └── theme_toggler.dart
|   |
|   |
│   ├── shared_data_layer
│   │   └── base_repo.dart
|   |
│   ├── shared_domain_layer
│   │   ├── base_use_case.dart
│   │   └── shared_auth
│   │       ├── auth_state_providers.dart
│   │       └── auth_user_utils.dart
|   |
│   ├── shared_presentation_layer
│   │   ├── pages_shared
│   │   │   ├── home_page.dart
│   │   │   ├── page_not_found.dart
│   │   │   └── splash_page.dart
│   │   └── widgets_shared
│   │       ├── app_bar.dart
│   │       ├── buttons
│   │       │   ├── filled_button.dart
│   │       │   └── text_button.dart
│   │       ├── divider.dart
│   │       └── loaders
│   │           └── loader.dart
|   |
│   └── utils_shared
│       ├── extensions
│       │   ├── context_extensions
│       │   │   ├── _context_extensions.dart
│       │   │   ├── media_query_x.dart
│       │   │   ├── other_x.dart
│       │   │   └── padding_x.dart
│       │   ├── extension_on_widget
│       │   │   ├── _widget_x.dart
│       │   │   ├── widget_aligning_x.dart
│       │   │   ├── widget_border_radius_x.dart
│       │   │   ├── widget_padding_x.dart
│       │   │   └── widget_x.dart
│       │   └── general_extensions
│       │       ├── _general_extensions.dart
│       │       ├── datetime_x.dart
│       │       ├── duration_x.dart
│       │       ├── number_formatting_x.dart
│       │       └── string_x.dart
│       ├── spider
│       │   ├── app_images.dart
│       │   ├── resources.dart
│       │   ├── Spider_README.md
│       │   └── spider.yaml
│       ├── stream_change_notifier.dart
│       ├── timing_control
│       │   ├── debouncer.dart
│       │   └── throttler.dart
│       └── type_definitions.dart
| 
|
|
├── features
│   ├── auth
│   │   ├── data
│   │   │   ├── auth_repo_implementations.dart
│   │   │   ├── auth_repo_providers.dart
│   │   │   └── auth_repo_providers.g.dart
│   │   ├── domain
│   │   │   ├── auth_repo_contracts.dart
│   │   │   ├── auth_use_cases_providers.dart
│   │   │   ├── auth_use_cases_providers.g.dart
│   │   │   └── auth_use_cases.dart
│   │   └── presentation
│   │       ├── sign_in
│   │       │   ├── providers
│   │       │   │   ├── _signin_provider.dart
│   │       │   │   ├── _signin_provider.g.dart
│   │       │   │   ├── sign_in_form_fields_provider.dart
│   │       │   │   ├── sign_in_form_fields_provider.g.dart
│   │       │   │   └── sign_in_form_fields_state.dart
│   │       │   ├── sign_in_page.dart
│   │       │   ├── sign_in_ref_x.dart
│   │       │   └── widgets_for_sign_in_page.dart
│   │       ├── sign_out
│   │       │   ├── sign_out_buttons.dart
│   │       │   ├── sign_out_provider.dart
│   │       │   └── sign_out_provider.g.dart
│   │       └── sign_up
│   │           ├── _signup_page.dart
│   │           ├── input_fields.dart
│   │           ├── providers
│   │           │   ├── sign_up_form_provider.dart
│   │           │   ├── sign_up_form_provider.g.dart
│   │           │   ├── signup_form_state.dart
│   │           │   ├── signup_provider.dart
│   │           │   └── signup_provider.g.dart
│   │           ├── sign_up_submit_x.dart
│   │           └── widgets_for_sign_up_page.dart
|   |
│   ├─ change_or_reset_password
│   │   ├── data
│   │   │   ├── password_repo_impl.dart
│   │   │   ├── password_repo_provider.dart
│   │   │   └── password_repo_provider.g.dart
│   │   ├── domain
│   │   │   ├── repo_contract.dart
│   │   │   ├── use_cases_provider.dart
│   │   │   ├── use_cases_provider.g.dart
│   │   │   └── use_cases.dart
│   │   └── presentation
│   │       ├── change_password
│   │       │   ├── change_password_page.dart
│   │       │   ├── change_password_ref_x.dart
│   │       │   ├── providers
│   │       │   │   ├── change_password_form_provider.dart
│   │       │   │   ├── change_password_form_provider.g.dart
│   │       │   │   ├── change_password_form_state.dart
│   │       │   │   ├── change_password_provider.dart
│   │       │   │   └── change_password_provider.g.dart
│   │       │   └── widgets_for_change_password.dart
│   │       └── reset_password
│   │           ├── providers
│   │           │   ├── reset_password_form_provider.dart
│   │           │   ├── reset_password_form_provider.g.dart
│   │           │   ├── reset_password_form_state.dart
│   │           │   ├── reset_password_provider.dart
│   │           │   └── reset_password_provider.g.dart
│   │           ├── reset_password_page.dart
│   │           ├── reset_password_ref_x.dart
│   │           └── widgets_for_reset_password_page.dart
|   |   
│   ├── email_verification
│   │   ├── data
│   │   │   ├── email_verification_repo_impl.dart
│   │   │   ├── email_verification_repo_provider.dart
│   │   │   └── email_verification_repo_provider.g.dart
│   │   ├── domain
│   │   │   ├── email_verification_repo_contract.dart
│   │   │   ├── email_verification_use_case_provider.dart
│   │   │   ├── email_verification_use_case_provider.g.dart
│   │   │   └── email_verification_use_case.dart
│   │   └── presentation
│   │       ├── email_verification_page.dart
│   │       ├── email_verification_provider.dart
│   │       ├── email_verification_provider.g.dart
│   │       └── widgets_for_email_verification_page.dart
│   │  
|   |
│   ├── form_fields
│   │   ├── Form_fields README.md
│   │   ├── input_validation
│   │   │   ├── _formz_status_x.dart
│   │   │   ├── email_input.dart
│   │   │   ├── name_input.dart
│   │   │   ├── password__input.dart
│   │   │   ├── password_confirm.dart
│   │   │   └── validation_enums.dart
│   │   ├── legacy
│   │   ├── utils
│   │   │   ├── form_validation_service.dart
│   │   │   └── use_auth_focus_nodes.dart
│   │   └── widgets
│   │       ├── _fields_factory.dart
│   │       ├── app_text_field.dart
│   │       ├── keys_for_widgets.dart
│   │       └── password_visibility_icon.dart
|   |
│   └── profile
│       ├── data
│       │   ├── data_transfer_objects
│       │   │   ├── _user_dto.dart
│       │   │   ├── user_dto_factories_x.dart
│       │   │   └── user_dto_x.dart
│       │   ├── profile_repo_impl.dart
│       │   ├── profile_repo_provider.dart
│       │   ├── profile_repo_provider.g.dart
│       │   └── remote_data_source.dart
│       ├── domain
│       │   ├── entities
│       │   │   ├── _user_entity.dart
│       │   │   ├── user_entity_factories_x.dart
│       │   │   └── user_entity_x.dart
│       │   ├── profile_repo_contract.dart
│       │   ├── profile_use_case_provider.dart
│       │   ├── profile_use_case_provider.g.dart
│       │   └── profile_use_case.dart
│       └── presentation
│           ├── profile__page.dart
│           ├── profile_page_widgets.dart
│           ├── profile_provider.dart
│           └── profile_provider.g.dart
|
|
|
├── main.dart
└── root_view_shell.dart
```

