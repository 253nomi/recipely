import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:receipe_task/utils/constants/constants.dart';

/// Abstract Class for providing network info
/// [isConnected] method is used for testing
abstract class NetworkInfo {
  /// This method tells whether the system is connected with the internet or not
  Future<bool> get isConnected;

  /// This method returns the IP with which the user is connected
  /// Output : returns the string as output
  String getIP();
}

/// [NetworkInfoImpl] implementation of [NetworkInfo]
/// Provides info regarding the network info using network info package
class NetworkInfoImp implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImp(this.connectionChecker);

  /// This method provides info regarding network connectivity using InternetConnectionChecker
  /// Output: [bool] tells whether connected to internet or not
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  String getIP() {
    if (connectionChecker.addresses.isEmpty) {
      throw NO_IP_ADDRESS_FOUND;
    }

    var ip4List = connectionChecker.addresses.where((element) => element.address!.type == InternetAddressType.IPv4).toList();

    if (ip4List.isEmpty) {
      throw NO_IP_ADDRESS_FOUND;
    }

    return ip4List.last.address!.address;
  }
}
