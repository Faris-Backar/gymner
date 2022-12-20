part of 'package_cubit.dart';

abstract class PackageState extends Equatable {
  const PackageState();

  @override
  List<Object> get props => [];
}

class PackageInitial extends PackageState {}

class PackageLoading extends PackageState {}

class PackageLoaded extends PackageState {
  final List<PackageModel> packageList;
  const PackageLoaded({
    required this.packageList,
  });
  @override
  List<Object> get props => [packageList];
}

class CreatePackageLoaded extends PackageState {}

class PackageFailed extends PackageState {
  final String error;
  const PackageFailed({required this.error});

  @override
  List<Object> get props => [error];
}
