import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gym/service/model/package_model.dart';
import 'package:gym/service/repository/package_repository.dart';

part 'package_state.dart';

class PackageCubit extends Cubit<PackageState> {
  PackageCubit({
    required this.packageRepository,
  }) : super(PackageInitial());
  final PackageRepository packageRepository;

  getFeePackages() async {
    emit(PackageInitial());
    emit(PackageLoading());
    try {
      final response = await packageRepository.getPackages();
      emit(PackageLoaded(packageList: response));
    } catch (e) {
      emit(PackageFailed(error: e.toString()));
    }
  }

  createFeePackages({required PackageModel packageModel}) async {
    emit(PackageInitial());
    emit(PackageLoading());
    try {
      await packageRepository
          .createPackages(packageModel: packageModel)
          .whenComplete(() => emit(CreatePackageLoaded()));
    } catch (e) {
      emit(PackageFailed(error: e.toString()));
    }
  }

  init() {
    emit(PackageInitial());
  }
}
