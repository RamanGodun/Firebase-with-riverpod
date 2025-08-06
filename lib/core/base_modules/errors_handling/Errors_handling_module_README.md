   # Errors Handling Module Guide
*Last updated: 2025-08-05*

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)

   ## 🎯 Goal 

>   Module was designed as a **enterprise-grade, platform-agnostic, modular, type-safe error handling system**
for Flutter apps with clean architecture codebase, declarative error flows and easy integration of overlays, localization, logging, additional chainable logic.
Currently it consist only a few FailureType erorrs (shown as an example), that easily can be extended by any specific FailureType


----------------------------------------------------------------

   ## 🚀 Quick Start

### 1. Integrate Error Handling Core

* Add `core_of_module/` and `extensible_part/` to your project.*
* No external dependencies on any state management package.

------------

### 2. Handle errors in 3 steps

* 1. - In Repository - wrap operations

```dart
@override
ResultFuture<UserEntity> getProfile({required String uid}) =>
  (() async => await _cacheManager.execute(uid, () => _fetchProfile(uid)))
  .runWithErrorHandling();
```

* 2. - In UseCase return Either, then in Presentation layer manage failures via chosen 
state manager and emit errors state in UI

```dart
final result = await getUserUseCase();
result.fold(
  (failure) => emit(UserError(failure.asConsumable())),
  (user) => emit(UserLoaded(user)),
);
// Auto-logging, localized messages, optional retry buttons, consistent UI
```

* 3. - Handle erors in via chosen UX pattern (e.g. via overlays)

**BLoC/Cubit specific usage:**
```dart
BlocListener<Cubit, State>(
  listenWhen: ..., 
  listener: (context, state) {
    final failure = state.failure?.consume(); // for guaranteeing one-shot feedback.
    if (failure != null) {
      final failureUIEntity = failure.toUIEntity();
      context.showError(failureUIEntity);
      ...
      context.read<Cubit>().clearFailure();
      ...
    }
  },
)
```

**Riverpod specific usage**
Uses `ref.listenFailure(failure.toUIEntity)` — adaptive listener for failures.

```dart
 @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ❗️ Listen and display any async errors as overlays
    ref.listenFailure(profileProvider(uid), context);
    ...

// where:
extension FailureListenerRefX on WidgetRef {
  void listenFailure<T>(
    ProviderListenable<AsyncValue<T>> provider,
    BuildContext context, {
    ListenFailureCallback? onFailure,
  }) {
    listen<AsyncValue<T>>(provider, (prev, next) {
      final failure = next.asFailure;
      if (failure != null) {
        final failureUIEntity = failure.toUIEntity();
        context.showError(failureUIEntity);
      }
    });
  }
}


```



* That's it!*

   **Also**:
- ✅ Errors are automatically mapped from exceptions to domain failures
- ✅ Every public method returns `ResultFuture<T> = Future<Either<Failure, T>>`.
- ✅ Avaiable aditional logic, logging to console/crashlytics  
- ✅ Automatical localization via `translationKey` in `FailureType` (see `failure_type.dart`)




----------------------------------------------------------------

   ## 🧩 Errors Handling Flow

   ### High-Level Flow
1. * Exceptions or Failures originate strictly in the data layer. 
     All unexpected errors are thrown only in Data layer.
2. * Exception mapping to Failure. 
     In Repos, exceptions are mandatory mapps to domain-level `Failure` via `.mapToFailure()` (see `_exceptions_to_failures_mapper_x`).
3. * Returning Failure as Either
     All repository methods return `Either<Failure, T>`; no exceptions are leaked.
4. * Failure mapped to FailureUIEntity
     Via `.toUIEntity()` Ffor all overlays, dialogs, and user feedback.
5. **Display in UI layer**
   * **Riverpod:** Call `ref.listenFailure` in the widget tree — overlays/dialogs are handled automatically.
   * **Cubit/BLoC:** Use `Consumable<FailureUIEntity>`, `BlocListener`, and `context.showError(failure.toUIEntity)`.
6. **Optional Chainable DSL, Logging, Analytics**
   — Use (if needed) chainable error handlers or built-in extensions: `.log()`, analytics, diagnostics, and custom hooks.

------

## 🏗️ Architecture Overview

```mermaid
graph TD
    A[Exception/Error] -->|mapToFailure()| B[Failure]
    B -->|toUIEntity()| C[FailureUIEntity]
    C -->|context.showError()| D[User Sees Dialog]
    
    E[DataSource] -->|throws| F[Repository]
    F -->|Either<Failure,T>| G[UseCase]
    G -->|Either<Failure,T>| H[StateManager]
    H -->|Consumable<Failure>| I[UI]
```


   ### Example: Error-Driven Flow (Profile Feature)
```
DataSourceImpFile:   Throws exception for unknow flow or Failures for handled cases
  ↓
RepoImpFile:         Exceptions catches and maps to Failure via `.mapToFailure()`, 
  ↓                  Failures pass through, so RepoImpFile returns Either<Failure, T> to UseCase
  ↓
UseCaseFile:         Propagates Either<Failure, T>  to State manager
  ↓
State manager:       Emits error state with Failure
  ↓ 
UI (error listener)  Failure mapps to FailureUIEntity `failure.toUIEntity()`
  ↓
                     UI observes and displays overlay/dialog via one-shot (consumable) pattern
```


   ### Example: UI-Driven Flow
```
User triggers action
  ↓
State manager (Cubit/Notifier) calls UseCase
  ↓
UseCase delegates to Repository
  ↓
Repository calls DataSource, get result (Either or throws)
  ↓
THEN 
     the same flow as in case of "error-driven case"
```


----------------------------------------------------------------

   ## 🧱 Layered Usage 

   ### 🧩 Core Error Handling Concepts

| Concept          | Purpose                                                                          |
| ---------------- | ---------------------------------------------------------------------------------|
| `Failure`        | Domain-level abstraction of error (not just Exception!)                          |
| `FailureUIEntity`| UI-ready error with icon & i18n (presentation model)                             |
| `Consumable<T>`  | Ensures feedback triggers only once (one-shot overlays etc.)                     |
| `.mapToFailure()`| Converts exceptions (SDK, platform, etc) → structured Failure                    |
|-----------------------------------------------------------------------------------------------------|
| `Either<L, R>` -  Functional result wrapper: `Left` = Failure, `Right` = Success;                   |
|  immutable, declarative, enables pattern matching, chaining, and testable error flows               |
|-----------------------------------------------------------------------------------------------------|


   ### 🧱 Layered Responsibilities Table

| Layer          | Responsibilities                                                |
| -------------- | ------------------------------------------------------------------------------------------------ |
| DataSource     | Throws raw Exceptions or Either for handled flows     |
| Repository     | Converts to Either, maps Exception → Failure  | Wraps via safeCall, uses FailureMapper, logs errors |
| UseCase        | Delegates business logic, returns Either      | Pure, stateless, no framework                       |
| StateManager   | Emits state, handles results                  | .fold or DSL for composite flows                    |
| UI Layer       | Shows overlay/feedback, listens to consumable | Triggers overlay only if .consume() is not null     |
| OverlayManager | Renders feedback centralized                  | Uses context.showError(FailureUIEntity)             |
-----------------------------------------------------------------------------------------------------------------------

### **Data Layer (Repository, DataSource):**

* **Central error boundary**, **No Exception leaves the data layer unconverted.**
All async operations are wrapped (be **runWithErrorHandling():**) here, mapping all exceptions to `Failure`.

   




-------------------

   ## **Explicit (classic) Either Style** VS **DSL-like Style** in STATE manager  

   This module supports two alternative paradigms:

   - 🧨 **Either** — Classic, explicit and readable error flow using `Either<Failure, T>` and `.fold(...)`
Suits for simple cases ( `.fold((f) => emit(Error(f)), (v) => emit(Success(v)))`. )

   - 🔗 **DSL-like** — Declarative, chainable alternative inspired by functional programming, using `ResultHandler`, `.match()` and `.matchAsync()` extensions
Suits for complex cases with additional logic (includiing logs, side effects) with DSL-style handler (`ResultHandler`) for chaining.

Examples:
```dart


// **DSL-like** — Declarative, chainable alternative inspired by functional programming
await getUserUseCase().then(
  (r) => ResultHandler(r)
    ..onFailure((f) => emit(ErrorState(f)))
    ..onSuccess((v) => emit(SuccessState(v)))
    ..log(),
);
```

-------------------

### Either: Explicit (Classic) Style

✅ When to Use:
- You want **full control** over success and failure handling
- You prefer **clarity** and **predictable flow**
- Common in Cubit/BLoC/Riverpod state management

🤩 Code Example:
```dart
final result = await someUseCase();
// Classic, explicit and readable error flow
result.fold(
  (failure) => emit(ErrorState(failure)),
  (data) => emit(SuccessState(data)),
);
```

-------------------

### 🧚 DSL-like Style

✅ When to Use:
- You prefer a **chainable API** with fluent handlers
- You want to reduce boilerplate (fold logic repeated often)
- Great for services, reactive flows, or advanced orchestration

#### ✳️ A few variants of usage:

* 1. `matchAsync()` Extension:
```dart
await getUserUseCase().matchAsync(
  onFailure: (f) => emit(Failed(f)),
  onSuccess: (u) => emit(Loaded(u)),
);
```

* 2. DSLLike `ResultHandler`:
```dart
await getUserUseCase().then((r) => ResultHandler(r)
  .onFailure((f) => emit(Failed(f)))
  .onSuccess((u) => emit(Loaded(u))));
```

* 3. `match()` (sync style for `Either<Failure, T>`):
```dart
final result = await getUserUseCase();
result.match(
  onFailure: (f) => emit(Failed(f)),
  onSuccess: (u) => emit(Loaded(u)),
);
```

#### ✨ Avaiable Advanced Chaining:
```dart
await getUserUseCase()
  .flatMapAsync((u) => checkAccess(u))
  .recover((f) => getGuestUser())
  .mapRightAsync((u) => saveLocally(u))
  .then((r) => ResultHandler(r).log());
```




----------------------------------------------------------------

   ## 🧩 Files structure of module

``` plaintext
errors_handling/
.
├── core_of_module
|   |
│   ├── _run_errors_handling.dart
│   ├── either.dart
│   ├── failure_entity.dart
│   ├── failure_type.dart
│   ├── failure_ui_entity.dart
│   ├── failure_ui_mapper.dart
|   |
│   └── core_utils
│       ├── errors_observing
│       │   ├── loggers
│       │   │   ├── crash_analytics_logger.dart
│       │   │   ├── errors_log_util.dart
│       │   │   └── failure_logger_x.dart
│       │   └── result_loggers
│       │       ├── async_result_logger.dart
│       │       └── result_logger_x.dart
│       ├── extensions_on_either
│       │   ├── either__facade.dart
│       │   ├── either__x.dart
│       │   ├── either_async_x.dart
│       │   ├── either_getters_x.dart
│       │   └── for_tests_either_x.dart
│       ├── extensions_on_failure
│       │   └── failure_to_either_x.dart
│       ├── specific_for_bloc
│       │   ├── consumable_extensions.dart
│       │   ├── consumable.dart
│       │   ├── result_handler_async.dart
│       │   └── result_handler.dart
│       └── specific_for_riverpod
│           └── show_dialog_when_error_x.dart
|
├── extensible_part
|   |
│   ├── exceptions_to_failure_mapping
│   │   ├── _exceptions_to_failures_mapper_x.dart
│   │   ├── dio_exceptions_mapper.dart
│   │   └── firebase_exceptions_mapper.dart
|   |
│   ├── failure_extensions
│   │   ├── failure_diagnostics_x.dart
│   │   ├── failure_icons_x.dart
│   │   └── failure_led_retry_x.dart
|   |
│   └── failure_types
│       ├── _failure_codes.dart
│       ├── firebase.dart
│       ├── misc.dart
│       └── network.dart
|
├── docs
└── Errors_handling_module_README.md

```


----------------------------------------------------------------

   ## ❓ FAQ & Troubleshooting

* **How do I add a new Failure type?**
  * Add to `extensible_part/failure_types/` and reference in your mappers.

* **How do I map Dio/Firebase/other exceptions?**
  * Use mappers in `extensible_part/exceptions_to_failure_mapping/`.

* **How do I display overlays/dialogs in Riverpod?**
  * Use `ref.listenFailure(yourProvider, context)`.

* **How do I display overlays in Cubit/BLoC?**
  * Emit `Consumable<FailureUIEntity>`, BlocListener, `context.showError(error)`.

* **How do I log or report errors?**
  * Use `failure.log()`, `failure.logCrashAnalytics()`, or a custom logger.

* **How do I test error flows and overlays?**
  * Use Either or the `.forTests` extension for test flows.

* **How do I add Retry logic?**
  * Expose `canRetry` and a retry handler in Failure or FailureUIEntity.

* **How do I customize error visuals/icons?**
  * Extend `FailureIconsX` or your own UI mappers.

* **Can I use the pipeline in pure Dart/tests/CLI?**
  * Yes, everything except overlay/UI integrations.

* **What is `Consumable<T>`?**
A one-time value wrapper for UI side effects, that:
      - Guarantees one-shot overlays/dialogs
      - Prevents duplicate feedback on rebuilds
      - Declarative and easily testable

* When/Which to choose between **Either (classic)** and **DSL-like** code styles

| ✅ Criteria                      | Either (Classic)| DSL-like Handler     |
| ---------------------------------|----------------|-----------------------|
| ✅ Predictable and explicit      | ✔️ Yes          | ❌ Less explicit      |
| ✅ Declarative & chainable       | ❌ No           | ✔️ Yes                |
| ✅ Requires no extra wrappers    | ✔️ Yes          | ❌ Needs `.then(...)` |
| ✅ Team prefers functional style | ❌ Maybe        | ✔️ Perfect fit        |

> 🧠 **Recommendation:** Use Either by default for UI state management. DSL-style is best for expressive chains and functional flows.




   ### 🛠 Troubleshooting

* **Overlay/dialog not shown in Riverpod:**
  * Use `ref.listenFailure(yourProvider, context)`.

* **Overlay/dialog not shown in Cubit/BLoC:**
  * Use BlocListener, emit `Consumable<FailureUIEntity>`, call `context.showError(...)`.

* **Failure is always generic:**
  * Check your mappers in `exceptions_to_failure_mapping/`.

* **Retry button does not appear:**
  * Ensure `canRetry = true` and provide a retry handler.

* **No logging:**
  * Use `failure.log()` or loggers from `errors_observing/loggers/`.

* **UI shows raw error or stacktrace:**
  * Always map with `toUIEntity()` and display via overlay/dialog.


   ## 🧭 Decision Matrix

| Context                 | Strategy                   | Rationale                               |
| ----------------------- | -------------------------- | --------------------------------------- |
| Complex UX flows        | ResultHandler              | Fluent, side effects, fallback, retry   |
| Simple flows            | .fold() / .match()         | Readable, concise                       |
| SDK/API errors          | ASTRODES throw             | Thrown, mapped to Failure in repo       |
| Domain failures         | Either                     | As-is, no throwing                      |
| Consistent result shape | ResultFuture<T>            | Standardized async everywhere           |
| Exception handling      | safeCall() extension       | Centralizes all error mapping           |
| Failure-to-UI           | .toUIEntity()              | UI-ready error with icons, i18n         |
| UI trigger              | context.showError()        | Declarative, one point for all overlays |
| One-time feedback       | Consumable<FailureUIEntity>| Prevents duplicate overlays             |



----------------------------------------------------------------

   ## ⚡️ Best Practices

* **Use only Failure as the error source** — never expose raw Exception or strings in public APIs.
* **Map all exceptions to Failure ASAP** via `.mapToFailure()`.
* **Isolate mapping logic** for 3rd-party exceptions (dio, firebase, etc.) in dedicated files.
* **Never display raw errors inline in widgets** — always use overlays/dialogs via provided extensions.
* **For Cubit/BLoC:** Always use `Consumable<FailureUIEntity>` for one-shot overlays.
* **For Riverpod:** Always attach `ref.listenFailure` in your widgets.
* **Log all errors via provided extensions** (`failure.log()`) before reporting or displaying.
* **Test all error flows using functional result types (Either) or pure Dart logic.**
* **Avoid coupling error handling with business/state/UI logic:** keep overlays, mapping, and logging separate.
* **Add new failure types/extensions in `extensible_part/`.**
* **Document custom mappings or overlays for your team.**



----------------------------------------------------------------

 ## ✅ Final Notes

---

### 🏆 **Key Principles**

- 🦾 **Universal & State-Agnostic**  
  Seamlessly works with Riverpod, Cubit/BLoC, or pure Dart — zero vendor lock-in.

- 💪 **Optimized for real-world teams & codebases**  
  Suitable for projects of any size or complexity. 

- ⚡️ **Decoupled Error Flow**  
  Mapping, logging, UI overlays, and retry logic are modular and isolated.  

- 🔒 **Strictly type-safe & future-proof**  
  No raw exceptions or magic strings leak outside the data layer. 

- 🧩 **Single Source of Truth**  
  All domain-errors are modeled as `Failure`, UI errors - as `FailureUIEntity`, enforcing clean boundaries. 

- 📐 **Clean Architecture by Design**  
  Each layer (DataSource, Repository, UseCase, StateManager, UI) has a clear, decoupled responsibility.


---


### 💡 **Benefits**

- 🧑‍💻 **Collaboration-Ready**  
  Explicit contracts and clear boundaries make onboarding and teamwork effortless.  
- 📚 **Self-Documenting & Discoverable**  
  Flows, extensions, and usage are easily found and understood via intuitive docs and naming.  
- 🔄 **Easy Refactoring & Maintenance**  
  Change or extend any layer with confidence; no hidden coupling or side effects.  
- 🚦 **Safe by Default**  
  Every error is either surfaced to the user or logged/tracked — never lost.  
- ⏳ **Minimal Boilerplate**  
  Declarative patterns let teams focus on features, not glue spaghetti code.



> **Build robust, scalable Flutter apps with declarative error handling and architecture-first philosophy.**  
> Your error handling will remain robust and maintainable — no matter how fast your product or team grows.

🧪 Happy error handling & bulletproof code! ☕️


----------------------------------------------------------------