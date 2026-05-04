// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState()';
}


}

/// @nodoc
class $LoginStateCopyWith<$Res>  {
$LoginStateCopyWith(LoginState _, $Res Function(LoginState) __);
}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Submitting value)?  submitting,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,TResult Function( _OtpSubmitting value)?  otpSubmitting,TResult Function( _OtpSuccess value)?  otpSuccess,TResult Function( _OtpError value)?  otpError,TResult Function( _ResendOtpSubmitting value)?  resendOtpSubmitting,TResult Function( _ResendOtpSuccess value)?  resendOtpSuccess,TResult Function( _ResendOtpError value)?  resendOtpError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Submitting() when submitting != null:
return submitting(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _OtpSubmitting() when otpSubmitting != null:
return otpSubmitting(_that);case _OtpSuccess() when otpSuccess != null:
return otpSuccess(_that);case _OtpError() when otpError != null:
return otpError(_that);case _ResendOtpSubmitting() when resendOtpSubmitting != null:
return resendOtpSubmitting(_that);case _ResendOtpSuccess() when resendOtpSuccess != null:
return resendOtpSuccess(_that);case _ResendOtpError() when resendOtpError != null:
return resendOtpError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Submitting value)  submitting,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,required TResult Function( _OtpSubmitting value)  otpSubmitting,required TResult Function( _OtpSuccess value)  otpSuccess,required TResult Function( _OtpError value)  otpError,required TResult Function( _ResendOtpSubmitting value)  resendOtpSubmitting,required TResult Function( _ResendOtpSuccess value)  resendOtpSuccess,required TResult Function( _ResendOtpError value)  resendOtpError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Submitting():
return submitting(_that);case _Success():
return success(_that);case _Error():
return error(_that);case _OtpSubmitting():
return otpSubmitting(_that);case _OtpSuccess():
return otpSuccess(_that);case _OtpError():
return otpError(_that);case _ResendOtpSubmitting():
return resendOtpSubmitting(_that);case _ResendOtpSuccess():
return resendOtpSuccess(_that);case _ResendOtpError():
return resendOtpError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Submitting value)?  submitting,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,TResult? Function( _OtpSubmitting value)?  otpSubmitting,TResult? Function( _OtpSuccess value)?  otpSuccess,TResult? Function( _OtpError value)?  otpError,TResult? Function( _ResendOtpSubmitting value)?  resendOtpSubmitting,TResult? Function( _ResendOtpSuccess value)?  resendOtpSuccess,TResult? Function( _ResendOtpError value)?  resendOtpError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Submitting() when submitting != null:
return submitting(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _OtpSubmitting() when otpSubmitting != null:
return otpSubmitting(_that);case _OtpSuccess() when otpSuccess != null:
return otpSuccess(_that);case _OtpError() when otpError != null:
return otpError(_that);case _ResendOtpSubmitting() when resendOtpSubmitting != null:
return resendOtpSubmitting(_that);case _ResendOtpSuccess() when resendOtpSuccess != null:
return resendOtpSuccess(_that);case _ResendOtpError() when resendOtpError != null:
return resendOtpError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  submitting,TResult Function( String mfaToken)?  success,TResult Function( String? message)?  error,TResult Function()?  otpSubmitting,TResult Function()?  otpSuccess,TResult Function( String? message)?  otpError,TResult Function()?  resendOtpSubmitting,TResult Function( String mfaToken)?  resendOtpSuccess,TResult Function( String? message)?  resendOtpError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Submitting() when submitting != null:
return submitting();case _Success() when success != null:
return success(_that.mfaToken);case _Error() when error != null:
return error(_that.message);case _OtpSubmitting() when otpSubmitting != null:
return otpSubmitting();case _OtpSuccess() when otpSuccess != null:
return otpSuccess();case _OtpError() when otpError != null:
return otpError(_that.message);case _ResendOtpSubmitting() when resendOtpSubmitting != null:
return resendOtpSubmitting();case _ResendOtpSuccess() when resendOtpSuccess != null:
return resendOtpSuccess(_that.mfaToken);case _ResendOtpError() when resendOtpError != null:
return resendOtpError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  submitting,required TResult Function( String mfaToken)  success,required TResult Function( String? message)  error,required TResult Function()  otpSubmitting,required TResult Function()  otpSuccess,required TResult Function( String? message)  otpError,required TResult Function()  resendOtpSubmitting,required TResult Function( String mfaToken)  resendOtpSuccess,required TResult Function( String? message)  resendOtpError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Submitting():
return submitting();case _Success():
return success(_that.mfaToken);case _Error():
return error(_that.message);case _OtpSubmitting():
return otpSubmitting();case _OtpSuccess():
return otpSuccess();case _OtpError():
return otpError(_that.message);case _ResendOtpSubmitting():
return resendOtpSubmitting();case _ResendOtpSuccess():
return resendOtpSuccess(_that.mfaToken);case _ResendOtpError():
return resendOtpError(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  submitting,TResult? Function( String mfaToken)?  success,TResult? Function( String? message)?  error,TResult? Function()?  otpSubmitting,TResult? Function()?  otpSuccess,TResult? Function( String? message)?  otpError,TResult? Function()?  resendOtpSubmitting,TResult? Function( String mfaToken)?  resendOtpSuccess,TResult? Function( String? message)?  resendOtpError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Submitting() when submitting != null:
return submitting();case _Success() when success != null:
return success(_that.mfaToken);case _Error() when error != null:
return error(_that.message);case _OtpSubmitting() when otpSubmitting != null:
return otpSubmitting();case _OtpSuccess() when otpSuccess != null:
return otpSuccess();case _OtpError() when otpError != null:
return otpError(_that.message);case _ResendOtpSubmitting() when resendOtpSubmitting != null:
return resendOtpSubmitting();case _ResendOtpSuccess() when resendOtpSuccess != null:
return resendOtpSuccess(_that.mfaToken);case _ResendOtpError() when resendOtpError != null:
return resendOtpError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements LoginState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.initial()';
}


}




/// @nodoc


class _Submitting implements LoginState {
  const _Submitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.submitting()';
}


}




/// @nodoc


class _Success implements LoginState {
  const _Success(this.mfaToken);
  

 final  String mfaToken;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.mfaToken, mfaToken) || other.mfaToken == mfaToken));
}


@override
int get hashCode => Object.hash(runtimeType,mfaToken);

@override
String toString() {
  return 'LoginState.success(mfaToken: $mfaToken)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 String mfaToken
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mfaToken = null,}) {
  return _then(_Success(
null == mfaToken ? _self.mfaToken : mfaToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Error implements LoginState {
  const _Error(this.message);
  

 final  String? message;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LoginState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_Error(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _OtpSubmitting implements LoginState {
  const _OtpSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.otpSubmitting()';
}


}




/// @nodoc


class _OtpSuccess implements LoginState {
  const _OtpSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.otpSuccess()';
}


}




/// @nodoc


class _OtpError implements LoginState {
  const _OtpError(this.message);
  

 final  String? message;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpErrorCopyWith<_OtpError> get copyWith => __$OtpErrorCopyWithImpl<_OtpError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LoginState.otpError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$OtpErrorCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$OtpErrorCopyWith(_OtpError value, $Res Function(_OtpError) _then) = __$OtpErrorCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$OtpErrorCopyWithImpl<$Res>
    implements _$OtpErrorCopyWith<$Res> {
  __$OtpErrorCopyWithImpl(this._self, this._then);

  final _OtpError _self;
  final $Res Function(_OtpError) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_OtpError(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ResendOtpSubmitting implements LoginState {
  const _ResendOtpSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendOtpSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.resendOtpSubmitting()';
}


}




/// @nodoc


class _ResendOtpSuccess implements LoginState {
  const _ResendOtpSuccess(this.mfaToken);
  

 final  String mfaToken;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResendOtpSuccessCopyWith<_ResendOtpSuccess> get copyWith => __$ResendOtpSuccessCopyWithImpl<_ResendOtpSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendOtpSuccess&&(identical(other.mfaToken, mfaToken) || other.mfaToken == mfaToken));
}


@override
int get hashCode => Object.hash(runtimeType,mfaToken);

@override
String toString() {
  return 'LoginState.resendOtpSuccess(mfaToken: $mfaToken)';
}


}

/// @nodoc
abstract mixin class _$ResendOtpSuccessCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$ResendOtpSuccessCopyWith(_ResendOtpSuccess value, $Res Function(_ResendOtpSuccess) _then) = __$ResendOtpSuccessCopyWithImpl;
@useResult
$Res call({
 String mfaToken
});




}
/// @nodoc
class __$ResendOtpSuccessCopyWithImpl<$Res>
    implements _$ResendOtpSuccessCopyWith<$Res> {
  __$ResendOtpSuccessCopyWithImpl(this._self, this._then);

  final _ResendOtpSuccess _self;
  final $Res Function(_ResendOtpSuccess) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mfaToken = null,}) {
  return _then(_ResendOtpSuccess(
null == mfaToken ? _self.mfaToken : mfaToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResendOtpError implements LoginState {
  const _ResendOtpError(this.message);
  

 final  String? message;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResendOtpErrorCopyWith<_ResendOtpError> get copyWith => __$ResendOtpErrorCopyWithImpl<_ResendOtpError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendOtpError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LoginState.resendOtpError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ResendOtpErrorCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$ResendOtpErrorCopyWith(_ResendOtpError value, $Res Function(_ResendOtpError) _then) = __$ResendOtpErrorCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$ResendOtpErrorCopyWithImpl<$Res>
    implements _$ResendOtpErrorCopyWith<$Res> {
  __$ResendOtpErrorCopyWithImpl(this._self, this._then);

  final _ResendOtpError _self;
  final $Res Function(_ResendOtpError) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_ResendOtpError(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
