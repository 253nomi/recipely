import 'package:flutter_test/flutter_test.dart';
import 'package:receipe_task/data/repository_imp/repository_imp.dart';
import 'package:receipe_task/utils/constants/constants.dart';
import '../../../mock_constants/mock_constants.dart';
import '../../../mocks/mock_auth_data_source.dart';
import '../../../mocks/mock_network_info_online.dart';
import '../../../mocks/mock_remote_data_source.dart';
import '../../../mocks/mock_user.dart';

void main() {
  runTestOnlineWithNoError();
}

void runTestOnlineWithNoError() {
  var remoteDataSource = MockRemoteDataSource();
  var authDataSource = MockAuthDataSource();

  var repositoryImpOnline = RepositoryImp(
    remoteDataSource: remoteDataSource,
    networkInfo: MockNetworkInfoOnline(),
    authDataSource: authDataSource,
  );

  group('Repository online test wth no error', () {
    test('should return a firebase user', () async {
      var response = await repositoryImpOnline.loginWithFirebase(MOCK_CREDENTIALS);

      expect(true, response.isRight());
      response.fold((l) => throw SOMETHING_WENT_WRONG, (r) => expect(r, isA<MockUser>()));
    });

    test('should return a food details list', () async {
      var response = await repositoryImpOnline.getFoodList();

      expect(true, response.isRight());
      response.fold((l) => throw SOMETHING_WENT_WRONG, (r) => expect(r, MOCK_FOOD_DETAILS));
    });

    test('should return a category list', () async {
      var response = await repositoryImpOnline.getCategoryList();

      expect(true, response.isRight());
      response.fold((l) => throw SOMETHING_WENT_WRONG, (r) => expect(r, MOCK_CATEGORY_DETAILS));
    });

    test('should return a cuisine list', () async {
      var response = await repositoryImpOnline.getCuisineList();

      expect(true, response.isRight());
      response.fold((l) => throw SOMETHING_WENT_WRONG, (r) => expect(r, MOCK_CUISINE_DETAILS));
    });
  });
}
