import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym/service/repository/expense_repository.dart';
import 'package:gym/service/model/fees_payment_model.dart';

part 'expenses_bloc.freezed.dart';
part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final ExpenseRepository expenseRepository;

  ExpensesBloc({required this.expenseRepository})
      : super(const ExpensesState.initial()) {
    on<_AddExpense>(_newExpense);
  }

  Future<void> _newExpense(
      _AddExpense event, Emitter<ExpensesState> emit) async {
    emit(const ExpensesState.loading());
    try {
      await expenseRepository.addExpense(expenseModel: event.expenseModel);
      emit(const ExpensesState.expenseCreated());
    } catch (e) {
      emit(ExpensesState.failed(error: e.toString()));
    }
  }
}
