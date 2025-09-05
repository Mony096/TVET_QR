import 'package:npit_qr/select/equipment_type_select/domain/usecase/get_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'equipment_type_state.dart';

class EquipmentTypeCubit extends Cubit<EquipmentTypeState> {
  GetEquipmentTypeUseCase useCase;

  EquipmentTypeCubit(this.useCase) : super(EquipmentTypeInitial());

  Future<List<dynamic>> get(String query) async {
    emit(RequestingEquipmentType());
    final response = await useCase.call(query);
    return response.fold((error) {
      emit(EquipmentTypeError(error.message));
      return [];
    }, (success) async {
      emit(EquipmentTypeData(success));
      return success;
    });
  }

  Future<List<dynamic>> next(String query) async {
    emit(RequestingPaginationEquipmentType());
    final response = await useCase.call(query);
    return response.fold((error) {
      emit(EquipmentTypeError(error.message));
      return [];
    }, (success) async {
      emit(const EquipmentTypeData([]));
      return success;
    });
  }

  Future<void> set(List<dynamic> data) async {
    emit(EquipmentTypeInitial());
    emit(EquipmentTypeData(data));
  }
}
