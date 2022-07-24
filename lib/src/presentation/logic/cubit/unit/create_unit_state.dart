part of 'create_unit_cubit.dart';

@immutable
abstract class CreateUnitState {}

class CreateUnitInitial extends CreateUnitState {}

class CreateUnitLoading extends CreateUnitState {}

class CreateUnitSuccess extends CreateUnitState {
  final CreateUnitResponse createUnitResponse;
  final String message = 'زیرمجموعه با موفقیت ثبت شد';

  CreateUnitSuccess({required this.createUnitResponse});
}

class CreateUnitFailure extends CreateUnitState {
  final String message ;

  CreateUnitFailure({required this.message});
}
