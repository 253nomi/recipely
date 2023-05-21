import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:receipe_task/utils/network_info.dart';
import '../mock_constants/mock_constants.dart';
import '../mocks/mock_network_info.dart';

void main() {
  test('should return true on internet connected', () async {
    InternetConnectionChecker checker = MockInternetConnectionChecker();

    when(checker.hasConnection).thenAnswer((realInvocation) => Future.value(true));

    var networkInfoImpl = NetworkInfoImp(checker);
    expect(true, await networkInfoImpl.isConnected);
  });

  test('should return ip of the user', () async {
    InternetConnectionChecker checker = MockInternetConnectionChecker();

    when(checker.addresses).thenAnswer((realInvocation) => <AddressCheckOptions>[
          AddressCheckOptions(
            address: InternetAddress(MOCK_IP, type: InternetAddressType.IPv4),
          )
        ]);

    var networkInfoImpl = NetworkInfoImp(checker);
    var response = networkInfoImpl.getIP();
    expect(MOCK_IP, response);
  });

  test('should return error on no address', () async {
    InternetConnectionChecker checker = MockInternetConnectionChecker();

    when(checker.addresses).thenAnswer((realInvocation) => <AddressCheckOptions>[]);

    var networkInfoImpl = NetworkInfoImp(checker);
    expect(() async => networkInfoImpl.getIP(), throwsA(isA<String>()));
  });

  test('should return error on addresses with only ipv6 ', () async {
    InternetConnectionChecker checker = MockInternetConnectionChecker();

    when(checker.addresses).thenAnswer((realInvocation) => <AddressCheckOptions>[
          AddressCheckOptions(
            address: InternetAddress('2620:0:ccc::2', type: InternetAddressType.IPv6),
          )
        ]);

    var networkInfoImpl = NetworkInfoImp(checker);
    expect(() async => networkInfoImpl.getIP(), throwsA(isA<String>()));
  });
}
