


### Core Concepts

| Component | Purpose | Example |
|-----------|---------|---------|
| `Failure` | Domain error with type & message | `NetworkFailure("No internet")` |
| `Either<Failure, T>` | Functional result wrapper | `Left(failure)` or `Right(data)` |
| `Consumable<T>` | One-shot UI feedback | Prevents duplicate dialogs |
| `FailureUIEntity` | UI-ready error with icon & i18n | Localized error for display |

---

## 📚 Complete Examples

### Repository Layer
```dart
class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<Failure, User>> getProfile(String uid) =>
    (() async => await _api.fetchUser(uid)).runWithErrorHandling();
    // 👆 Automatically maps any exception to Failure
}
```

### UseCase Layer  
```dart
class GetUserUseCase {
  Future<Either<Failure, User>> call(String uid) => 
    _repository.getProfile(uid);
}
```

### State Management (Riverpod)
```dart
@riverpod
Future<User> user(UserRef ref, String uid) async {
  final result = await getUserUseCase(uid);
  return result.fold(
    (failure) => throw failure, // AsyncValue will catch this
    (user) => user,
  );
}

// In Widget
class UserWidget extends ConsumerWidget {
  Widget build(context, ref) {
    // 👇 Auto-shows error dialogs with retry
    ref.listenRetryAwareFailure(
      userProvider(uid), 
      context,
      ref: ref,
      onRetry: () => ref.invalidate(userProvider(uid)),
    );
    
    final userAsync = ref.watch(userProvider(uid));
    return userAsync.when(
      data: (user) => UserProfile(user),
      loading: () => CircularProgressIndicator(),
      error: (_, __) => SizedBox(), // Error handled by listener
    );
  }
}
```

### State Management (BLoC/Cubit)
```dart
class UserCubit extends Cubit<UserState> {
  Future<void> loadUser(String uid) async {
    emit(UserLoading());
    final result = await getUserUseCase(uid);
    result.fold(
      (failure) => emit(UserError(failure.asConsumable())),
      (user) => emit(UserLoaded(user)),
    );
  }
}

// In Widget  
BlocListener<UserCubit, UserState>(
  listener: (context, state) {
    if (state is UserError) {
      final error = state.failure.consume();
      if (error != null) {
        context.showError(error.toUIEntity());
      }
    }
  },
  child: BlocBuilder<UserCubit, UserState>(
    builder: (context, state) => switch (state) {
      UserLoading() => CircularProgressIndicator(),
      UserLoaded(:final user) => UserProfile(user),
      UserError() => SizedBox(), // Error handled by listener
    },
  ),
)
```

---

## 🔧 Advanced Usage

### Custom Failure Types
```dart
// 1. Define failure type
final class CustomApiFailureType extends FailureType {
  const CustomApiFailureType() : super(
    code: 'CUSTOM_API',
    translationKey: 'failures.custom_api',
  );
}

// 2. Add to exception mapper
extension CustomExceptionMapper on Object {
  Failure mapToFailure([StackTrace? stackTrace]) => switch (this) {
    CustomApiException e => Failure(
      type: const CustomApiFailureType(),
      message: e.message,
    ),
    _ => // ... other mappings
  };
}
```

### Chainable DSL Style
```dart
await getUserUseCase()
  .flatMapAsync((user) => updateProfile(user))
  .recover((failure) => getDefaultUser())
  .then((result) => ResultHandler(result)
    .onFailure((f) => emit(ErrorState(f)))
    .onSuccess((u) => emit(SuccessState(u)))
    .log()
  );
```

### Testing
```dart
test('should handle network failure', () async {
  // Arrange
  when(() => api.getUser()).thenThrow(SocketException('No internet'));
  
  // Act
  final result = await repository.getUser();
  
  // Assert
  await result.expectFailure('NETWORK');
});
```

---

## 🛠️ Configuration

### Add Failure Types
Add new types to `extensible_part/failure_types/`:
```dart
final class PaymentFailureType extends FailureType {
  const PaymentFailureType() : super(
    code: FailureCodes.payment,
    translationKey: LocaleKeys.failures_payment,
  );
}
```

### Add Exception Mappers  
Extend mapping in `extensible_part/exceptions_to_failure_mapping/`:
```dart
// Add to _ExceptionToFailureX.mapToFailure()
PaymentException e => Failure(
  type: const PaymentFailureType(), 
  message: e.message,
),
```

### Customize Icons
Extend `FailureIconX` in `extensible_part/failure_extensions/`:
```dart
IconData get icon {
  if (this is PaymentFailureType) return Icons.payment;
  // ... existing mappings
}
```

---

## 🔍 Troubleshooting

| Problem | Solution |
|---------|----------|
| Errors not showing in UI | Use `ref.listenFailure()` or `BlocListener` |
| Generic error messages | Check exception mappers |
| No retry button | Ensure `failure.isRetryable` returns true |
| Duplicate dialogs | Use `Consumable<FailureUIEntity>` |
| Raw exceptions in logs | Wrap with `.runWithErrorHandling()` |

---

## 📖 API Reference

### Core Extensions

```dart
// Wrap async operations
Future<Either<Failure, T>> runWithErrorHandling()

// Map exceptions to failures  
Failure mapToFailure([StackTrace? stackTrace])

// Convert to UI representation
FailureUIEntity toUIEntity()

// Show error dialog
void showError(FailureUIEntity error)

// Listen for failures (Riverpod)
void listenFailure(provider, context)

// One-shot consumption
T? consume()
```

### Result Handling

```dart
// Classic Either style
result.fold(
  (failure) => handleError(failure),
  (data) => handleSuccess(data),
);

// DSL style
ResultHandler(result)
  .onFailure(handleError)
  .onSuccess(handleSuccess)
  .log();
```

---

## 🧪 Testing

```dart
// Test failure scenarios
await result.expectFailure('NETWORK');
await result.expectSuccess(expectedUser);

// Mock failures
when(() => repository.getUser())
  .thenAnswer((_) async => Left(NetworkFailure()));
```

---

## 🚀 Migration Guide

### From try/catch
```dart
// Before
try {
  final data = await api.getData();
  return data;
} catch (e) {
  throw Exception(e.toString());
}

// After  
return (() async => await api.getData()).runWithErrorHandling();
```

### From custom error classes
```dart
// Before
class NetworkError extends Error { ... }

// After
final class NetworkFailureType extends FailureType { ... }
```

---

## 🏆 Best Practices

### ✅ Do
- Always use `.runWithErrorHandling()` in repositories
- Return `Either<Failure, T>` from all data operations  
- Use `Consumable<FailureUIEntity>` for one-shot UI feedback
- Add specific failure types for different error scenarios
- Test both success and failure paths

### ❌ Don't  
- Let raw exceptions escape repositories
- Show error messages directly in widgets
- Ignore the `consume()` pattern for UI feedback
- Use generic error messages without context
- Skip logging errors

---

## 📦 What's Included

```
errors_handling/
├── core_of_module/           # Core functionality
│   ├── either.dart          # Functional result wrapper
│   ├── failure_entity.dart  # Domain error representation  
│   └── core_utils/          # Extensions and utilities
└── extensible_part/         # Customizable components
    ├── failure_types/       # Specific error types
    ├── exceptions_mapping/  # Exception → Failure mappers
    └── failure_extensions/  # Icons, retry logic, etc.
```

---

## 🤝 Contributing

1. Add new failure types to `extensible_part/failure_types/`
2. Extend exception mapping in `extensible_part/exceptions_mapping/`  
3. Update icons/retry logic in `extensible_part/failure_extensions/`
4. Add tests for new functionality
5. Update documentation

---

## 📄 License

This module is part of your Flutter project. Use it freely within your application.

---

**🎯 Result: Robust, scalable error handling that grows with your app and team.**