import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:campusclap/local_repository/preferences.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'apiConstants.dart';

class ApiException implements Exception {
  ApiException(this.errorMessage);

  String errorMessage;

  @override
  String toString() {
    return errorMessage;
  }
}

class ApiBaseHelper {



  Future<dynamic> postAPICall(Uri url, Map param) async {
    var responseJson;
    log('${url}');
    log('${param}');
    String? token = await LocalRepository.getPrefrence(LocalRepository.token) ;
    var header = {
      'Cookie': 'ci_session=3a2ad9ed3b163b1b2873213952605317b83816b3',
      'Authorization': 'Bearer $token',
      'Accept':'application/json'

    };


    try {
      final response =
      await post(url, body: param.isNotEmpty ? param : {}, headers: header)
          .timeout(const Duration(seconds: timeOut));

      if(response.statusCode== 401){
        Fluttertoast.showToast(msg: 'Please Login Again');
      }else {
        responseJson = _response(response);
      }

    } on SocketException catch (e) {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }

  Future<dynamic> postMultipartAPICall(Uri url, Map<String, String> fields,
      {File? resume,File? selfie,File? aadhaar, List <File>? files }) async {
    var responseJson;
    log('${url}');
    log('${fields}');
   // String? token = await LocalRepository.getPrefrence(LocalRepository.token) ;
    var header = {
      'Cookie': 'ci_session=3a2ad9ed3b163b1b2873213952605317b83816b3',
      'Authorization': 'Bearer $authToken',
      'Accept':'application/json'

    };

    try {
      var request = MultipartRequest('POST', url);

      // Add fields to the request
      if(fields.isNotEmpty){
        request.fields.addAll(fields);

      }

      if(files != null){
        for(var i in files) {
          request.files.add(await MultipartFile.fromPath('', i.path));
        }
      }
      if(resume != null) {
        request.files.add(await MultipartFile.fromPath('resume', resume.path));
      }
      if(aadhaar != null) {
        request.files.add(await MultipartFile.fromPath('aadhar_image', aadhaar.path));
      }
      if(selfie != null) {
        request.files.add(await MultipartFile.fromPath('selfie_image', selfie.path));
      }
      request.headers.addAll(header);

      // Send the request
      var response = await request.send().timeout( Duration(seconds: 50));
      // Read the response
      var responseString = await response.stream.bytesToString();
      log(responseString);

      responseJson = _response(Response(responseString, response.statusCode));
    } on SocketException catch (e) {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      throw ApiException('Something Went wrong with ${e.toString()}');
    }

    return responseJson;
  }

  Future<dynamic> getAPICall(Uri url) async {
    var responseJson;
    log('${url}');
    //String? token = await LocalRepository.getPrefrence(LocalRepository.token) ;
    var header = {
      'Cookie': 'ci_session=3a2ad9ed3b163b1b2873213952605317b83816b3',
      'Authorization': 'Bearer $authToken',
      'Accept':'application/json'

    };

    log('${header}');
    try {
      final response =
      await get(url, headers: header)
          .timeout(const Duration(seconds: timeOut));
      log('${response.statusCode}');

      if(response.statusCode== 401){
        Fluttertoast.showToast(msg: 'Please Login Again');
      }else {
        responseJson = _response(response);

      }

    } on SocketException catch (e) {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }



  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }

}

class CustomException implements Exception {
  final message;
  final prefix;

  CustomException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, 'Invalid Input: ');
}
Map<String, String> get headers => {
  'Cookie': 'ci_session=3a2ad9ed3b163b1b2873213952605317b83816b3',
  'Authorization': 'Bearer $token',
  'Accept':'application/json'

};