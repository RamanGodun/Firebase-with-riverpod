import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/failures_for_domain_and_presentation/extensions/to_ui_failures_x.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/typedef.dart';
import '../failure_ui_model.dart';
import '../../utils/consumable.dart';

extension AsyncVoidX on StateController<AsyncValue<void>> {
  Future<void> runWithEither(ResultFuture<void> result) async {
    state = const AsyncLoading();

    final either = await result;

    state = either.fold(
      (f) => AsyncError(f.toUIModel(), StackTrace.current),
      (_) => const AsyncData(null),
    );
  }
}

extension ResultFutureX<T> on ResultFuture<T> {
  Future<T> guardAndConsume({
    required void Function(Consumable<FailureUIModel>) onFailure,
  }) async {
    final result = await this;

    return result.fold((f) {
      onFailure(f.toUIModel().asConsumable());
      throw f;
    }, (data) => data);
  }
}
