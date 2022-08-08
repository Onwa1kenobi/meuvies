import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'network_repository.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final NetworkRepository _networkRepository;

  NetworkBloc(this._networkRepository) : super(InitialNetworkState()) {
    on<CheckDeviceNetwork>((event, emit) async {
      final isOnline = await _networkRepository.isDeviceOnline(this);
      if (isOnline) {
        emit(OnlineState());
      } else {
        emit(OfflineState());
      }
    }, transformer: droppable());

    on<NotifyDeviceNetworkStatus>((event, emit) async {
      if (event.isOnline) {
        emit(OnlineState());
      } else {
        emit(OfflineState());
      }
    }, transformer: droppable());
  }
}
