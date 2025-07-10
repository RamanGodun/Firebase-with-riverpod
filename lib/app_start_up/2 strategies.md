Unified App Bootstrap & Lazy DI Pattern

Applies to: Flutter apps using Riverpod, BLoC, or GetIt for dependency injection and state management.

⸻

1. Motivation
	•	Scale your architecture for large apps, migration between state management libraries, and async/lazy initialization of critical services.
	•	Achieve a seamless UX for app startup (loader, error, main app), regardless of DI engine.

⸻

2. Core Principles
	•	Centralized Readiness State: Single source of truth for app bootstrap status (loading/ready/error/progress).
	•	Proxy/Lazy DI: All heavy or async dependencies are injected via proxies that return null, placeholder, or fallback until fully ready.
	•	UI Reactivity: UI is declarative and always responds to readiness changes, showing loader, error, or main shell.
	•	Timeouts & Retry: Bootstrap phase includes timeout handling and retry options for user-friendly recovery.

⸻

3. Central Readiness State

Store app readiness status in a global singleton/provider/cubit.

Sealed class pattern (recommended for strict null safety and extensibility):

sealed class AppReadyState {}
class AppInitial extends AppReadyState {}
class AppLoading extends AppReadyState {
  final double? progress;
  final String? currentStep;
  AppLoading({this.progress, this.currentStep});
}
class AppReady extends AppReadyState {}
class AppError extends AppReadyState {
  final String message;
  final bool canRetry;
  AppError(this.message, {this.canRetry = false});
}

Implementation examples:
	•	Riverpod

final appReadyProvider = StateProvider<AppReadyState>((ref) => AppInitial());


	•	BLoC

class AppReadyCubit extends Cubit<AppReadyState> { /* ... */ }


	•	GetIt

GetIt.I.registerSingleton<ValueNotifier<AppReadyState>>(ValueNotifier(AppInitial()));



⸻

4. Lazy Proxy Injection & Fallbacks

All services (routers, repositories, etc) are accessed via a proxy.
Proxy can return null, a placeholder, or a fallback implementation if main dependency is not ready.

Examples:
	•	Riverpod

final routerProvider = Provider<GoRouter>((ref) {
  final state = ref.watch(appReadyProvider);
  return switch (state) {
    AppReady() => ref.read(fullRouterProvider),
    AppError() => ref.read(errorRouterProvider),
    _ => ref.read(loaderRouterProvider), // fallback router for loading/error
  };
});


	•	Fallback for critical services:

final profileRepoProvider = Provider<IProfileRepo>((ref) {
  final state = ref.watch(appReadyProvider);
  if (state is AppReady) return ref.read(productionProfileRepoProvider);
  return const StubProfileRepo(); // fallback stub
});



⸻

5. Bootstrap Lifecycle
	1.	Minimal bootstrap
	•	Initialize Flutter, logging, theme, local storage, etc.
	•	Register baseline providers/singletons (can be GetIt, ProviderContainer, BlocProvider).
	2.	RunApp
	•	Show loader UI bound to readiness state.
	3.	Full/async bootstrap with timeout & retry
	•	In background, load all heavy/async dependencies with timeout.
	•	On failure/timeout, expose error state with a retry flag.
	•	While loading, update readiness state to AppLoading(progress, step).
	•	When finished, set readiness state to AppReady(). Proxies now return real dependencies.
	4.	Declarative UI rendering
	•	UI watches readiness state and proxy providers/blocs.
	•	Shows loading screen (with optional progress/step), error shell (with retry), or full app as needed.

⸻

6. Example: Unified Main Entry with Timeout & Retry

Future<void> main() async {
  await initMinimal();
  runApp(AppBootstrapper());
  bootstrapInBackground();
}

void bootstrapInBackground([WidgetRef? ref]) async {
  try {
    // Optionally update progress during steps:
    // ref?.read(appReadyProvider.notifier).state = AppLoading(progress: 0.3, currentStep: "Loading user...");
    await initHeavyServices().timeout(const Duration(seconds: 30));
    // Set ready:
    // Riverpod: ref?.read(appReadyProvider.notifier).state = AppReady();
    // BLoC: context.read<AppReadyCubit>().emit(AppReady());
    // GetIt: GetIt.I<AppReadyStateNotifier>().value = AppReady();
  } on TimeoutException {
    ref?.read(appReadyProvider.notifier).state =
        AppError('Initialization timeout. Please try again.', canRetry: true);
  } catch (e) {
    ref?.read(appReadyProvider.notifier).state =
        AppError(e.toString(), canRetry: true);
  }
}


⸻

7. UI Shell Example with Retry

final readiness = ref.watch(appReadyProvider);

return switch (readiness) {
  AppReady() => MaterialApp.router(...),
  AppError(:final message, :final canRetry) => ErrorShell(message: message, onRetry: canRetry ? () => bootstrapInBackground(ref) : null),
  AppLoading(:final progress, :final currentStep) => LoaderShell(progress: progress, step: currentStep),
  _ => LoaderShell(),
};


⸻

8. Testing Best Practices
	•	Mock all possible readiness states (AppInitial, AppLoading, AppReady, AppError).
	•	For DI proxies: Test both the fallback and the real implementation.
	•	For UI: Snapshot/golden tests for loader, error, main app shells.
	•	For services: Always provide test doubles/stubs via DI (e.g., StubProfileRepo, FakeRouter).
	•	Test timeouts and retry logic explicitly.

Example (Riverpod):

testWidgets('shows retry on error', (tester) async {
  final container = ProviderContainer(overrides: [
    appReadyProvider.overrideWith((_) => AppError('fail', canRetry: true)),
  ]);
  await tester.pumpWidget(ProviderScope(parent: container, child: AppBootstrapper()));
  expect(find.byType(ErrorShell), findsOneWidget);
  // Simulate tap on retry, test retry flow
});


⸻

9. Adaptation for Small Apps
	•	Keep only a centralized readiness state.
	•	Omit proxy/fallback for DI — use direct injection (e.g., always use real router/service, as no async bootstrapping is needed).
	•	Use a simple enum or sealed with only initial, ready, error states.
	•	Loader and error UI may be just a couple of widgets.

Example:

final appReadyProvider = StateProvider<AppReadyState>((ref) => AppReadyState.initial);

enum AppReadyState { initial, ready, error }

	•	DI is synchronous, and all services are available from the start.

⸻

10. Advantages
	•	Portable between Riverpod, BLoC, Provider, GetIt.
	•	Supports async/lazy DI, complex bootstraps, fallbacks, timeouts & retry.
	•	Minimal UI code changes when switching state management.
	•	Clean, declarative, and highly testable.
	•	Strictly null safe when using sealed classes.

⸻

11. References
	•	Flutter State Management
	•	Riverpod Documentation
	•	Bloc Documentation
	•	GetIt Documentation
	•	VeryGoodOpenSource Patterns
