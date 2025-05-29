import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin SafeAsyncState<T> on AutoDisposeAsyncNotifier<T> {
  Object? _key;

  void initSafe() {
    _key = Object();
    ref.onDispose(() => _key = null);
  }

  bool get isAlive => _key != null;

  bool _matches(Object? key) => _key == key;

  Future<void> updateSafely(Future<T> Function() body) async {
    final currentKey = _key;
    final result = await AsyncValue.guard(body);

    if (_matches(currentKey)) {
      state = result;
    }
  }
}
