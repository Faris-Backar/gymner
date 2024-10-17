part of 'expenses_bloc.dart';

@freezed
class ExpensesState with _$ExpensesState {
  const factory ExpensesState.initial() = _Initial;
  const factory ExpensesState.loading() = _loading;
  const factory ExpensesState.expenseCreated() = _createdExpenses;
  const factory ExpensesState.expensesFetched(List<FeesPaymentModel> expenses) =
      _expensesFetched;
  const factory ExpensesState.failed({required String error}) = _failed;
}
