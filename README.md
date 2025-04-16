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

## 🧱 Architecture

The project follows the **Clean Architecture** principle with full feature encapsulation:

```
lib/
├── core            # Constants, routing, entities, extensions
├── data            # Firebase sources, repositories
├── features        # Feature-oriented logic (SignIn, SignUp, Profile...)
├── presentation    # Pages, shared widgets, theming
```

Each feature consists of:
- `page` — Stateless UI with `ConsumerWidget`
- `provider` — Riverpod provider for async logic
Also in some features there are `widgets` —  UI components for this feature


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

## 🧾 Architectural Decisions

See [`ADR.md`](./ADR.md) for rationale behind architectural choices, Riverpod usage, and Firebase integration patterns.

---

> 📌 For production readiness, consider adding:
> - CI/CD with GitHub Actions
> - Crashlytics monitoring
> - SSL pinning for APIs
> - Golden tests for UI regression

