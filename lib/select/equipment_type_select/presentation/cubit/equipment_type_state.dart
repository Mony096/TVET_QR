part of 'equipment_type_cubit.dart';

class EquipmentTypeState extends Equatable {
  const EquipmentTypeState();

  @override
  List<Object> get props => [];
}

class EquipmentTypeInitial extends EquipmentTypeState {}

class RequestingEquipmentType extends EquipmentTypeState {}

class RequestingPaginationEquipmentType extends EquipmentTypeState {}

class EquipmentTypeData extends EquipmentTypeState {
  final List<dynamic> entities;

  const EquipmentTypeData(this.entities);
}

class EquipmentTypeError extends EquipmentTypeState {
  final String message;

  const EquipmentTypeError(this.message);
}
