part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class NotifyDeviceNetworkStatus extends NetworkEvent {
  final bool isOnline;
  const NotifyDeviceNetworkStatus({
    required this.isOnline,
  });
  @override
  List<Object> get props => [isOnline];

  @override
  String toString() => 'NotifyDeviceNetworkStatus { isOnline: $isOnline }';
}

class CheckDeviceNetwork extends NetworkEvent {
  const CheckDeviceNetwork();
  @override
  List<Object> get props => [];
}
