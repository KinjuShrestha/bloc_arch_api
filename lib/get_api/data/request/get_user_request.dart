

import 'dart:convert';

import 'package:bloc_api_app/api/request.dart';
import 'package:bloc_api_app/api/request_client.dart';
import 'package:bloc_api_app/get_api/domain/entity/user_container.dart';
import 'package:bloc_api_app/shared/utils/response.dart';


abstract class GetUserDataSource {
  Future<DataResponse<UserContainer>> getUserData();
}

class GetUserDataSourceImpl implements GetUserDataSource {
  static const _endPoint = 'users';

  GetUserDataSourceImpl();

  @override
  Future<DataResponse<UserContainer>> getUserData() {
    return _getUserDataFromApi(
        "/$_endPoint");
  }

  Future<DataResponse<UserContainer>> _getUserDataFromApi(
      String url) async {
    try {
      final res = await RequestClient()
          .get(Request.createUrl(url), Request.createAuthHeaderWithoutToken());
      final Map<String, dynamic> resBody = json.decode(res.body);
      final resData = UserContainer.fromJson(resBody);
      return DataResponse.success(resData);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
