import 'package:bloc_api_app/get_api/data/request/get_user_request.dart';
import 'package:bloc_api_app/get_api/domain/entity/user_container.dart';
import 'package:bloc_api_app/get_api/domain/repository/user_repository.dart';
import 'package:bloc_api_app/shared/error/error.dart';
import 'package:bloc_api_app/shared/utils/typedef.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final GetUserDataSource getUserDataSource;
  UserRepositoryImpl(
    this.getUserDataSource,
  );


  
  @override
  EitherResponse<UserContainer> getUserData()async{
try {
      final response = await getUserDataSource.getUserData();
      return Right(response);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }
}
