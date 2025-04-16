# 🧠 Architecture Decision Record (ADR)

## 📌 Title: Use of Clean Architecture + Riverpod for Firebase-Driven Flutter App

### 📅 Date: 2025-04-16
### 👥 Authors: Core Flutter Team
### 📈 Status: ✅ Accepted

---

## ❓ Context

The goal of this project (`firebase_with_riverpod`) is to provide a **scalable, and testable Flutter boilerplate** that integrates:

- 🔥 **Firebase** (Authentication, Firestore)
- 🧩 **Riverpod** (state management, DI, codegen)
- 🧱 **Clean Architecture** principles
- 🎯 Modern Flutter best practices (hooks, extensions, sealed types)
- 🍏 **iOS/macOS-style UX and theming**

The blueprint is optimized for cross-platform development:

- ✅ Android
- ✅ iOS
- ✅ Web (Firebase config support)

It includes full support for:

- 🆕 Sign Up
- 🔐 Sign In
- 🔁 Password Reset / Change
- ✅ Email Verification
- 🔑 Re-authentication Flow

All features are modularized and designed with **separation of concerns** and **testability** in mind.

---

## ✅ Decision

### 🧱 Architecture

- Clean Architecture with 3 main conceptual layers:
  - `data/`: Firebase repositories, serialization, sources
  - `domain/`: [Planned] Use Cases, Interfaces, Value Objects (future)
  - `presentation/`: Stateless UI with `ConsumerWidget`, feature folders

- `features/`: Modular folders (`sign_in`, `sign_up`, etc.) contain UI, providers, and states
- `core/`: Global routing, constants, theming, extensions, and reusable widgets

### ⚙️ State Management & DI

- ✅ Riverpod 2.0 with `@riverpod` codegen
- ✅ Async Notifiers (`AsyncNotifier`, `Notifier`, `FutureProvider`, etc.)
- ✅ Feature-colocated providers for modularity and scalability
- ✅ Declarative + reactive form validation via `FormStateNotifier`

### 🔐 Firebase Integration

- 🔧 Uses `firebase_auth` and `cloud_firestore`
- 🔁 Async logic wrapped in `AuthRepository` and `ProfileRepository`
- 🔐 `.env`-based config via `flutter_dotenv` for cross-platform setup
- 🔩 FirebaseOptions generated via `EnvFirebaseOptions`

### 🧪 Testing Strategy

- Unit tests (~80%) for all pure logic and providers
- Widget tests (~15%) with mocked state
- Integration tests (~5%) for flows and navigation

Tools: `mockito`, `very_good_analysis`, `build_runner`

---

## 🔍 Alternatives Considered

| Option                     | ✅ Pros                                       | ❌ Cons                           |
|----------------------------|-----------------------------------------------|----------------------------------|
| Bloc                       | Structured, event-based, well-documented      | Boilerplate-heavy, verbose       |
| Provider                   | Lightweight, built-in                         | Poor scalability, no async guards|
| Riverpod (no codegen)      | Simpler to debug                             | More boilerplate                 |
| MVVM / MVC                 | Familiar to native developers                 | Less idiomatic for Flutter       |

✅ **Chosen:** Riverpod 2.0 with codegen + Clean Architecture → provides the best blend of:
- 🚀 Simplicity and power
- 🧼 Clean layering
- 🔄 Automatic DI
- 💪 Testability

---

## 💡 Consequences

- ✅ Clear separation between Firebase logic and UI
- ✅ Highly testable providers and stateless presentation
- ✅ DI and state logic colocated with features
- ⚠️ Requires onboarding for developers unfamiliar with Riverpod/codegen
- ⚠️ Riverpod codegen requires `build_runner`

---

## 🔮 Future Enhancements

1. 🧠 Introduce full `domain/` layer with `UseCases`
2. 📦 Modularize features as Dart packages
3. 🧪 Expand golden + integration test coverage
4. 🔐 Add federated login: Google, Apple, phone
5. 🔁 Add CI/CD with GitHub Actions (tests + analysis)
6. 🧭 Dynamic routing guards based on auth state
7. 📊 Include analytics and crash reporting

---

## 🏷️ Tags

`#CleanArchitecture` `#Riverpod` `#Firebase` `#Flutter` `#ModularDesign` `#StateManagement` `#ArchitectureDecisionRecord`

