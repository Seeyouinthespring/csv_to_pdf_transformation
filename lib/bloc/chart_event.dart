import '../services/file_service.dart';

abstract class ChartEvent{
  const ChartEvent();
}

class OnInit extends ChartEvent{
  final FileService service;
  OnInit({required this.service});
}

class OnLoading extends ChartEvent{
  OnLoading();
}

class OnCancelLoading extends ChartEvent{
  OnCancelLoading();
}

class OnDurationSwitched extends ChartEvent{
  final int duration;
  OnDurationSwitched({required this.duration});
}