import 'package:npit_qr/injector/di_authenticate.dart';
import 'package:npit_qr/utilities/database/database.dart';
import 'package:npit_qr/utilities/dio_client.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> container() async {
  getIt.registerLazySingleton(() => DioClient());
  getIt.registerLazySingleton(() => DatabaseHelper());

//
  DIAuthentication(getIt);

  //
}
