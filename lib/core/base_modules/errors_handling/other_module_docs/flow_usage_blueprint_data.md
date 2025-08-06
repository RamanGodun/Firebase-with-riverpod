## BEST USAGE/EXAMPLES

### 🧩 Core Error Handling Concepts

| Concept             | Purpose                                                       |
| ------------------- | ------------------------------------------------------------- |
| `Failure`           | Domain-level abstraction of error                             |
| `FailureUIModel`    | Visual + localized error model used by UI                     |
| `Consumable<T>`     | Ensures feedback triggers only once                           | 
| `FailureMapper`     | Converts caught ASTRODES exceptions to structured Failure type|



### ✅ In Data Layer:

 **Central error boundary-managing** is in data layer (errors handles in RepoImplementation file, optionally 
specific Failure can be thrown of in DataSourceImplementation file), converting all outcomes to the unified Either format. 
> In the end of the day every public method returns a standardized shape:  `ResultFuture<T> = Future<Either<Failure, T>>`

* When throwns exceptions (ASTRODES), then errors are catched in repoImpl by ".runWithErrorHandling()", 
maps to domain-level `Failure` using ` Failure mapToFailure([StackTrace? stackTrace]) => switch (this) {...}` 
and returns as `Left(Failure)` via Either

* For expected failures (Either-style):
  - Forwards the `Either<Failure, T>` result directly, returns them **as-is**. 

* Typed results (`Either<Failure, T>`) at every transition point


Example of usage:
```dart
 /// Returns cached user if fresh, otherwise fetches from remote
  @override
  ResultFuture<UserEntity> getProfile({required String uid}) =>
      (() async {
        return await _cacheManager.execute(uid, () => _fetchProfile(uid));
      }).runWithErrorHandling();

  /// Force refresh profile (bypasses cache)
  ResultFuture<UserEntity> refreshProfile({required String uid}) =>
      (() async {
        return await _cacheManager.execute(
          uid,
          () => _fetchProfile(uid),
          forceRefresh: true,
        );
      }).runWithErrorHandling();

  /// Fetches user profile from remote source
  Future<UserEntity> _fetchProfile(String uid) async {
    final data = await _remoteDatabase.fetchUserMap(uid);
    if (data == null)
      throw const Failure(
        type: UserNotFoundFirebaseFailureType(),
        message: 'User not found',
      );
    final dto = UserDTOFactories.fromMap(data, id: uid);
    return dto.toEntity();
  }


where:

/// [ResultFutureExtension] - Extension for async function types.
/// Provides a declarative way to wrap any async operation
/// with failure mapping and functional error handling.
//
extension ResultFutureExtension<T> on Future<T> Function() {
  //
  /// Executes the function, returning [Right] on success,
  /// or [Left] with mapped [Failure] on error.
  Future<Either<Failure, T>> runWithErrorHandling() async {
    try {
      final result = await this();
      return Right(result);
    } catch (e, st) {
      // return ExceptionToFailureMapper.from(e, st).toLeft<T>();
      // 🧼 Logging and mapping built-in here
      ErrorsLogger.log(e, st);

      ///🛡️ Ensures that [e] is domain-level [Failure], otherwise converts any caught raw exceptions into [Failure].
      final failure = e is Failure ? e : e.mapToFailure(st);
      return failure.toLeft<T>();
      //
    }
  }
}
```



### ✅ In Domain Layer (UseCase):

* Implements **pure business logic**, delegates to repositories.
* Always returns: `ResultFuture<T> = Future<Either<Failure, T>>`
* Can use `.flatMap()` or `.mapRight()` for additional logic
* No platform or framework dependencies
* Delegates logic



### ✅ In Presentation Layer:


#### In State manger (Cubit/BLoC/Riverpod Notifier etc)

Responsibily for **handling results and emitting states**.

* **Simple cases** use classical:

  ```dart
  result.fold(
    (f) => emit(ErrorState(f)),
    (v) => emit(SuccessState(v)),
  );
  ```

* **Complex flows** use:

  ```dart
  await getUserUseCase().then(
    (r) => DSLLikeResultHandler(r)
      ..onFailure((f) => emit(ErrorState(f)))
      ..onSuccess((v) => emit(SuccessState(v)))
      ..log(),
  );
  ```

> Module supports both `.fold()` and DSL-like handler styles.
  DSL-like syntax is more readable for flows with multiple chained steps, recover, or fallback logic.

> Use DSL **when**: 
  - you need `.log()`, `.track()`, `.redirect()`, etc.
  - UX feedback is composite (reset form, delay, retry)

> UI layer keeps stateless, reactive, testable, and internationalized.






#### ✅ BLoC/CIBIT specific Presentation Layer (UI)

Listens for `state.failure` which is:
  * A `Consumable<FailureUIModel>`
  * Mapped from `Failure` via `.toUIModel()`

* Visual feedback is delegated to `OverlayDispatcher`:
  ```dart
      /// 🔄 [_SignUpListenerWrapper] — Bloc listener for one-shot error feedback.
      /// ✅ Uses `Consumable<FailureUIModel>` for single-use error overlays.
      BlocListener<SignUpCubit, SignUpState>(
        listenWhen:
            (prev, curr) =>
                prev.status != curr.status && curr.status.isSubmissionFailure,

        /// 📣 Show once retryable dialog if supported, otherwise info dialog
        /// and then reset failure + status
        listener: (context, state) {
          final error = state.failure?.consume();
          if (error != null) {
            if (error.isRetryable) {
              context.showError(
                error.toUIEntity(),
                showAs: ShowAs.dialog,
                onConfirm: OverlayUtils.dismissAndRun(
                  () => context.read<SignUpCubit>().submit(),
                  context,
                ),
                confirmText: AppLocalizer.translateSafely(
                  LocaleKeys.buttons_retry,
                ),
              );
            } else {
              context.showError(error.toUIEntity(), showAs: ShowAs.infoDialog);
            }

            context.read<SignUpCubit>()
              ..resetStatus()
              ..clearFailure();
          }
        },
  ```


#### ✅ Riverpod specific Presentation Layer (UI)

Listens for `state.failure` which mapped from `Failure` via `.toUIModel()`

        
  ```dart
  extension FailureListenerRefX on WidgetRef {
  ...
  /// 🧠 [listenRetryAwareFailure] — adaptive listener for retryable vs non-retryable [Failure]s
  /// ✅ Automatically chooses appropriate handling strategy
  ///
  void listenRetryAwareFailure<T>(
    ProviderListenable<AsyncValue<T>> provider,
    BuildContext context, {
    required WidgetRef ref,
    required VoidCallback onRetry,
    ShowAs showAs = ShowAs.infoDialog,
    ListenFailureCallback? onFailure,
  }) {
    ref.listen<AsyncValue<T>>(provider, (prev, next) {
      final failure = next.asFailure;
      if (failure == null) return;

      // Optional failure-specific hook
      onFailure?.call(failure);

      // 🔁 If retryable — show dialog with retry
      if (failure.isRetryable) {
        context.showError(
          showAs: ShowAs.dialog,
          failure.toUIEntity(),
          onConfirm: OverlayUtils.dismissAndRun(onRetry, context),
          confirmText: AppLocalizer.translateSafely(LocaleKeys.buttons_retry),
        );
      }
      // ❌ Otherwise — just show passive error info dialof
      else {
        context.showError(failure.toUIEntity());
      }
    });
  }
  ...


  Widget build(BuildContext context, WidgetRef ref) {
    //
    /// 🧠🔁 Intelligent failure listener (declarative side-effect for error displaying) with optional "Retry" logic.
    ref.listenRetryAwareFailure(
      signInProvider,
      context,
      ref: ref,
      onRetry: () => ref.submit(),
    );

        },
  ```





---



### ✅ Summary



#### 🧱 Layered Responsibilities

| Layer / Component     | Role                                     | Best Practice                                                                    |
| --------------------- | ---------------------------------------- | -------------------------------------------------------------------------------- |
| **DataSource**        | Accesses raw data (SDK, API, platform)   | Hybrid approach: `throw` for ASTRODES, return `Either<Failure, T>` for Either      |
| **Repository**        | Converts outcomes to Either format         | Wraps calls via `safeCall` / `safeCallVoid`, uses `FailureMapper` for exceptions |
| **FailureMapper**     | Converts exceptions into domain failures | Central mapping layer; supports Crashlytics, debug logging                       |
| **UseCase**           | Delegates logic and returns result       | Standard: `ResultFuture<T>` = `Future<Either<Failure, T>>`; pure, framework-free |
| **Cubit / Notifier**  | Handles result and emits state           | Uses `.fold()` for simple flows, DSL handler for UX feedback & chaining          |
| **UI Layer**          | Displays feedback based on state         | Observes `Consumable<FailureUIModel>`, triggers overlay if `.consume() != null`  |
| **OverlayDispatcher** | Renders visual feedback centrally        | Uses `context.showError(...)` with `FailureUIModel`                      |

---




---

#### 🧭 Decision Matrix

| Context                     | Preferred Strategy                 | Rationale                                                          |
| --------------------------- | ---------------------------------- | ------------------------------------------------------------------ |
| Complex UX flows            | ✅ `DSLLikeResultHandler`           | Fluent control for logs, side effects, fallback, or retry chains   |
| Basic success/failure logic | ✅ `.fold()` / `.match()`           | Simple, concise, readable                                          |
| SDK/API/Platform errors     | ✅ ASTRODES                         | Thrown, then caught in repo and mapped via `FailureMapper`         |
| Known domain failures       | ✅ Either                             | Returned as `Either<Failure, T>` without throwing                  |
| Result shape                | ✅ `ResultFuture<T>` everywhere     | Standardized async result format in all layers                     |
| Exception handling          | ✅ `safeCall()` or `safeCallVoid()` | Captures and maps low-level errors to Either                         |
| Failure-to-UI mapping       | ✅ `.toUIModel()`                   | Produces consistent UI-ready error with icon & translation support |
| UI delivery trigger         | ✅ `context.showError(...)` | Unified mechanism for showing user-facing errors                   |
| Feedback one-time handling  | ✅ `Consumable<FailureUIModel>`     | Ensures overlays shown once per failure emission                   |

---




### 🧩 What is `Consumable<T>`?

`Consumable<T>` is a one-time value wrapper for safe UI feedback triggers.
**Advantages:**
* Guarantees one-shot side effects
* Prevents duplicate feedback on rebuilds
* Declarative and testable

---


