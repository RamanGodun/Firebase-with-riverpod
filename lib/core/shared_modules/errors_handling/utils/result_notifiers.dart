import 'dart:async';
import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/failures_for_domain_and_presentation/extensions/to_ui_failures_x.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils/typedef.dart';

part 'result_notifiers.g.dart';

@Riverpod(keepAlive: false)
class ResultVoidNotifier extends _$ResultVoidNotifier {
  //

  @override
  Future<void> build() async {}

  Future<void> run(ResultFuture<void> result) async {
    state = const AsyncLoading();

    final either = await result;

    state = either.fold(
      (f) => AsyncError(f.toUIModel(), StackTrace.current),
      (_) => const AsyncData(null),
    );
  }
}
