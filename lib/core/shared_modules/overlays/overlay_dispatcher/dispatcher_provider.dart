import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'overlay_status_cubit.dart';
import '_overlay_dispatcher.dart';

final overlayDispatcherProvider = Provider<OverlayDispatcher>((ref) {
  return OverlayDispatcher(
    onOverlayStateChanged: ref.read(overlayStatusProvider.notifier).update,
  );
});

/*

! cal: 
final dispatcher = ref.read(overlayDispatcherProvider);
dispatcher.showOverlay();

 */
