class Pair<T, U> {
  final T first;
  final U secend;

  const Pair(this.first, this.secend);

  @override
  String toString() => '($first, $secend)';
}