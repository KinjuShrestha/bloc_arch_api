import 'package:bloc_api_app/core/usecase.dart';
import 'package:bloc_api_app/get_api/domain/entity/user_container.dart';
import 'package:bloc_api_app/get_api/domain/repository/user_repository.dart';
import 'package:bloc_api_app/shared/error/error.dart';
import 'package:bloc_api_app/shared/utils/response.dart';
import 'package:bloc_api_app/shared/utils/typedef.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UserUseCase
    extends UseCase<Either<Failure, DataResponse<UserContainer>>, Params> {
  final UserRepository repository;

  UserUseCase(this.repository);

  @override
  EitherResponse<UserContainer> call(Params params) async {
    return await repository.getUserData();
  }
    }

  class Params extends Equatable {
  

  const Params();

  @override
  List<Object?> get props => [];
}