// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UsersState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersState()';
}


}

/// @nodoc
class $UsersStateCopyWith<$Res>  {
$UsersStateCopyWith(UsersState _, $Res Function(UsersState) __);
}


/// Adds pattern-matching-related methods to [UsersState].
extension UsersStatePatterns on UsersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( GetUsersLoading value)?  getUsersLoading,TResult Function( GetUsersLoaded value)?  getUsersLoaded,TResult Function( GetUsersFailed value)?  getUsersFailed,TResult Function( CreateUserLoading value)?  createUserLoading,TResult Function( CreateUserLoaded value)?  createUserLoaded,TResult Function( CreateUserFailed value)?  createUserFailed,TResult Function( UpdateUserLoading value)?  updateUserLoading,TResult Function( UpdateUserLoaded value)?  updateUserLoaded,TResult Function( UpdateUserFailed value)?  updateUserFailed,TResult Function( DisableUserLoading value)?  disableUserLoading,TResult Function( DisableUserLoaded value)?  disableUserLoaded,TResult Function( DisableUserFailed value)?  disableUserFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GetUsersLoading() when getUsersLoading != null:
return getUsersLoading(_that);case GetUsersLoaded() when getUsersLoaded != null:
return getUsersLoaded(_that);case GetUsersFailed() when getUsersFailed != null:
return getUsersFailed(_that);case CreateUserLoading() when createUserLoading != null:
return createUserLoading(_that);case CreateUserLoaded() when createUserLoaded != null:
return createUserLoaded(_that);case CreateUserFailed() when createUserFailed != null:
return createUserFailed(_that);case UpdateUserLoading() when updateUserLoading != null:
return updateUserLoading(_that);case UpdateUserLoaded() when updateUserLoaded != null:
return updateUserLoaded(_that);case UpdateUserFailed() when updateUserFailed != null:
return updateUserFailed(_that);case DisableUserLoading() when disableUserLoading != null:
return disableUserLoading(_that);case DisableUserLoaded() when disableUserLoaded != null:
return disableUserLoaded(_that);case DisableUserFailed() when disableUserFailed != null:
return disableUserFailed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( GetUsersLoading value)  getUsersLoading,required TResult Function( GetUsersLoaded value)  getUsersLoaded,required TResult Function( GetUsersFailed value)  getUsersFailed,required TResult Function( CreateUserLoading value)  createUserLoading,required TResult Function( CreateUserLoaded value)  createUserLoaded,required TResult Function( CreateUserFailed value)  createUserFailed,required TResult Function( UpdateUserLoading value)  updateUserLoading,required TResult Function( UpdateUserLoaded value)  updateUserLoaded,required TResult Function( UpdateUserFailed value)  updateUserFailed,required TResult Function( DisableUserLoading value)  disableUserLoading,required TResult Function( DisableUserLoaded value)  disableUserLoaded,required TResult Function( DisableUserFailed value)  disableUserFailed,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case GetUsersLoading():
return getUsersLoading(_that);case GetUsersLoaded():
return getUsersLoaded(_that);case GetUsersFailed():
return getUsersFailed(_that);case CreateUserLoading():
return createUserLoading(_that);case CreateUserLoaded():
return createUserLoaded(_that);case CreateUserFailed():
return createUserFailed(_that);case UpdateUserLoading():
return updateUserLoading(_that);case UpdateUserLoaded():
return updateUserLoaded(_that);case UpdateUserFailed():
return updateUserFailed(_that);case DisableUserLoading():
return disableUserLoading(_that);case DisableUserLoaded():
return disableUserLoaded(_that);case DisableUserFailed():
return disableUserFailed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( GetUsersLoading value)?  getUsersLoading,TResult? Function( GetUsersLoaded value)?  getUsersLoaded,TResult? Function( GetUsersFailed value)?  getUsersFailed,TResult? Function( CreateUserLoading value)?  createUserLoading,TResult? Function( CreateUserLoaded value)?  createUserLoaded,TResult? Function( CreateUserFailed value)?  createUserFailed,TResult? Function( UpdateUserLoading value)?  updateUserLoading,TResult? Function( UpdateUserLoaded value)?  updateUserLoaded,TResult? Function( UpdateUserFailed value)?  updateUserFailed,TResult? Function( DisableUserLoading value)?  disableUserLoading,TResult? Function( DisableUserLoaded value)?  disableUserLoaded,TResult? Function( DisableUserFailed value)?  disableUserFailed,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GetUsersLoading() when getUsersLoading != null:
return getUsersLoading(_that);case GetUsersLoaded() when getUsersLoaded != null:
return getUsersLoaded(_that);case GetUsersFailed() when getUsersFailed != null:
return getUsersFailed(_that);case CreateUserLoading() when createUserLoading != null:
return createUserLoading(_that);case CreateUserLoaded() when createUserLoaded != null:
return createUserLoaded(_that);case CreateUserFailed() when createUserFailed != null:
return createUserFailed(_that);case UpdateUserLoading() when updateUserLoading != null:
return updateUserLoading(_that);case UpdateUserLoaded() when updateUserLoaded != null:
return updateUserLoaded(_that);case UpdateUserFailed() when updateUserFailed != null:
return updateUserFailed(_that);case DisableUserLoading() when disableUserLoading != null:
return disableUserLoading(_that);case DisableUserLoaded() when disableUserLoaded != null:
return disableUserLoaded(_that);case DisableUserFailed() when disableUserFailed != null:
return disableUserFailed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  getUsersLoading,TResult Function()?  getUsersLoaded,TResult Function( String message)?  getUsersFailed,TResult Function()?  createUserLoading,TResult Function()?  createUserLoaded,TResult Function( String message)?  createUserFailed,TResult Function()?  updateUserLoading,TResult Function()?  updateUserLoaded,TResult Function( String message)?  updateUserFailed,TResult Function()?  disableUserLoading,TResult Function()?  disableUserLoaded,TResult Function( String message)?  disableUserFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GetUsersLoading() when getUsersLoading != null:
return getUsersLoading();case GetUsersLoaded() when getUsersLoaded != null:
return getUsersLoaded();case GetUsersFailed() when getUsersFailed != null:
return getUsersFailed(_that.message);case CreateUserLoading() when createUserLoading != null:
return createUserLoading();case CreateUserLoaded() when createUserLoaded != null:
return createUserLoaded();case CreateUserFailed() when createUserFailed != null:
return createUserFailed(_that.message);case UpdateUserLoading() when updateUserLoading != null:
return updateUserLoading();case UpdateUserLoaded() when updateUserLoaded != null:
return updateUserLoaded();case UpdateUserFailed() when updateUserFailed != null:
return updateUserFailed(_that.message);case DisableUserLoading() when disableUserLoading != null:
return disableUserLoading();case DisableUserLoaded() when disableUserLoaded != null:
return disableUserLoaded();case DisableUserFailed() when disableUserFailed != null:
return disableUserFailed(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  getUsersLoading,required TResult Function()  getUsersLoaded,required TResult Function( String message)  getUsersFailed,required TResult Function()  createUserLoading,required TResult Function()  createUserLoaded,required TResult Function( String message)  createUserFailed,required TResult Function()  updateUserLoading,required TResult Function()  updateUserLoaded,required TResult Function( String message)  updateUserFailed,required TResult Function()  disableUserLoading,required TResult Function()  disableUserLoaded,required TResult Function( String message)  disableUserFailed,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case GetUsersLoading():
return getUsersLoading();case GetUsersLoaded():
return getUsersLoaded();case GetUsersFailed():
return getUsersFailed(_that.message);case CreateUserLoading():
return createUserLoading();case CreateUserLoaded():
return createUserLoaded();case CreateUserFailed():
return createUserFailed(_that.message);case UpdateUserLoading():
return updateUserLoading();case UpdateUserLoaded():
return updateUserLoaded();case UpdateUserFailed():
return updateUserFailed(_that.message);case DisableUserLoading():
return disableUserLoading();case DisableUserLoaded():
return disableUserLoaded();case DisableUserFailed():
return disableUserFailed(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  getUsersLoading,TResult? Function()?  getUsersLoaded,TResult? Function( String message)?  getUsersFailed,TResult? Function()?  createUserLoading,TResult? Function()?  createUserLoaded,TResult? Function( String message)?  createUserFailed,TResult? Function()?  updateUserLoading,TResult? Function()?  updateUserLoaded,TResult? Function( String message)?  updateUserFailed,TResult? Function()?  disableUserLoading,TResult? Function()?  disableUserLoaded,TResult? Function( String message)?  disableUserFailed,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GetUsersLoading() when getUsersLoading != null:
return getUsersLoading();case GetUsersLoaded() when getUsersLoaded != null:
return getUsersLoaded();case GetUsersFailed() when getUsersFailed != null:
return getUsersFailed(_that.message);case CreateUserLoading() when createUserLoading != null:
return createUserLoading();case CreateUserLoaded() when createUserLoaded != null:
return createUserLoaded();case CreateUserFailed() when createUserFailed != null:
return createUserFailed(_that.message);case UpdateUserLoading() when updateUserLoading != null:
return updateUserLoading();case UpdateUserLoaded() when updateUserLoaded != null:
return updateUserLoaded();case UpdateUserFailed() when updateUserFailed != null:
return updateUserFailed(_that.message);case DisableUserLoading() when disableUserLoading != null:
return disableUserLoading();case DisableUserLoaded() when disableUserLoaded != null:
return disableUserLoaded();case DisableUserFailed() when disableUserFailed != null:
return disableUserFailed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements UsersState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersState.initial()';
}


}




/// @nodoc


class GetUsersLoading implements UsersState {
  const GetUsersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetUsersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersState.getUsersLoading()';
}


}




/// @nodoc


class GetUsersLoaded implements UsersState {
  const GetUsersLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetUsersLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersState.getUsersLoaded()';
}


}




/// @nodoc


class GetUsersFailed implements UsersState {
  const GetUsersFailed(this.message);
  

 final  String message;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetUsersFailedCopyWith<GetUsersFailed> get copyWith => _$GetUsersFailedCopyWithImpl<GetUsersFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetUsersFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UsersState.getUsersFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $GetUsersFailedCopyWith<$Res> implements $UsersStateCopyWith<$Res> {
  factory $GetUsersFailedCopyWith(GetUsersFailed value, $Res Function(GetUsersFailed) _then) = _$GetUsersFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$GetUsersFailedCopyWithImpl<$Res>
    implements $GetUsersFailedCopyWith<$Res> {
  _$GetUsersFailedCopyWithImpl(this._self, this._then);

  final GetUsersFailed _self;
  final $Res Function(GetUsersFailed) _then;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(GetUsersFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CreateUserLoading implements UsersState {
  const CreateUserLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateUserLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersState.createUserLoading()';
}


}




/// @nodoc


class CreateUserLoaded implements UsersState {
  const CreateUserLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateUserLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersState.createUserLoaded()';
}


}




/// @nodoc


class CreateUserFailed implements UsersState {
  const CreateUserFailed(this.message);
  

 final  String message;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateUserFailedCopyWith<CreateUserFailed> get copyWith => _$CreateUserFailedCopyWithImpl<CreateUserFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateUserFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UsersState.createUserFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $CreateUserFailedCopyWith<$Res> implements $UsersStateCopyWith<$Res> {
  factory $CreateUserFailedCopyWith(CreateUserFailed value, $Res Function(CreateUserFailed) _then) = _$CreateUserFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CreateUserFailedCopyWithImpl<$Res>
    implements $CreateUserFailedCopyWith<$Res> {
  _$CreateUserFailedCopyWithImpl(this._self, this._then);

  final CreateUserFailed _self;
  final $Res Function(CreateUserFailed) _then;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CreateUserFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UpdateUserLoading implements UsersState {
  const UpdateUserLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersState.updateUserLoading()';
}


}




/// @nodoc


class UpdateUserLoaded implements UsersState {
  const UpdateUserLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersState.updateUserLoaded()';
}


}




/// @nodoc


class UpdateUserFailed implements UsersState {
  const UpdateUserFailed(this.message);
  

 final  String message;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateUserFailedCopyWith<UpdateUserFailed> get copyWith => _$UpdateUserFailedCopyWithImpl<UpdateUserFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UsersState.updateUserFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $UpdateUserFailedCopyWith<$Res> implements $UsersStateCopyWith<$Res> {
  factory $UpdateUserFailedCopyWith(UpdateUserFailed value, $Res Function(UpdateUserFailed) _then) = _$UpdateUserFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$UpdateUserFailedCopyWithImpl<$Res>
    implements $UpdateUserFailedCopyWith<$Res> {
  _$UpdateUserFailedCopyWithImpl(this._self, this._then);

  final UpdateUserFailed _self;
  final $Res Function(UpdateUserFailed) _then;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(UpdateUserFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DisableUserLoading implements UsersState {
  const DisableUserLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisableUserLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersState.disableUserLoading()';
}


}




/// @nodoc


class DisableUserLoaded implements UsersState {
  const DisableUserLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisableUserLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersState.disableUserLoaded()';
}


}




/// @nodoc


class DisableUserFailed implements UsersState {
  const DisableUserFailed(this.message);
  

 final  String message;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisableUserFailedCopyWith<DisableUserFailed> get copyWith => _$DisableUserFailedCopyWithImpl<DisableUserFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisableUserFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'UsersState.disableUserFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $DisableUserFailedCopyWith<$Res> implements $UsersStateCopyWith<$Res> {
  factory $DisableUserFailedCopyWith(DisableUserFailed value, $Res Function(DisableUserFailed) _then) = _$DisableUserFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DisableUserFailedCopyWithImpl<$Res>
    implements $DisableUserFailedCopyWith<$Res> {
  _$DisableUserFailedCopyWithImpl(this._self, this._then);

  final DisableUserFailed _self;
  final $Res Function(DisableUserFailed) _then;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DisableUserFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
