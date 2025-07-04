import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../layers_shared/domain_layer_shared/providers_shared/auth_state_providers.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/page_not_found.dart';
import '../../overlays/overlays_dispatcher/overlay_navigation_observer.dart';
import '../utils/routes_redirection_service.dart';
import '../app_routes/app_routes.dart';

part 'router_factory.dart';

/// 🧩 [routerProvider] — Public-facing provider used in the widget tree.
/// ✅ Supports `.select(...)` for optimized rebuilds.
/// 💡 Always use `ref.watch(routerProvider)` in the UI layer instead of `goRouter`.

final routerProvider = Provider<GoRouter>((ref) => ref.watch(goRouter));

////

////

/// 🧭 [goRouter] — Low-level DI token for GoRouter instance.
/// ✅ Overridden in the global DI container with `buildGoRouter(...)`.
/// 🚫 Should not be used directly in the widget tree.

final goRouter = Provider<GoRouter>((_) => throw UnimplementedError());

/*
? створити Provider<GoRouter>, використовувати .select((r)=>r) або .watch(routerProvider) у верху дерева,
? і передати результат в MaterialApp.router. Офіційні гайди підтверджують це як best practice 
 */
