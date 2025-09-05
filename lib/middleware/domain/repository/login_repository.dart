import 'package:npit_qr/middleware/domain/entity/login_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> post(LoginEntity entity);
}
