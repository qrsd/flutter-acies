/// Ticker class used by timer in calculator screen.
class Ticker {
  /// Tick function used by timer.
  Stream<int> tick({int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
