part of 'expenses_bloc.dart';

@freezed
class ExpensesEvent with _$ExpensesEvent {
  const factory ExpensesEvent.addExpense(
      {required FeesPaymentModel expenseModel}) = _AddExpense;
}
