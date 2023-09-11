
import 'package:bloc_api_app/get_api/domain/entity/user_container.dart';
import 'package:bloc_api_app/shared/utils/typedef.dart';


abstract class UserRepository {
  EitherResponse<UserContainer> getUserData();
}
