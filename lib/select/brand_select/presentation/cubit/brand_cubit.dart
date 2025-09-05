import 'package:npit_qr/select/brand_select/domain/usecase/get_usecase.dart';
import 'package:npit_qr/select/equipment_type_select/domain/usecase/get_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  GetBrandUseCase useCase;

  BrandCubit(this.useCase) : super(BrandInitial());

  Future<List<dynamic>> get(String query) async {
    emit(RequestingBrand());
    final response = await useCase.call(query);
    return response.fold((error) {
      emit(BrandError(error.message));
      return [];
    }, (success) async {
      emit(BrandData(success));
      return success;
    });
  }

  Future<List<dynamic>> next(String query) async {
    emit(RequestingPaginationBrand());
    final response = await useCase.call(query);
    return response.fold((error) {
      emit(BrandError(error.message));
      return [];
    }, (success) async {
      emit(const BrandData([]));
      return success;
    });
  }

  Future<void> set(List<dynamic> data) async {
    emit(BrandInitial());
    emit(BrandData(data));
  }
}
