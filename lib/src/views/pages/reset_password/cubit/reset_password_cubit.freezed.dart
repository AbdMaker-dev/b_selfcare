// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResetPasswordState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ResetPasswordState()';
}


}

/// @nodoc
class $ResetPasswordStateCopyWith<$Res>  {
$ResetPasswordStateCopyWith(ResetPasswordState _, $Res Function(ResetPasswordState) __);
}


/// Adds pattern-matching-related methods to [ResetPasswordState].
extension ResetPasswordStatePatterns on ResetPasswordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( ResetPasswordLoading value)?  resetPasswordLoading,TResult Function( ChangePasswordLoading value)?  changePasswordLoading,TResult Function( ResetPasswordLoaded value)?  resetPasswordLoaded,TResult Function( ChangePasswordLoaded value)?  changePasswordLoaded,TResult Function( ResetPasswordError value)?  resetPasswordError,TResult Function( ChangePasswordError value)?  changePasswordError,TResult Function( ResetPasswordFailed value)?  resetPasswordFailed,TResult Function( ChangePasswordFailed value)?  changePasswordFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading(_that);case ChangePasswordLoading() when changePasswordLoading != null:
return changePasswordLoading(_that);case ResetPasswordLoaded() when resetPasswordLoaded != null:
return resetPasswordLoaded(_that);case ChangePasswordLoaded() when changePasswordLoaded != null:
return changePasswordLoaded(_that);case ResetPasswordError() when resetPasswordError != null:
return resetPasswordError(_that);case ChangePasswordError() when changePasswordError != null:
return changePasswordError(_that);case ResetPasswordFailed() when resetPasswordFailed != null:
return resetPasswordFailed(_that);case ChangePasswordFailed() when changePasswordFailed != null:
return changePasswordFailed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( ResetPasswordLoading value)  resetPasswordLoading,required TResult Function( ChangePasswordLoading value)  changePasswordLoading,required TResult Function( ResetPasswordLoaded value)  resetPasswordLoaded,required TResult Function( ChangePasswordLoaded value)  changePasswordLoaded,required TResult Function( ResetPasswordError value)  resetPasswordError,required TResult Function( ChangePasswordError value)  changePasswordError,required TResult Function( ResetPasswordFailed value)  resetPasswordFailed,required TResult Function( ChangePasswordFailed value)  changePasswordFailed,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case ResetPasswordLoading():
return resetPasswordLoading(_that);case ChangePasswordLoading():
return changePasswordLoading(_that);case ResetPasswordLoaded():
return resetPasswordLoaded(_that);case ChangePasswordLoaded():
return changePasswordLoaded(_that);case ResetPasswordError():
return resetPasswordError(_that);case ChangePasswordError():
return changePasswordError(_that);case ResetPasswordFailed():
return resetPasswordFailed(_that);case ChangePasswordFailed():
return changePasswordFailed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( ResetPasswordLoading value)?  resetPasswordLoading,TResult? Function( ChangePasswordLoading value)?  changePasswordLoading,TResult? Function( ResetPasswordLoaded value)?  resetPasswordLoaded,TResult? Function( ChangePasswordLoaded value)?  changePasswordLoaded,TResult? Function( ResetPasswordError value)?  resetPasswordError,TResult? Function( ChangePasswordError value)?  changePasswordError,TResult? Function( ResetPasswordFailed value)?  resetPasswordFailed,TResult? Function( ChangePasswordFailed value)?  changePasswordFailed,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading(_that);case ChangePasswordLoading() when changePasswordLoading != null:
return changePasswordLoading(_that);case ResetPasswordLoaded() when resetPasswordLoaded != null:
return resetPasswordLoaded(_that);case ChangePasswordLoaded() when changePasswordLoaded != null:
return changePasswordLoaded(_that);case ResetPasswordError() when resetPasswordError != null:
return resetPasswordError(_that);case ChangePasswordError() when changePasswordError != null:
return changePasswordError(_that);case ResetPasswordFailed() when resetPasswordFailed != null:
return resetPasswordFailed(_that);case ChangePasswordFailed() when changePasswordFailed != null:
return changePasswordFailed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  resetPasswordLoading,TResult Function()?  changePasswordLoading,TResult Function( DataResponseModel data)?  resetPasswordLoaded,TResult Function( DataResponseModel data)?  changePasswordLoaded,TResult Function( DataResponseModel data)?  resetPasswordError,TResult Function( DataResponseModel data)?  changePasswordError,TResult Function( String message)?  resetPasswordFailed,TResult Function( String message)?  changePasswordFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading();case ChangePasswordLoading() when changePasswordLoading != null:
return changePasswordLoading();case ResetPasswordLoaded() when resetPasswordLoaded != null:
return resetPasswordLoaded(_that.data);case ChangePasswordLoaded() when changePasswordLoaded != null:
return changePasswordLoaded(_that.data);case ResetPasswordError() when resetPasswordError != null:
return resetPasswordError(_that.data);case ChangePasswordError() when changePasswordError != null:
return changePasswordError(_that.data);case ResetPasswordFailed() when resetPasswordFailed != null:
return resetPasswordFailed(_that.message);case ChangePasswordFailed() when changePasswordFailed != null:
return changePasswordFailed(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  resetPasswordLoading,required TResult Function()  changePasswordLoading,required TResult Function( DataResponseModel data)  resetPasswordLoaded,required TResult Function( DataResponseModel data)  changePasswordLoaded,required TResult Function( DataResponseModel data)  resetPasswordError,required TResult Function( DataResponseModel data)  changePasswordError,required TResult Function( String message)  resetPasswordFailed,required TResult Function( String message)  changePasswordFailed,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case ResetPasswordLoading():
return resetPasswordLoading();case ChangePasswordLoading():
return changePasswordLoading();case ResetPasswordLoaded():
return resetPasswordLoaded(_that.data);case ChangePasswordLoaded():
return changePasswordLoaded(_that.data);case ResetPasswordError():
return resetPasswordError(_that.data);case ChangePasswordError():
return changePasswordError(_that.data);case ResetPasswordFailed():
return resetPasswordFailed(_that.message);case ChangePasswordFailed():
return changePasswordFailed(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  resetPasswordLoading,TResult? Function()?  changePasswordLoading,TResult? Function( DataResponseModel data)?  resetPasswordLoaded,TResult? Function( DataResponseModel data)?  changePasswordLoaded,TResult? Function( DataResponseModel data)?  resetPasswordError,TResult? Function( DataResponseModel data)?  changePasswordError,TResult? Function( String message)?  resetPasswordFailed,TResult? Function( String message)?  changePasswordFailed,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading();case ChangePasswordLoading() when changePasswordLoading != null:
return changePasswordLoading();case ResetPasswordLoaded() when resetPasswordLoaded != null:
return resetPasswordLoaded(_that.data);case ChangePasswordLoaded() when changePasswordLoaded != null:
return changePasswordLoaded(_that.data);case ResetPasswordError() when resetPasswordError != null:
return resetPasswordError(_that.data);case ChangePasswordError() when changePasswordError != null:
return changePasswordError(_that.data);case ResetPasswordFailed() when resetPasswordFailed != null:
return resetPasswordFailed(_that.message);case ChangePasswordFailed() when changePasswordFailed != null:
return changePasswordFailed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ResetPasswordState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ResetPasswordState.initial()';
}


}




/// @nodoc


class ResetPasswordLoading implements ResetPasswordState {
  const ResetPasswordLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ResetPasswordState.resetPasswordLoading()';
}


}




/// @nodoc


class ChangePasswordLoading implements ResetPasswordState {
  const ChangePasswordLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ResetPasswordState.changePasswordLoading()';
}


}




/// @nodoc


class ResetPasswordLoaded implements ResetPasswordState {
  const ResetPasswordLoaded({required this.data});
  

 final  DataResponseModel data;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordLoadedCopyWith<ResetPasswordLoaded> get copyWith => _$ResetPasswordLoadedCopyWithImpl<ResetPasswordLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordLoaded&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'ResetPasswordState.resetPasswordLoaded(data: $data)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordLoadedCopyWith<$Res> implements $ResetPasswordStateCopyWith<$Res> {
  factory $ResetPasswordLoadedCopyWith(ResetPasswordLoaded value, $Res Function(ResetPasswordLoaded) _then) = _$ResetPasswordLoadedCopyWithImpl;
@useResult
$Res call({
 DataResponseModel data
});




}
/// @nodoc
class _$ResetPasswordLoadedCopyWithImpl<$Res>
    implements $ResetPasswordLoadedCopyWith<$Res> {
  _$ResetPasswordLoadedCopyWithImpl(this._self, this._then);

  final ResetPasswordLoaded _self;
  final $Res Function(ResetPasswordLoaded) _then;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ResetPasswordLoaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DataResponseModel,
  ));
}


}

/// @nodoc


class ChangePasswordLoaded implements ResetPasswordState {
  const ChangePasswordLoaded({required this.data});
  

 final  DataResponseModel data;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordLoadedCopyWith<ChangePasswordLoaded> get copyWith => _$ChangePasswordLoadedCopyWithImpl<ChangePasswordLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordLoaded&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'ResetPasswordState.changePasswordLoaded(data: $data)';
}


}

/// @nodoc
abstract mixin class $ChangePasswordLoadedCopyWith<$Res> implements $ResetPasswordStateCopyWith<$Res> {
  factory $ChangePasswordLoadedCopyWith(ChangePasswordLoaded value, $Res Function(ChangePasswordLoaded) _then) = _$ChangePasswordLoadedCopyWithImpl;
@useResult
$Res call({
 DataResponseModel data
});




}
/// @nodoc
class _$ChangePasswordLoadedCopyWithImpl<$Res>
    implements $ChangePasswordLoadedCopyWith<$Res> {
  _$ChangePasswordLoadedCopyWithImpl(this._self, this._then);

  final ChangePasswordLoaded _self;
  final $Res Function(ChangePasswordLoaded) _then;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ChangePasswordLoaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DataResponseModel,
  ));
}


}

/// @nodoc


class ResetPasswordError implements ResetPasswordState {
  const ResetPasswordError({required this.data});
  

 final  DataResponseModel data;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordErrorCopyWith<ResetPasswordError> get copyWith => _$ResetPasswordErrorCopyWithImpl<ResetPasswordError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordError&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'ResetPasswordState.resetPasswordError(data: $data)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordErrorCopyWith<$Res> implements $ResetPasswordStateCopyWith<$Res> {
  factory $ResetPasswordErrorCopyWith(ResetPasswordError value, $Res Function(ResetPasswordError) _then) = _$ResetPasswordErrorCopyWithImpl;
@useResult
$Res call({
 DataResponseModel data
});




}
/// @nodoc
class _$ResetPasswordErrorCopyWithImpl<$Res>
    implements $ResetPasswordErrorCopyWith<$Res> {
  _$ResetPasswordErrorCopyWithImpl(this._self, this._then);

  final ResetPasswordError _self;
  final $Res Function(ResetPasswordError) _then;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ResetPasswordError(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DataResponseModel,
  ));
}


}

/// @nodoc


class ChangePasswordError implements ResetPasswordState {
  const ChangePasswordError({required this.data});
  

 final  DataResponseModel data;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordErrorCopyWith<ChangePasswordError> get copyWith => _$ChangePasswordErrorCopyWithImpl<ChangePasswordError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordError&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'ResetPasswordState.changePasswordError(data: $data)';
}


}

/// @nodoc
abstract mixin class $ChangePasswordErrorCopyWith<$Res> implements $ResetPasswordStateCopyWith<$Res> {
  factory $ChangePasswordErrorCopyWith(ChangePasswordError value, $Res Function(ChangePasswordError) _then) = _$ChangePasswordErrorCopyWithImpl;
@useResult
$Res call({
 DataResponseModel data
});




}
/// @nodoc
class _$ChangePasswordErrorCopyWithImpl<$Res>
    implements $ChangePasswordErrorCopyWith<$Res> {
  _$ChangePasswordErrorCopyWithImpl(this._self, this._then);

  final ChangePasswordError _self;
  final $Res Function(ChangePasswordError) _then;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ChangePasswordError(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DataResponseModel,
  ));
}


}

/// @nodoc


class ResetPasswordFailed implements ResetPasswordState {
  const ResetPasswordFailed(this.message);
  

 final  String message;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordFailedCopyWith<ResetPasswordFailed> get copyWith => _$ResetPasswordFailedCopyWithImpl<ResetPasswordFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ResetPasswordState.resetPasswordFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordFailedCopyWith<$Res> implements $ResetPasswordStateCopyWith<$Res> {
  factory $ResetPasswordFailedCopyWith(ResetPasswordFailed value, $Res Function(ResetPasswordFailed) _then) = _$ResetPasswordFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ResetPasswordFailedCopyWithImpl<$Res>
    implements $ResetPasswordFailedCopyWith<$Res> {
  _$ResetPasswordFailedCopyWithImpl(this._self, this._then);

  final ResetPasswordFailed _self;
  final $Res Function(ResetPasswordFailed) _then;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ResetPasswordFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChangePasswordFailed implements ResetPasswordState {
  const ChangePasswordFailed(this.message);
  

 final  String message;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordFailedCopyWith<ChangePasswordFailed> get copyWith => _$ChangePasswordFailedCopyWithImpl<ChangePasswordFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ResetPasswordState.changePasswordFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $ChangePasswordFailedCopyWith<$Res> implements $ResetPasswordStateCopyWith<$Res> {
  factory $ChangePasswordFailedCopyWith(ChangePasswordFailed value, $Res Function(ChangePasswordFailed) _then) = _$ChangePasswordFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ChangePasswordFailedCopyWithImpl<$Res>
    implements $ChangePasswordFailedCopyWith<$Res> {
  _$ChangePasswordFailedCopyWithImpl(this._self, this._then);

  final ChangePasswordFailed _self;
  final $Res Function(ChangePasswordFailed) _then;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ChangePasswordFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
