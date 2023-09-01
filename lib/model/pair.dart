class Pair<T, U> {
  final T first;
  final U secend;

  const Pair(this.first, this.secend);

  @override
  String toString() => '($first, $secend)';

  @override
  bool operator ==(Object other) {
    Pair pair = other as Pair;
    return first == pair.first && secend == pair.secend;
  }

}