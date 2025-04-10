/*
===============================
## Provider OBSERVER:
!! Using for logging of provider state (including it initialization, state changing, dispose, etc)
===============================

===============================
## Algorithm to implement Provider Observer

1.  Create file "logger.dart"
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType} is initialized",
  "value exposed": "$value"
}
''');
    super.didAddProvider(provider, value, container);
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType} disposed"
}
''');
    super.didDisposeProvider(provider, container);
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType} updated",
  "previous value": "$previousValue",
  "new value": "$newValue"
}
''');
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}

2. Use this logger in main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ...
  runApp(
    ProviderScope(
      observers: [Logger()],
      child: const MyApp(),
    ),
  );
}

3. Just watch prints in debug console

===============================

===============================
## 


===============================
 */
