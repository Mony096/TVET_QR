part of 'brand_cubit.dart';

class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class BrandInitial extends BrandState {}

class RequestingBrand extends BrandState {}

class RequestingPaginationBrand extends BrandState {}

class BrandData extends BrandState {
  final List<dynamic> entities;

  const BrandData(this.entities);
}

class BrandError extends BrandState {
  final String message;

  const BrandError(this.message);
}
