import 'package:npit_qr/middleware/domain/entity/login_entity.dart';
import 'package:npit_qr/middleware/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class LoginUseCase implements UseCase<String, LoginEntity> {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginEntity entity) async {
    return await repository.post(entity);
  }
}
