import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../layers_shared/domain_layer_shared/providers_shared/auth_state_provider.dart';
import '../../../layers_shared/domain_layer_shared/providers_shared/auth_state_refresher_provider.dart';
import '../../../layers_shared/presentation_layer_shared/pages_shared/page_not_found.dart';
import '../utils/overlay_navigation_observer.dart';
import '../utils/routes_redirection_service.dart';
import '../app_routes/app_routes.dart';

part 'router_factory.dart';

/// 🔑 Provider key for [GoRouter].
/// ✅ Logic is injected manually via `overrideWith(...)` in `diContainer`.

final goRouter = Provider<GoRouter>((_) => throw UnimplementedError());
