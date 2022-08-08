import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meuvies/util/values/strings.dart';

import '../errors.dart';

enum ConnectivityStatus { online, offline }

class NetworkConnectivity {
  Connectivity connectivity;

  NetworkConnectivity(this.connectivity);

  Future safeNetworkCall(Future Function() call) async {
    var connectivityResult = await (connectivity.checkConnectivity());

    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      throw AppNetworkError(AppStrings.networkAvailabilityError);
    } else {
      try {
        return await call().timeout(const Duration(seconds: 60), onTimeout: () {
          throw AppNetworkError(AppStrings.networkAvailabilityError);
        });
      } on SocketException catch (_) {
        // Just in case we miss any one ;)
        throw AppNetworkError(AppStrings.networkAvailabilityError);
      } catch (e) {
        if (e is AppError && e.message.contains('Exception')) {
          throw AppNetworkError(AppStrings.networkAvailabilityError);
        }
        rethrow;
      }
    }
  }

  Future<bool> isConnectionAvailable() async {
    var connectivityResult = await (connectivity.checkConnectivity());
    return connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;
  }
}
