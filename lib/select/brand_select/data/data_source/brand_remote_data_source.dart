import 'package:npit_qr/utilities/dio_client.dart';

import '../../../../../core/error/failure.dart';

abstract class BrandRemoteDataSource {
  Future<List<dynamic>> get(String query);
}

class BrandRemoteDataSourceImpl implements BrandRemoteDataSource {
  final DioClient dio;

  BrandRemoteDataSourceImpl(this.dio);

  @override
  Future<List<dynamic>> get(String query) async {
    try {
      final response = await dio.get('/PurchaseOrders$query');

      if (response.statusCode != 200) {
        throw const ServerFailure(message: 'error');
      }

      return List.from(response.data['value'])
          .map((e) => e as dynamic)
          .toList();
    } on Failure {
      rethrow;
    }
  }
}
