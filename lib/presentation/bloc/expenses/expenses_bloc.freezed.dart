// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expenses_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExpensesEvent {
  FeesPaymentModel get expenseModel => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FeesPaymentModel expenseModel) addExpense,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FeesPaymentModel expenseModel)? addExpense,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FeesPaymentModel expenseModel)? addExpense,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddExpense value) addExpense,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddExpense value)? addExpense,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddExpense value)? addExpense,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpensesEventCopyWith<ExpensesEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpensesEventCopyWith<$Res> {
  factory $ExpensesEventCopyWith(
          ExpensesEvent value, $Res Function(ExpensesEvent) then) =
      _$ExpensesEventCopyWithImpl<$Res, ExpensesEvent>;
  @useResult
  $Res call({FeesPaymentModel expenseModel});
}

/// @nodoc
class _$ExpensesEventCopyWithImpl<$Res, $Val extends ExpensesEvent>
    implements $ExpensesEventCopyWith<$Res> {
  _$ExpensesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseModel = null,
  }) {
    return _then(_value.copyWith(
      expenseModel: null == expenseModel
          ? _value.expenseModel
          : expenseModel // ignore: cast_nullable_to_non_nullable
              as FeesPaymentModel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddExpenseImplCopyWith<$Res>
    implements $ExpensesEventCopyWith<$Res> {
  factory _$$AddExpenseImplCopyWith(
          _$AddExpenseImpl value, $Res Function(_$AddExpenseImpl) then) =
      __$$AddExpenseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FeesPaymentModel expenseModel});
}

/// @nodoc
class __$$AddExpenseImplCopyWithImpl<$Res>
    extends _$ExpensesEventCopyWithImpl<$Res, _$AddExpenseImpl>
    implements _$$AddExpenseImplCopyWith<$Res> {
  __$$AddExpenseImplCopyWithImpl(
      _$AddExpenseImpl _value, $Res Function(_$AddExpenseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseModel = null,
  }) {
    return _then(_$AddExpenseImpl(
      expenseModel: null == expenseModel
          ? _value.expenseModel
          : expenseModel // ignore: cast_nullable_to_non_nullable
              as FeesPaymentModel,
    ));
  }
}

/// @nodoc

class _$AddExpenseImpl implements _AddExpense {
  const _$AddExpenseImpl({required this.expenseModel});

  @override
  final FeesPaymentModel expenseModel;

  @override
  String toString() {
    return 'ExpensesEvent.addExpense(expenseModel: $expenseModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddExpenseImpl &&
            (identical(other.expenseModel, expenseModel) ||
                other.expenseModel == expenseModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, expenseModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddExpenseImplCopyWith<_$AddExpenseImpl> get copyWith =>
      __$$AddExpenseImplCopyWithImpl<_$AddExpenseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FeesPaymentModel expenseModel) addExpense,
  }) {
    return addExpense(expenseModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FeesPaymentModel expenseModel)? addExpense,
  }) {
    return addExpense?.call(expenseModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FeesPaymentModel expenseModel)? addExpense,
    required TResult orElse(),
  }) {
    if (addExpense != null) {
      return addExpense(expenseModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddExpense value) addExpense,
  }) {
    return addExpense(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddExpense value)? addExpense,
  }) {
    return addExpense?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddExpense value)? addExpense,
    required TResult orElse(),
  }) {
    if (addExpense != null) {
      return addExpense(this);
    }
    return orElse();
  }
}

abstract class _AddExpense implements ExpensesEvent {
  const factory _AddExpense({required final FeesPaymentModel expenseModel}) =
      _$AddExpenseImpl;

  @override
  FeesPaymentModel get expenseModel;
  @override
  @JsonKey(ignore: true)
  _$$AddExpenseImplCopyWith<_$AddExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExpensesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() expenseCreated,
    required TResult Function(List<FeesPaymentModel> expenses) expensesFetched,
    required TResult Function(String error) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? expenseCreated,
    TResult? Function(List<FeesPaymentModel> expenses)? expensesFetched,
    TResult? Function(String error)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? expenseCreated,
    TResult Function(List<FeesPaymentModel> expenses)? expensesFetched,
    TResult Function(String error)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_loading value) loading,
    required TResult Function(_createdExpenses value) expenseCreated,
    required TResult Function(_expensesFetched value) expensesFetched,
    required TResult Function(_failed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_loading value)? loading,
    TResult? Function(_createdExpenses value)? expenseCreated,
    TResult? Function(_expensesFetched value)? expensesFetched,
    TResult? Function(_failed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_loading value)? loading,
    TResult Function(_createdExpenses value)? expenseCreated,
    TResult Function(_expensesFetched value)? expensesFetched,
    TResult Function(_failed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpensesStateCopyWith<$Res> {
  factory $ExpensesStateCopyWith(
          ExpensesState value, $Res Function(ExpensesState) then) =
      _$ExpensesStateCopyWithImpl<$Res, ExpensesState>;
}

/// @nodoc
class _$ExpensesStateCopyWithImpl<$Res, $Val extends ExpensesState>
    implements $ExpensesStateCopyWith<$Res> {
  _$ExpensesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ExpensesStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ExpensesState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() expenseCreated,
    required TResult Function(List<FeesPaymentModel> expenses) expensesFetched,
    required TResult Function(String error) failed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? expenseCreated,
    TResult? Function(List<FeesPaymentModel> expenses)? expensesFetched,
    TResult? Function(String error)? failed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? expenseCreated,
    TResult Function(List<FeesPaymentModel> expenses)? expensesFetched,
    TResult Function(String error)? failed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_loading value) loading,
    required TResult Function(_createdExpenses value) expenseCreated,
    required TResult Function(_expensesFetched value) expensesFetched,
    required TResult Function(_failed value) failed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_loading value)? loading,
    TResult? Function(_createdExpenses value)? expenseCreated,
    TResult? Function(_expensesFetched value)? expensesFetched,
    TResult? Function(_failed value)? failed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_loading value)? loading,
    TResult Function(_createdExpenses value)? expenseCreated,
    TResult Function(_expensesFetched value)? expensesFetched,
    TResult Function(_failed value)? failed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ExpensesState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$loadingImplCopyWith<$Res> {
  factory _$$loadingImplCopyWith(
          _$loadingImpl value, $Res Function(_$loadingImpl) then) =
      __$$loadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$loadingImplCopyWithImpl<$Res>
    extends _$ExpensesStateCopyWithImpl<$Res, _$loadingImpl>
    implements _$$loadingImplCopyWith<$Res> {
  __$$loadingImplCopyWithImpl(
      _$loadingImpl _value, $Res Function(_$loadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$loadingImpl implements _loading {
  const _$loadingImpl();

  @override
  String toString() {
    return 'ExpensesState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$loadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() expenseCreated,
    required TResult Function(List<FeesPaymentModel> expenses) expensesFetched,
    required TResult Function(String error) failed,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? expenseCreated,
    TResult? Function(List<FeesPaymentModel> expenses)? expensesFetched,
    TResult? Function(String error)? failed,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? expenseCreated,
    TResult Function(List<FeesPaymentModel> expenses)? expensesFetched,
    TResult Function(String error)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_loading value) loading,
    required TResult Function(_createdExpenses value) expenseCreated,
    required TResult Function(_expensesFetched value) expensesFetched,
    required TResult Function(_failed value) failed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_loading value)? loading,
    TResult? Function(_createdExpenses value)? expenseCreated,
    TResult? Function(_expensesFetched value)? expensesFetched,
    TResult? Function(_failed value)? failed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_loading value)? loading,
    TResult Function(_createdExpenses value)? expenseCreated,
    TResult Function(_expensesFetched value)? expensesFetched,
    TResult Function(_failed value)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _loading implements ExpensesState {
  const factory _loading() = _$loadingImpl;
}

/// @nodoc
abstract class _$$createdExpensesImplCopyWith<$Res> {
  factory _$$createdExpensesImplCopyWith(_$createdExpensesImpl value,
          $Res Function(_$createdExpensesImpl) then) =
      __$$createdExpensesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$createdExpensesImplCopyWithImpl<$Res>
    extends _$ExpensesStateCopyWithImpl<$Res, _$createdExpensesImpl>
    implements _$$createdExpensesImplCopyWith<$Res> {
  __$$createdExpensesImplCopyWithImpl(
      _$createdExpensesImpl _value, $Res Function(_$createdExpensesImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$createdExpensesImpl implements _createdExpenses {
  const _$createdExpensesImpl();

  @override
  String toString() {
    return 'ExpensesState.expenseCreated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$createdExpensesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() expenseCreated,
    required TResult Function(List<FeesPaymentModel> expenses) expensesFetched,
    required TResult Function(String error) failed,
  }) {
    return expenseCreated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? expenseCreated,
    TResult? Function(List<FeesPaymentModel> expenses)? expensesFetched,
    TResult? Function(String error)? failed,
  }) {
    return expenseCreated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? expenseCreated,
    TResult Function(List<FeesPaymentModel> expenses)? expensesFetched,
    TResult Function(String error)? failed,
    required TResult orElse(),
  }) {
    if (expenseCreated != null) {
      return expenseCreated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_loading value) loading,
    required TResult Function(_createdExpenses value) expenseCreated,
    required TResult Function(_expensesFetched value) expensesFetched,
    required TResult Function(_failed value) failed,
  }) {
    return expenseCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_loading value)? loading,
    TResult? Function(_createdExpenses value)? expenseCreated,
    TResult? Function(_expensesFetched value)? expensesFetched,
    TResult? Function(_failed value)? failed,
  }) {
    return expenseCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_loading value)? loading,
    TResult Function(_createdExpenses value)? expenseCreated,
    TResult Function(_expensesFetched value)? expensesFetched,
    TResult Function(_failed value)? failed,
    required TResult orElse(),
  }) {
    if (expenseCreated != null) {
      return expenseCreated(this);
    }
    return orElse();
  }
}

abstract class _createdExpenses implements ExpensesState {
  const factory _createdExpenses() = _$createdExpensesImpl;
}

/// @nodoc
abstract class _$$expensesFetchedImplCopyWith<$Res> {
  factory _$$expensesFetchedImplCopyWith(_$expensesFetchedImpl value,
          $Res Function(_$expensesFetchedImpl) then) =
      __$$expensesFetchedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<FeesPaymentModel> expenses});
}

/// @nodoc
class __$$expensesFetchedImplCopyWithImpl<$Res>
    extends _$ExpensesStateCopyWithImpl<$Res, _$expensesFetchedImpl>
    implements _$$expensesFetchedImplCopyWith<$Res> {
  __$$expensesFetchedImplCopyWithImpl(
      _$expensesFetchedImpl _value, $Res Function(_$expensesFetchedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenses = null,
  }) {
    return _then(_$expensesFetchedImpl(
      null == expenses
          ? _value._expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<FeesPaymentModel>,
    ));
  }
}

/// @nodoc

class _$expensesFetchedImpl implements _expensesFetched {
  const _$expensesFetchedImpl(final List<FeesPaymentModel> expenses)
      : _expenses = expenses;

  final List<FeesPaymentModel> _expenses;
  @override
  List<FeesPaymentModel> get expenses {
    if (_expenses is EqualUnmodifiableListView) return _expenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expenses);
  }

  @override
  String toString() {
    return 'ExpensesState.expensesFetched(expenses: $expenses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$expensesFetchedImpl &&
            const DeepCollectionEquality().equals(other._expenses, _expenses));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_expenses));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$expensesFetchedImplCopyWith<_$expensesFetchedImpl> get copyWith =>
      __$$expensesFetchedImplCopyWithImpl<_$expensesFetchedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() expenseCreated,
    required TResult Function(List<FeesPaymentModel> expenses) expensesFetched,
    required TResult Function(String error) failed,
  }) {
    return expensesFetched(expenses);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? expenseCreated,
    TResult? Function(List<FeesPaymentModel> expenses)? expensesFetched,
    TResult? Function(String error)? failed,
  }) {
    return expensesFetched?.call(expenses);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? expenseCreated,
    TResult Function(List<FeesPaymentModel> expenses)? expensesFetched,
    TResult Function(String error)? failed,
    required TResult orElse(),
  }) {
    if (expensesFetched != null) {
      return expensesFetched(expenses);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_loading value) loading,
    required TResult Function(_createdExpenses value) expenseCreated,
    required TResult Function(_expensesFetched value) expensesFetched,
    required TResult Function(_failed value) failed,
  }) {
    return expensesFetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_loading value)? loading,
    TResult? Function(_createdExpenses value)? expenseCreated,
    TResult? Function(_expensesFetched value)? expensesFetched,
    TResult? Function(_failed value)? failed,
  }) {
    return expensesFetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_loading value)? loading,
    TResult Function(_createdExpenses value)? expenseCreated,
    TResult Function(_expensesFetched value)? expensesFetched,
    TResult Function(_failed value)? failed,
    required TResult orElse(),
  }) {
    if (expensesFetched != null) {
      return expensesFetched(this);
    }
    return orElse();
  }
}

abstract class _expensesFetched implements ExpensesState {
  const factory _expensesFetched(final List<FeesPaymentModel> expenses) =
      _$expensesFetchedImpl;

  List<FeesPaymentModel> get expenses;
  @JsonKey(ignore: true)
  _$$expensesFetchedImplCopyWith<_$expensesFetchedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$failedImplCopyWith<$Res> {
  factory _$$failedImplCopyWith(
          _$failedImpl value, $Res Function(_$failedImpl) then) =
      __$$failedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$failedImplCopyWithImpl<$Res>
    extends _$ExpensesStateCopyWithImpl<$Res, _$failedImpl>
    implements _$$failedImplCopyWith<$Res> {
  __$$failedImplCopyWithImpl(
      _$failedImpl _value, $Res Function(_$failedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$failedImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$failedImpl implements _failed {
  const _$failedImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'ExpensesState.failed(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$failedImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$failedImplCopyWith<_$failedImpl> get copyWith =>
      __$$failedImplCopyWithImpl<_$failedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() expenseCreated,
    required TResult Function(List<FeesPaymentModel> expenses) expensesFetched,
    required TResult Function(String error) failed,
  }) {
    return failed(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? expenseCreated,
    TResult? Function(List<FeesPaymentModel> expenses)? expensesFetched,
    TResult? Function(String error)? failed,
  }) {
    return failed?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? expenseCreated,
    TResult Function(List<FeesPaymentModel> expenses)? expensesFetched,
    TResult Function(String error)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_loading value) loading,
    required TResult Function(_createdExpenses value) expenseCreated,
    required TResult Function(_expensesFetched value) expensesFetched,
    required TResult Function(_failed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_loading value)? loading,
    TResult? Function(_createdExpenses value)? expenseCreated,
    TResult? Function(_expensesFetched value)? expensesFetched,
    TResult? Function(_failed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_loading value)? loading,
    TResult Function(_createdExpenses value)? expenseCreated,
    TResult Function(_expensesFetched value)? expensesFetched,
    TResult Function(_failed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _failed implements ExpensesState {
  const factory _failed({required final String error}) = _$failedImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$failedImplCopyWith<_$failedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
