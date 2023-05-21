import 'package:receipe_task/utils/constants/constants.dart';
import 'package:receipe_task/utils/network_info.dart';

class MockNetworkInfoOffline implements NetworkInfo {
  @override
  Future<bool> get isConnected => Future.value(false);

  @override
  String getIP() {
    throw NO_IP_ADDRESS_FOUND;
  }
}
