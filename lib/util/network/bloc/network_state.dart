part of 'network_bloc.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

class InitialNetworkState extends NetworkState {}

class OfflineState extends NetworkState {}

class OnlineState extends NetworkState {}
