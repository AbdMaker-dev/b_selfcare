// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_flotte_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyFlotteState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyFlotteState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyFlotteState()';
}


}

/// @nodoc
class $MyFlotteStateCopyWith<$Res>  {
$MyFlotteStateCopyWith(MyFlotteState _, $Res Function(MyFlotteState) __);
}


/// Adds pattern-matching-related methods to [MyFlotteState].
extension MyFlotteStatePatterns on MyFlotteState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( GetEmployeesLoading value)?  getEmployeesLoading,TResult Function( GetEmployeesLoaded value)?  getEmployeesLoaded,TResult Function( GetEmployeesFailed value)?  getEmployeesFailed,TResult Function( CreateEmployeeLoading value)?  createEmployeeLoading,TResult Function( CreateEmployeeLoaded value)?  createEmployeeLoaded,TResult Function( CreateEmployeeFailed value)?  createEmployeeFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GetEmployeesLoading() when getEmployeesLoading != null:
return getEmployeesLoading(_that);case GetEmployeesLoaded() when getEmployeesLoaded != null:
return getEmployeesLoaded(_that);case GetEmployeesFailed() when getEmployeesFailed != null:
return getEmployeesFailed(_that);case CreateEmployeeLoading() when createEmployeeLoading != null:
return createEmployeeLoading(_that);case CreateEmployeeLoaded() when createEmployeeLoaded != null:
return createEmployeeLoaded(_that);case CreateEmployeeFailed() when createEmployeeFailed != null:
return createEmployeeFailed(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( GetEmployeesLoading value)  getEmployeesLoading,required TResult Function( GetEmployeesLoaded value)  getEmployeesLoaded,required TResult Function( GetEmployeesFailed value)  getEmployeesFailed,required TResult Function( CreateEmployeeLoading value)  createEmployeeLoading,required TResult Function( CreateEmployeeLoaded value)  createEmployeeLoaded,required TResult Function( CreateEmployeeFailed value)  createEmployeeFailed,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case GetEmployeesLoading():
return getEmployeesLoading(_that);case GetEmployeesLoaded():
return getEmployeesLoaded(_that);case GetEmployeesFailed():
return getEmployeesFailed(_that);case CreateEmployeeLoading():
return createEmployeeLoading(_that);case CreateEmployeeLoaded():
return createEmployeeLoaded(_that);case CreateEmployeeFailed():
return createEmployeeFailed(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( GetEmployeesLoading value)?  getEmployeesLoading,TResult? Function( GetEmployeesLoaded value)?  getEmployeesLoaded,TResult? Function( GetEmployeesFailed value)?  getEmployeesFailed,TResult? Function( CreateEmployeeLoading value)?  createEmployeeLoading,TResult? Function( CreateEmployeeLoaded value)?  createEmployeeLoaded,TResult? Function( CreateEmployeeFailed value)?  createEmployeeFailed,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GetEmployeesLoading() when getEmployeesLoading != null:
return getEmployeesLoading(_that);case GetEmployeesLoaded() when getEmployeesLoaded != null:
return getEmployeesLoaded(_that);case GetEmployeesFailed() when getEmployeesFailed != null:
return getEmployeesFailed(_that);case CreateEmployeeLoading() when createEmployeeLoading != null:
return createEmployeeLoading(_that);case CreateEmployeeLoaded() when createEmployeeLoaded != null:
return createEmployeeLoaded(_that);case CreateEmployeeFailed() when createEmployeeFailed != null:
return createEmployeeFailed(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  getEmployeesLoading,TResult Function( DataEmployeeResponseModel data)?  getEmployeesLoaded,TResult Function( String message)?  getEmployeesFailed,TResult Function()?  createEmployeeLoading,TResult Function( DataResponseModel data)?  createEmployeeLoaded,TResult Function( String message)?  createEmployeeFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GetEmployeesLoading() when getEmployeesLoading != null:
return getEmployeesLoading();case GetEmployeesLoaded() when getEmployeesLoaded != null:
return getEmployeesLoaded(_that.data);case GetEmployeesFailed() when getEmployeesFailed != null:
return getEmployeesFailed(_that.message);case CreateEmployeeLoading() when createEmployeeLoading != null:
return createEmployeeLoading();case CreateEmployeeLoaded() when createEmployeeLoaded != null:
return createEmployeeLoaded(_that.data);case CreateEmployeeFailed() when createEmployeeFailed != null:
return createEmployeeFailed(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  getEmployeesLoading,required TResult Function( DataEmployeeResponseModel data)  getEmployeesLoaded,required TResult Function( String message)  getEmployeesFailed,required TResult Function()  createEmployeeLoading,required TResult Function( DataResponseModel data)  createEmployeeLoaded,required TResult Function( String message)  createEmployeeFailed,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case GetEmployeesLoading():
return getEmployeesLoading();case GetEmployeesLoaded():
return getEmployeesLoaded(_that.data);case GetEmployeesFailed():
return getEmployeesFailed(_that.message);case CreateEmployeeLoading():
return createEmployeeLoading();case CreateEmployeeLoaded():
return createEmployeeLoaded(_that.data);case CreateEmployeeFailed():
return createEmployeeFailed(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  getEmployeesLoading,TResult? Function( DataEmployeeResponseModel data)?  getEmployeesLoaded,TResult? Function( String message)?  getEmployeesFailed,TResult? Function()?  createEmployeeLoading,TResult? Function( DataResponseModel data)?  createEmployeeLoaded,TResult? Function( String message)?  createEmployeeFailed,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GetEmployeesLoading() when getEmployeesLoading != null:
return getEmployeesLoading();case GetEmployeesLoaded() when getEmployeesLoaded != null:
return getEmployeesLoaded(_that.data);case GetEmployeesFailed() when getEmployeesFailed != null:
return getEmployeesFailed(_that.message);case CreateEmployeeLoading() when createEmployeeLoading != null:
return createEmployeeLoading();case CreateEmployeeLoaded() when createEmployeeLoaded != null:
return createEmployeeLoaded(_that.data);case CreateEmployeeFailed() when createEmployeeFailed != null:
return createEmployeeFailed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements MyFlotteState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyFlotteState.initial()';
}


}




/// @nodoc


class GetEmployeesLoading implements MyFlotteState {
  const GetEmployeesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetEmployeesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyFlotteState.getEmployeesLoading()';
}


}




/// @nodoc


class GetEmployeesLoaded implements MyFlotteState {
  const GetEmployeesLoaded({required this.data});
  

 final  DataEmployeeResponseModel data;

/// Create a copy of MyFlotteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetEmployeesLoadedCopyWith<GetEmployeesLoaded> get copyWith => _$GetEmployeesLoadedCopyWithImpl<GetEmployeesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetEmployeesLoaded&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'MyFlotteState.getEmployeesLoaded(data: $data)';
}


}

/// @nodoc
abstract mixin class $GetEmployeesLoadedCopyWith<$Res> implements $MyFlotteStateCopyWith<$Res> {
  factory $GetEmployeesLoadedCopyWith(GetEmployeesLoaded value, $Res Function(GetEmployeesLoaded) _then) = _$GetEmployeesLoadedCopyWithImpl;
@useResult
$Res call({
 DataEmployeeResponseModel data
});




}
/// @nodoc
class _$GetEmployeesLoadedCopyWithImpl<$Res>
    implements $GetEmployeesLoadedCopyWith<$Res> {
  _$GetEmployeesLoadedCopyWithImpl(this._self, this._then);

  final GetEmployeesLoaded _self;
  final $Res Function(GetEmployeesLoaded) _then;

/// Create a copy of MyFlotteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(GetEmployeesLoaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DataEmployeeResponseModel,
  ));
}


}

/// @nodoc


class GetEmployeesFailed implements MyFlotteState {
  const GetEmployeesFailed(this.message);
  

 final  String message;

/// Create a copy of MyFlotteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetEmployeesFailedCopyWith<GetEmployeesFailed> get copyWith => _$GetEmployeesFailedCopyWithImpl<GetEmployeesFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetEmployeesFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MyFlotteState.getEmployeesFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $GetEmployeesFailedCopyWith<$Res> implements $MyFlotteStateCopyWith<$Res> {
  factory $GetEmployeesFailedCopyWith(GetEmployeesFailed value, $Res Function(GetEmployeesFailed) _then) = _$GetEmployeesFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$GetEmployeesFailedCopyWithImpl<$Res>
    implements $GetEmployeesFailedCopyWith<$Res> {
  _$GetEmployeesFailedCopyWithImpl(this._self, this._then);

  final GetEmployeesFailed _self;
  final $Res Function(GetEmployeesFailed) _then;

/// Create a copy of MyFlotteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(GetEmployeesFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CreateEmployeeLoading implements MyFlotteState {
  const CreateEmployeeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateEmployeeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyFlotteState.createEmployeeLoading()';
}


}




/// @nodoc


class CreateEmployeeLoaded implements MyFlotteState {
  const CreateEmployeeLoaded({required this.data});
  

 final  DataResponseModel data;

/// Create a copy of MyFlotteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateEmployeeLoadedCopyWith<CreateEmployeeLoaded> get copyWith => _$CreateEmployeeLoadedCopyWithImpl<CreateEmployeeLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateEmployeeLoaded&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'MyFlotteState.createEmployeeLoaded(data: $data)';
}


}

/// @nodoc
abstract mixin class $CreateEmployeeLoadedCopyWith<$Res> implements $MyFlotteStateCopyWith<$Res> {
  factory $CreateEmployeeLoadedCopyWith(CreateEmployeeLoaded value, $Res Function(CreateEmployeeLoaded) _then) = _$CreateEmployeeLoadedCopyWithImpl;
@useResult
$Res call({
 DataResponseModel data
});




}
/// @nodoc
class _$CreateEmployeeLoadedCopyWithImpl<$Res>
    implements $CreateEmployeeLoadedCopyWith<$Res> {
  _$CreateEmployeeLoadedCopyWithImpl(this._self, this._then);

  final CreateEmployeeLoaded _self;
  final $Res Function(CreateEmployeeLoaded) _then;

/// Create a copy of MyFlotteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(CreateEmployeeLoaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DataResponseModel,
  ));
}


}

/// @nodoc


class CreateEmployeeFailed implements MyFlotteState {
  const CreateEmployeeFailed(this.message);
  

 final  String message;

/// Create a copy of MyFlotteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateEmployeeFailedCopyWith<CreateEmployeeFailed> get copyWith => _$CreateEmployeeFailedCopyWithImpl<CreateEmployeeFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateEmployeeFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MyFlotteState.createEmployeeFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $CreateEmployeeFailedCopyWith<$Res> implements $MyFlotteStateCopyWith<$Res> {
  factory $CreateEmployeeFailedCopyWith(CreateEmployeeFailed value, $Res Function(CreateEmployeeFailed) _then) = _$CreateEmployeeFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CreateEmployeeFailedCopyWithImpl<$Res>
    implements $CreateEmployeeFailedCopyWith<$Res> {
  _$CreateEmployeeFailedCopyWithImpl(this._self, this._then);

  final CreateEmployeeFailed _self;
  final $Res Function(CreateEmployeeFailed) _then;

/// Create a copy of MyFlotteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CreateEmployeeFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
