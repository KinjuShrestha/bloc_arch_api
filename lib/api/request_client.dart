import 'dart:convert';
import 'dart:io';
import 'package:bloc_api_app/shared/error/domain/entity/error/error_message_container.dart';
import 'package:bloc_api_app/shared/navigation/nav.dart';
import 'package:bloc_api_app/shared/utils/internet_connection.dart';
import 'package:bloc_api_app/shared/widget/show_error_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class RequestClient {
  factory RequestClient() {
    _instance ??= RequestClient._internal();
    return _instance!;
  }

  RequestClient._internal() {
    _client = http.Client();
  }

  static const String userAgent = 'User-Agent';
  static const String contentType = 'Content-Type';
  static const String accept = 'Accept';

  static RequestClient? _instance;
  late http.Client _client;

  Future<Map<String, String>> _createCommonHeader() async {
    final common = <String, String>{};
    common[accept] = ContentType.json.toString();
    return common;
  }

  Future<Map<String, String>> _createHeader() async {
    final common = <String, String>{};
    common[contentType] = ContentType.json.toString();
    return common;
  }

  Future<http.Response> get(String url, Map<String, String> headers) async {
    var isInternet = await CheckInternetConnection().isInternet();
    debugPrint('-------------------------------');
    debugPrint('GET Request');
    debugPrint(url);
    debugPrint(headers.toString());
    debugPrint('-------------------------------');
    headers.addAll(await _createCommonHeader());
    if (isInternet) {
      final response = await _client.get(Uri.parse(url), headers: headers);
      if (!url.contains('Country/GetCountryList') && !url.contains('Logout')) {
        // apiHandleFunction(
        //   response,
        //   url,
        // );
      }
      apiHandleFunction(response);

      return response;
    } else {
      // showNoInternet();

      return http.Response('No Internet Connection', 503);
    }
  }

  Future<http.Response> post(
      String url, Map<String, String> headers, String? body) async {
    var isInternet = await CheckInternetConnection().isInternet();
    debugPrint('-------------------------------');
    debugPrint('POST Request');
    debugPrint(url);
    debugPrint(headers.toString());
    debugPrint('-------------------------------');
    headers.addAll(await _createCommonHeader());
    if (isInternet) {
      final response = await _client.post(Uri.parse(url),
          headers: headers, body: body, encoding: Encoding.getByName('utf-8'));
      if (!url.contains('Country/GetCountryList') && !url.contains('Logout')) {
        // apiHandleFunction(
        //   response,
        //   url,
        // );
        apiHandleFunction(response);
      }
      return response;
    } else {
      // showNoInternet();
      return http.Response('No Internet Connection', 503);
    }
  }

  Future<http.Response> patch(
      String url, Map<String, String> headers, String? body) async {
    var isInternet = await CheckInternetConnection().isInternet();
    debugPrint('-------------------------------');
    debugPrint('patch Request');
    debugPrint(url);
    debugPrint(headers.toString());
    debugPrint('-------------------------------');
    headers.addAll(await _createCommonHeader());
    if (isInternet) {
      final response = await _client.patch(Uri.parse(url),
          headers: headers, body: body, encoding: Encoding.getByName('utf-8'));

      // apiHandleFunction(
      //   response,
      //   url,
      // );
      apiHandleFunction(response);
      return response;
    } else {
      // showNoInternet();
      return http.Response('No Internet Connection', 503);
    }
  }

  apiHandleFunction(response) {
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return null;
    } else if (response.statusCode == 401) {
      showErrorMessageBox("Please login again.", NavigationService.context,
          type: "auth");
    } else if (response.statusCode == 500) {
      showErrorMessageBox('Internal Sever Error', NavigationService.context,
          type: "");
    } else if (response.statusCode == 502) {
      showErrorMessageBox('502 Bad Gateway', NavigationService.context);
    } else if (response.statusCode == 503) {

      if (response.body != "Success") {
        final dynamic object = json.decode(response.body);
        final code =
            ErrorMessageContainer.fromJson(object as Map<String, dynamic>);

        showErrorMessageBox(code.errors[0].message, NavigationService.context);
      }
    } else if (response.statusCode == 400) {
      if (response.body != "Success") {
        final dynamic object = json.decode(response.body);
        final code =
            ErrorMessageContainer.fromJson(object as Map<String, dynamic>);

        showErrorMessageBox(code.errors[0].message, NavigationService.context);
      }
    } else if (response.statusCode == 404) {
      final Map<String, dynamic> object = json.decode(response.body);
      final code = ErrorMessageContainer.fromJson(object);
      showErrorMessageBox(code.errors[0].message, NavigationService.context,
          type: "");
    } else if (response.statusCode == 422) {
      if (response.body != "Success") {
        final dynamic object = json.decode(response.body);
        final code =
            ErrorMessageContainer.fromJson(object as Map<String, dynamic>);

        showErrorMessageBox(code.errors[0].message, NavigationService.context);
      }
    } else {
      final dynamic object = json.decode(json.encode(response.databody));
      final code =
          ErrorMessageContainer.fromJson(object as Map<String, dynamic>);

      showErrorMessage(code.errors[0].message, NavigationService.context);
    }
  }

  Future<http.Response> postJson(
      String url, Map<String, String> headers, String body) async {
    headers
      ..addAll(await _createCommonHeader())
      ..addAll(await _createHeader());

    final response = await _client.post(Uri.parse(url),
        headers: headers, body: body, encoding: Encoding.getByName('utf-8'));
    return response;
  }

  Future<http.Response> put(
      String url, Map<String, String> headers, String? body) async {
    var isInternet = await CheckInternetConnection().isInternet();
    headers.addAll(await _createCommonHeader());
    if (isInternet) {
      final response = await _client.put(Uri.parse(url),
          headers: headers, body: body, encoding: Encoding.getByName('utf-8'));
      if (!url.contains('Country/GetCountryList') && !url.contains('Logout')) {
        // apiHandleFunction(
        //   response,
        //   url,
        // );
        apiHandleFunction(response);
      }
      return response;
    } else {
      // showNoInternet();
      return http.Response('No Internet Connection', 503);
    }
  }

  Future<http.StreamedResponse> upload(http.MultipartRequest request) async {
    final response = await _client.send(request);
    return response;
  }

  Future<http.Response> delete(
      String url, Map<String, String> headers, String body) async {
    var isInternet = await CheckInternetConnection().isInternet();
    headers.addAll(await _createCommonHeader());
    if (isInternet) {
      final response =
          await _client.delete(Uri.parse(url), headers: headers, body: body);
      // apiHandleFunction(
      //   response,
      //   url,
      // );
      apiHandleFunction(response);
      return response;
    } else {
      // showNoInternet();
      return http.Response('No Internet Connection', 503);
    }
  }

  Future<Response<dynamic>?> dioUpload(
      String url, dio.FormData formData, Map<String, String> headers) async {
    var isInternet = await CheckInternetConnection().isInternet();
    headers.addAll(await _createCommonHeader());
    if (isInternet) {
      final response = await dio.Dio().post(url,
          data: formData,
          options: Options(
              contentType: 'application/json',
              validateStatus: (status) => status! < 600,
              headers: headers));
      // await apiHandleFunction(response, url, isHttp: false);
      return response;
    } else {
      // showNoInternet();
      return null;
    }
  }
  //
  // apiHandleFunction(response, url, {bool isHttp = true}) async {
  //   if (url == '${BaseURL.getInstance.getBaseUrl()}/${APIConstants.registerTokenApi}' ||
  //       url ==
  //           '${BaseURL.getInstance.getBaseUrl()}/${APIConstants.refreshTokenApi}' ||
  //       url ==
  //           '${BaseURL.getInstance.getBaseUrl()}/${APIConstants.unRegisterTokenApi} ' ||
  //       url ==
  //           '${BaseURL.getInstance.getBaseUrl()}/${APIConstants.panchangaApi}') {
  //   } else {
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return null;
  //     } else if (response.statusCode == 401) {
  //       if (!SingleDialogPopUp.getInstance.getSingleDialog()) {
  //         if (url !=
  //             '${BaseURL.getInstance.getBaseUrl()}/${APIConstants.logoutApi}') {
  //           showErrorMessage('Session Expired. Please login again!',
  //               NavigationService.navigatorKey.currentContext!,
  //               onPressed: () async {
  //             String? firebaseToken = await SharedPrefData().getFcmToken();
  //             String? id = await SharedPrefData().getUserId();
  //             var tokenModel = RegisterTokenModel(
  //               fcmToken: firebaseToken,
  //               id: id,
  //             );
  //             await notificationStore
  //                 .unRegisterFcmToken(tokenModel)
  //                 .then((value) async {
  //               if (!value.hasError) {
  //                 final pref = await SharedPreferences.getInstance();
  //                 pref.clear();
  //               }
  //             });
  //             UserLoginStatus.getInstance.setUserLoggedIn(false);
  //             SingleDialogPopUp.getInstance.setSingleDialog(false);
  //             Navigator.of(NavigationService.navigatorKey.currentContext!)
  //                 .pop();
  //           },
  //               icon: Assets.icons.error.required.svg(),
  //               title: "Authorization Required");
  //           final pref = await SharedPreferences.getInstance();
  //           pref.clear();
  //           UserLoginStatus.getInstance.setUserLoggedIn(false);
  //           Navigator.pushNamedAndRemoveUntil(
  //               NavigationService.navigatorKey.currentContext!,
  //               DashBoardScreen.routeName,
  //               (route) => false);
  //           SingleDialogPopUp.getInstance.setSingleDialog(true);
  //         }
  //       }
  //     } else if (response.statusCode == 500 ||
  //         response.statusCode == 502 ||
  //         response.statusCode == 429) {
  //       if (!SingleDialogPopUp.getInstance.getSingleDialog()) {
  //         showErrorMessage(re.Response.defaultErrorMessage,
  //             NavigationService.navigatorKey.currentContext!,
  //             icon: Assets.icons.error.error.svg(), title: "Error!");
  //         SingleDialogPopUp.getInstance.setSingleDialog(true);
  //       }
  //     } else if (response.statusCode == 503 ||
  //         (response.statusCode == 400 &&
  //             url.toString().contains(
  //                 '${BaseURL.getInstance.getBaseUrl()}/${APIConstants.getRedeemPointApi}'))) {
  //     } else if ((response.statusCode == 404) ||
  //         (response.statusCode == 422 ||
  //             (response.statusCode == 400 &&
  //                 !url.toString().contains(
  //                     '${BaseURL.getInstance.getBaseUrl()}/${APIConstants.getRedeemPointApi}')))) {
  //       final dynamic object =
  //           isHttp ? json.decode(response.body) : response.data;
  //       final code = ErrorContainer.fromJson(object as Map<String, dynamic>);
  //       showErrorMessage(code.errorList![0].title,
  //           NavigationService.navigatorKey.currentContext!,
  //           icon: Assets.icons.error.oops.svg(), title: "Error!");
  //     } else {
  //       showErrorMessage(re.Response.defaultErrorMessage,
  //           NavigationService.navigatorKey.currentContext!);
  //     }
  //   }
  // }
}
