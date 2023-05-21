import 'package:receipe_task/utils/network_info.dart';
import '../mock_contants/mock_constants.dart';

class MockNetworkInfoOnline implements NetworkInfo {
  @override
  Future<bool> get isConnected => Future.value(true);

  @override
  String getIP() {
    return MOCK_IP;
  }
}
