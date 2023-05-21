import 'package:flutter_test/flutter_test.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/data/repository_imp/repository_imp.dart';
import 'package:receipe_task/utils/constants/constants.dart';
import '../../../mock_constants/mock_constants.dart';
import '../../../mocks/mock_auth_data_source.dart';
import '../../../mocks/mock_network_info_offline.dart';
import '../../../mocks/mock_remote_data_source.dart';

void main() {
  runTestOffline();
}

void runTestOffline() {
  var remoteDataSource = MockRemoteDataSource();
  var authDataSource = MockAuthDataSource();

  var repositoryImpOffline = RepositoryImp(
    remoteDataSource: remoteDataSource,
    networkInfo: MockNetworkInfoOffline(),
    authDataSource: authDataSource,
  );

  group('Repository offline test', () {
    test('should return a network failure on login', () async {
      var response = await repositoryImpOffline.loginWithFirebase(MOCK_CREDENTIALS);

      expect(true, response.isLeft());
      response.fold((l) => expect(const NetworkFailure(NO_INTERNET), l), (r) => throw SOMETHING_WENT_WRONG);
    });

    test('should return a network failure on get food details', () async {
      var response = await repositoryImpOffline.getCategoryList();

      expect(true, response.isLeft());
      response.fold((l) => expect(const NetworkFailure(NO_INTERNET), l), (r) => throw SOMETHING_WENT_WRONG);
    });

    test('should return a network failure on get category details', () async {
      var response = await repositoryImpOffline.getCategoryList();

      expect(true, response.isLeft());
      response.fold((l) => expect(const NetworkFailure(NO_INTERNET), l), (r) => throw SOMETHING_WENT_WRONG);
    });

    test('should return a network failure on get cusine details', () async {
      var response = await repositoryImpOffline.getCuisineList();

      expect(true, response.isLeft());
      response.fold((l) => expect(const NetworkFailure(NO_INTERNET), l), (r) => throw SOMETHING_WENT_WRONG);
    });
  });
}
