import 'package:npit_qr/middleware/data/data_source/login_remote_data_source.dart';
import 'package:npit_qr/middleware/data/repository/login_repository_impl.dart';
import 'package:npit_qr/middleware/domain/repository/login_repository.dart';
import 'package:npit_qr/middleware/domain/usecase/login_usecase.dart';
import 'package:npit_qr/middleware/presentation/bloc/authorization_bloc.dart';
import 'package:get_it/get_it.dart';

class DIAuthentication {
  final GetIt getIt;

  DIAuthentication(this.getIt) {
    // ********* Bloc **********
    getIt.registerFactory(() {
      return AuthorizationBloc(getIt());
    });

    //********* Use Cases **********
    getIt.registerLazySingleton(() {
      return LoginUseCase(getIt());
    });

    // ********* Repositories **********
    getIt.registerLazySingleton<LoginRepository>(() {
      return LoginRepositoryImpl(getIt());
    });

    // ********* Data Sources **********
    getIt.registerLazySingleton<LoginRemoteDataSource>(() {
      return LoginRemoteDataSourceImpl(getIt());
    });
  }
}
