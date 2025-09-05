import 'package:npit_qr/utilities/dio_client.dart';

import '../../../../../core/error/failure.dart';

abstract class EquipmentTypeRemoteDataSource {
  Future<List<dynamic>> get(String query);
}

class EquipmentTypeRemoteDataSourceImpl
    implements EquipmentTypeRemoteDataSource {
  final DioClient dio;

  EquipmentTypeRemoteDataSourceImpl(this.dio);

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
