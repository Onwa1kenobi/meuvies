import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../connectivity.dart';
import 'network_bloc.dart';

abstract class NetworkRepository {
  Future<bool> isDeviceOnline(Bloc bloc);
}

class NetworkRepositoryImpl extends NetworkRepository {
  @override
  Future<bool> isDeviceOnline(Bloc bloc) async {
    Connectivity().onConnectivityChanged.distinct().listen((result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        bloc.add(NotifyDeviceNetworkStatus(isOnline: true));
      } else {
        bloc.add(NotifyDeviceNetworkStatus(isOnline: false));
      }
    });
    return NetworkConnectivity(Connectivity()).isConnectionAvailable();
  }
}
