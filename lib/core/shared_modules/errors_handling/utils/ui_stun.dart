sealed class UIStun {
  const UIStun();
}

final class FreezeStun extends UIStun {
  final String message;
  const FreezeStun(this.message);
}

final class SilentStun extends UIStun {
  const SilentStun();
}
