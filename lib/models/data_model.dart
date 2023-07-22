class DataModel{
  final double time;
  final double speed;

  DataModel({required this.time, required this.speed});

  @override
  String toString() {
    return '{time: $time, speed: $speed}';
  }
}