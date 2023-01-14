import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart' as di;
import 'package:gym/presentation/bloc/auth/auth_bloc.dart';
import 'package:gym/presentation/bloc/fee_package/package_cubit.dart';
import 'package:gym/presentation/bloc/fee_payment/fee_payment_bloc.dart';
import 'package:gym/presentation/bloc/fee_pending/fee_pending_bloc.dart';
import 'package:gym/presentation/bloc/members/members_bloc.dart';
import 'package:gym/service/repository/fee_payment_repository.dart';
import 'package:gym/service/repository/members_repository.dart';
import 'package:gym/service/repository/package_repository.dart';
import 'package:uuid/uuid.dart';

final getIt = di.GetIt.instance;

void setup() {
  getIt.registerSingleton<Uuid>(const Uuid());
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<AuthBloc>(AuthBloc(firebase: getIt<FirebaseAuth>()));
  getIt.registerSingleton<MembersRepository>(MembersRepository(
      db: getIt<FirebaseFirestore>(), storage: getIt<FirebaseStorage>()));
  getIt.registerSingleton<MembersBloc>(
      MembersBloc(membersRepository: getIt<MembersRepository>()));
  getIt.registerSingleton<PackageRepository>(
      PackageRepository(db: getIt<FirebaseFirestore>()));
  getIt.registerSingleton<PackageCubit>(
      PackageCubit(packageRepository: getIt<PackageRepository>()));
  getIt.registerSingleton<FeesPaymentRepsoitory>(
      FeesPaymentRepsoitory(firebaseDb: getIt<FirebaseFirestore>()));
  getIt.registerSingleton<FeePaymentBloc>(
      FeePaymentBloc(feesPaymentRepsoitory: getIt<FeesPaymentRepsoitory>()));
  getIt.registerSingleton<FeePendingBloc>(
      FeePendingBloc(feesPaymentRepsoitory: getIt<FeesPaymentRepsoitory>()));
}
