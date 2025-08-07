

#### 1. Create your form provider:

```dart
final signInFormProvider = StateNotifierProvider<SignInForm, SignInFormState>(
  (ref) => SignInForm(),
);
```

#### 2. Create your submit action:

```dart
final signInProvider = AsyncNotifierProvider<SignIn, void>(
  SignIn.new,
);
```

#### 3. Wire form fields

```dart
final form = ref.watch(signInFormProvider);
final notifier = ref.read(signInFormProvider.notifier);

InputFieldFactory.create(
  type: InputFieldType.email,
  focusNode: focus.email,
  errorText: form.email.uiErrorKey,
  onChanged: notifier.emailChanged,
);
```

#### 4. Submit with validation guard

```dart
ElevatedButton(
  onPressed: form.isValid
    ? () => ref.read(signInProvider.notifier).submit()
    : null,
  child: Text('Sign In'),
);
```

> 🧠 Use `.uiErrorKey` in UI, and `form.isValid` for enabling/disabling submit.



### 🟦 Cubit Integration

Cubit/BLoC apps can integrate this module by connecting input changes to a `Cubit` and using `BlocSelector` to rebuild only affected fields.

#### 1. Provide the cubit

```dart
BlocProvider(
  create: (_) => SignInCubit(),
  child: SignInPage(),
);
```

#### 2. Use `BlocSelector` to wire form fields

```dart
BlocSelector<SignInCubit, SignInState, EmailInputValidation>(
  selector: (state) => state.email,
  builder: (_, email) {
    return InputFieldFactory.create(
      type: InputFieldType.email,
      focusNode: focus.email,
      errorText: email.uiErrorKey,
      onChanged: context.read<SignInCubit>().emailChanged,
    );
  },
);
```

#### 3. Submit via state

```dart
ElevatedButton(
  onPressed: context.read<SignInCubit>().state.isValid
    ? context.read<SignInCubit>().submit
    : null,
  child: Text('Sign In'),
);
```

#### 4. Listen for failure/success using `BlocListener`

```dart
BlocListener<SignInCubit, SignInState>(
  listenWhen: (p, c) => c.failure case Consumable(failure: final f),
  listener: (_, state) => showError(state.failure!),
  child: YourFormBody(),
);
```

> 🟦 Use `BlocSelector` to keep widgets scoped and performant. Combine with `.uiErrorKey` for clean UX.



