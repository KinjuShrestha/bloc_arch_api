import 'package:bloc_api_app/shared/error/error.dart';
import 'package:bloc_api_app/shared/utils/response.dart';
import 'package:dartz/dartz.dart';

typedef EitherResponse<T> = Future<Either<Failure, DataResponse<T>>>;