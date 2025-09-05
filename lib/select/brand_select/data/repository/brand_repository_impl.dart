import 'package:npit_qr/select/brand_select/data/data_source/brand_remote_data_source.dart';
import 'package:npit_qr/select/brand_select/domain/repository/brand_repository.dart';
import 'package:npit_qr/select/equipment_type_select/data/data_source/equipment_type_remote_data_source.dart';
import 'package:npit_qr/select/equipment_type_select/domain/repository/equipment_type_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

class BrandRepositoryImpl implements BrandRepository {
  final BrandRemoteDataSource remote;

  BrandRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<dynamic>>> get(String query) async {
    try {
      final List<dynamic> reponse = await remote.get(query);
      return Right(reponse);
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
