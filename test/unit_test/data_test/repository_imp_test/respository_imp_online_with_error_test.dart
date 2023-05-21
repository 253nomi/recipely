import 'package:flutter_test/flutter_test.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/data/repository_imp/repository_imp.dart';
import 'package:receipe_task/utils/constants/constants.dart';
import '../../../mock_constants/mock_constants.dart';
import '../../../mocks/mock_auth_data_source_error.dart';
import '../../../mocks/mock_network_info_online.dart';
import '../../../mocks/mock_remote_data_source_error.dart';

void main() {
  runTestOnlineWithErrors();
}

void runTestOnlineWithErrors() {
  var remoteDataSource = MockRemoteDataSourceError();
  var authDataSource = MockAuthDataSourceError();

  var repositoryImpOnlineWithError = RepositoryImp(
    remoteDataSource: remoteDataSource,
    networkInfo: MockNetworkInfoOnline(),
    authDataSource: authDataSource,
  );

  group('Repository online test wth error', () {
    test('should return a server failure', () async {
      var response = await repositoryImpOnlineWithError.loginWithFirebase(MOCK_CREDENTIALS);

      expect(true, response.isLeft());
      response.fold((l) => expect(const ServerFailure(SOMETHING_WENT_WRONG), l), (r) => throw SOMETHING_WENT_WRONG);
    });

    test('should return a server failure on get food details', () async {
      var response = await repositoryImpOnlineWithError.getFoodList();

      expect(true, response.isLeft());
      response.fold((l) => expect(const ServerFailure(SOMETHING_WENT_WRONG), l), (r) => throw SOMETHING_WENT_WRONG);
    });

    test('should return a server failure on get category list', () async {
      var response = await repositoryImpOnlineWithError.getCategoryList();

      expect(true, response.isLeft());
      response.fold((l) => expect(const ServerFailure(SOMETHING_WENT_WRONG), l), (r) => throw SOMETHING_WENT_WRONG);
    });

    test('should return a server failure on get cuisine list', () async {
      var response = await repositoryImpOnlineWithError.getCuisineList();

      expect(true, response.isLeft());
      response.fold((l) => expect(const ServerFailure(SOMETHING_WENT_WRONG), l), (r) => throw SOMETHING_WENT_WRONG);
    });
  });
}
