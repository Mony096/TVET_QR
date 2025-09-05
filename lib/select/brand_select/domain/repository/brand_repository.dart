import 'package:dartz/dartz.dart';


import '../../../../../core/error/failure.dart';

abstract class BrandRepository {
  Future<Either<Failure, List<dynamic>>> get(String query);
}
