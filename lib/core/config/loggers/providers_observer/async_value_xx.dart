import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Extension to enhance the functionality of [AsyncValue] in Riverpod.
///
/// This extension provides utility methods for better debugging and logging
/// the state of asynchronous values.
extension AsyncValueExtensions<T> on AsyncValue<T> {
  /// Returns a string representation of the current [AsyncValue] state.
  ///
  /// This method helps in debugging by displaying relevant information about
  /// whether the state is loading, contains a value, or has encountered an error.
  String get toStr {
    final content = [
      if (isLoading) 'isLoading: $isLoading',
      if (hasValue) 'value: $valueOrNull',
      if (hasError) 'error: $error',
    ].join(', ');

    return '$runtimeType($content)';
  }

  /// Returns a detailed string with the properties of the current [AsyncValue].
  ///
  /// This method is useful for logging the state, especially when working
  /// with asynchronous providers, as it includes additional flags such as
  /// `isRefreshing` and `isReloading`.
  String get props {
    return '''
isLoading: $isLoading, isRefreshing: $isRefreshing, isReloading: $isReloading
hasValue: $hasValue, hasError: $hasError, value: $valueOrNull
''';
  }
}
