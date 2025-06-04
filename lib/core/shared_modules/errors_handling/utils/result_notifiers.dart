import 'dart:async';
import 'package:flutter/material.dart' show VoidCallback;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/typedef.dart';
import '../failures_for_domain_and_presentation/failure_ui_model.dart';
import 'consumable.dart';
import 'result_aware_handler.dart';

part 'result_notifiers.g.dart';

@Riverpod(keepAlive: false)
class ResultVoidNotifier extends _$ResultVoidNotifier {
  final _handler = ResultAwareHandler<void>();

  Consumable<FailureUIModel>? get failureUIModel => _handler.failureUIModel;

  @override
  FutureOr<void> build() {}

  Future<void> run(ResultFuture<void> future, VoidCallback onSuccess) {
    return _handler.handleResult(future, (_) => onSuccess());
  }
}
