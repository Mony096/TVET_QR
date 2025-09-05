import 'package:npit_qr/select/equipment_type_select/domain/repository/equipment_type_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';

class GetEquipmentTypeUseCase implements UseCase<List<dynamic>, String> {
  final EquipmentTypeRepository repository;

  GetEquipmentTypeUseCase(this.repository);

  @override
  Future<Either<Failure, List<dynamic>>> call(String query) async {
    return await repository.get(query);
  }
}
