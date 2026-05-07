// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupState()';
}


}

/// @nodoc
class $GroupStateCopyWith<$Res>  {
$GroupStateCopyWith(GroupState _, $Res Function(GroupState) __);
}


/// Adds pattern-matching-related methods to [GroupState].
extension GroupStatePatterns on GroupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( GetGroupsLoading value)?  getGroupsLoading,TResult Function( GetGroupsLoaded value)?  getGroupsLoaded,TResult Function( GetGroupsFailed value)?  getGroupsFailed,TResult Function( CreateGroupeLoading value)?  createGroupeLoading,TResult Function( CreateGroupeLoaded value)?  createGroupeLoaded,TResult Function( CreateGroupeFailed value)?  createGroupeFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GetGroupsLoading() when getGroupsLoading != null:
return getGroupsLoading(_that);case GetGroupsLoaded() when getGroupsLoaded != null:
return getGroupsLoaded(_that);case GetGroupsFailed() when getGroupsFailed != null:
return getGroupsFailed(_that);case CreateGroupeLoading() when createGroupeLoading != null:
return createGroupeLoading(_that);case CreateGroupeLoaded() when createGroupeLoaded != null:
return createGroupeLoaded(_that);case CreateGroupeFailed() when createGroupeFailed != null:
return createGroupeFailed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( GetGroupsLoading value)  getGroupsLoading,required TResult Function( GetGroupsLoaded value)  getGroupsLoaded,required TResult Function( GetGroupsFailed value)  getGroupsFailed,required TResult Function( CreateGroupeLoading value)  createGroupeLoading,required TResult Function( CreateGroupeLoaded value)  createGroupeLoaded,required TResult Function( CreateGroupeFailed value)  createGroupeFailed,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case GetGroupsLoading():
return getGroupsLoading(_that);case GetGroupsLoaded():
return getGroupsLoaded(_that);case GetGroupsFailed():
return getGroupsFailed(_that);case CreateGroupeLoading():
return createGroupeLoading(_that);case CreateGroupeLoaded():
return createGroupeLoaded(_that);case CreateGroupeFailed():
return createGroupeFailed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( GetGroupsLoading value)?  getGroupsLoading,TResult? Function( GetGroupsLoaded value)?  getGroupsLoaded,TResult? Function( GetGroupsFailed value)?  getGroupsFailed,TResult? Function( CreateGroupeLoading value)?  createGroupeLoading,TResult? Function( CreateGroupeLoaded value)?  createGroupeLoaded,TResult? Function( CreateGroupeFailed value)?  createGroupeFailed,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GetGroupsLoading() when getGroupsLoading != null:
return getGroupsLoading(_that);case GetGroupsLoaded() when getGroupsLoaded != null:
return getGroupsLoaded(_that);case GetGroupsFailed() when getGroupsFailed != null:
return getGroupsFailed(_that);case CreateGroupeLoading() when createGroupeLoading != null:
return createGroupeLoading(_that);case CreateGroupeLoaded() when createGroupeLoaded != null:
return createGroupeLoaded(_that);case CreateGroupeFailed() when createGroupeFailed != null:
return createGroupeFailed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  getGroupsLoading,TResult Function( DataGroupResponseModel data)?  getGroupsLoaded,TResult Function( String message)?  getGroupsFailed,TResult Function()?  createGroupeLoading,TResult Function( DataResponseModel data)?  createGroupeLoaded,TResult Function( String message)?  createGroupeFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GetGroupsLoading() when getGroupsLoading != null:
return getGroupsLoading();case GetGroupsLoaded() when getGroupsLoaded != null:
return getGroupsLoaded(_that.data);case GetGroupsFailed() when getGroupsFailed != null:
return getGroupsFailed(_that.message);case CreateGroupeLoading() when createGroupeLoading != null:
return createGroupeLoading();case CreateGroupeLoaded() when createGroupeLoaded != null:
return createGroupeLoaded(_that.data);case CreateGroupeFailed() when createGroupeFailed != null:
return createGroupeFailed(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  getGroupsLoading,required TResult Function( DataGroupResponseModel data)  getGroupsLoaded,required TResult Function( String message)  getGroupsFailed,required TResult Function()  createGroupeLoading,required TResult Function( DataResponseModel data)  createGroupeLoaded,required TResult Function( String message)  createGroupeFailed,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case GetGroupsLoading():
return getGroupsLoading();case GetGroupsLoaded():
return getGroupsLoaded(_that.data);case GetGroupsFailed():
return getGroupsFailed(_that.message);case CreateGroupeLoading():
return createGroupeLoading();case CreateGroupeLoaded():
return createGroupeLoaded(_that.data);case CreateGroupeFailed():
return createGroupeFailed(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  getGroupsLoading,TResult? Function( DataGroupResponseModel data)?  getGroupsLoaded,TResult? Function( String message)?  getGroupsFailed,TResult? Function()?  createGroupeLoading,TResult? Function( DataResponseModel data)?  createGroupeLoaded,TResult? Function( String message)?  createGroupeFailed,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GetGroupsLoading() when getGroupsLoading != null:
return getGroupsLoading();case GetGroupsLoaded() when getGroupsLoaded != null:
return getGroupsLoaded(_that.data);case GetGroupsFailed() when getGroupsFailed != null:
return getGroupsFailed(_that.message);case CreateGroupeLoading() when createGroupeLoading != null:
return createGroupeLoading();case CreateGroupeLoaded() when createGroupeLoaded != null:
return createGroupeLoaded(_that.data);case CreateGroupeFailed() when createGroupeFailed != null:
return createGroupeFailed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements GroupState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupState.initial()';
}


}




/// @nodoc


class GetGroupsLoading implements GroupState {
  const GetGroupsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetGroupsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupState.getGroupsLoading()';
}


}




/// @nodoc


class GetGroupsLoaded implements GroupState {
  const GetGroupsLoaded({required this.data});
  

 final  DataGroupResponseModel data;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetGroupsLoadedCopyWith<GetGroupsLoaded> get copyWith => _$GetGroupsLoadedCopyWithImpl<GetGroupsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetGroupsLoaded&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'GroupState.getGroupsLoaded(data: $data)';
}


}

/// @nodoc
abstract mixin class $GetGroupsLoadedCopyWith<$Res> implements $GroupStateCopyWith<$Res> {
  factory $GetGroupsLoadedCopyWith(GetGroupsLoaded value, $Res Function(GetGroupsLoaded) _then) = _$GetGroupsLoadedCopyWithImpl;
@useResult
$Res call({
 DataGroupResponseModel data
});




}
/// @nodoc
class _$GetGroupsLoadedCopyWithImpl<$Res>
    implements $GetGroupsLoadedCopyWith<$Res> {
  _$GetGroupsLoadedCopyWithImpl(this._self, this._then);

  final GetGroupsLoaded _self;
  final $Res Function(GetGroupsLoaded) _then;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(GetGroupsLoaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DataGroupResponseModel,
  ));
}


}

/// @nodoc


class GetGroupsFailed implements GroupState {
  const GetGroupsFailed(this.message);
  

 final  String message;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetGroupsFailedCopyWith<GetGroupsFailed> get copyWith => _$GetGroupsFailedCopyWithImpl<GetGroupsFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetGroupsFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'GroupState.getGroupsFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $GetGroupsFailedCopyWith<$Res> implements $GroupStateCopyWith<$Res> {
  factory $GetGroupsFailedCopyWith(GetGroupsFailed value, $Res Function(GetGroupsFailed) _then) = _$GetGroupsFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$GetGroupsFailedCopyWithImpl<$Res>
    implements $GetGroupsFailedCopyWith<$Res> {
  _$GetGroupsFailedCopyWithImpl(this._self, this._then);

  final GetGroupsFailed _self;
  final $Res Function(GetGroupsFailed) _then;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(GetGroupsFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CreateGroupeLoading implements GroupState {
  const CreateGroupeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateGroupeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupState.createGroupeLoading()';
}


}




/// @nodoc


class CreateGroupeLoaded implements GroupState {
  const CreateGroupeLoaded({required this.data});
  

 final  DataResponseModel data;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateGroupeLoadedCopyWith<CreateGroupeLoaded> get copyWith => _$CreateGroupeLoadedCopyWithImpl<CreateGroupeLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateGroupeLoaded&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'GroupState.createGroupeLoaded(data: $data)';
}


}

/// @nodoc
abstract mixin class $CreateGroupeLoadedCopyWith<$Res> implements $GroupStateCopyWith<$Res> {
  factory $CreateGroupeLoadedCopyWith(CreateGroupeLoaded value, $Res Function(CreateGroupeLoaded) _then) = _$CreateGroupeLoadedCopyWithImpl;
@useResult
$Res call({
 DataResponseModel data
});




}
/// @nodoc
class _$CreateGroupeLoadedCopyWithImpl<$Res>
    implements $CreateGroupeLoadedCopyWith<$Res> {
  _$CreateGroupeLoadedCopyWithImpl(this._self, this._then);

  final CreateGroupeLoaded _self;
  final $Res Function(CreateGroupeLoaded) _then;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(CreateGroupeLoaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DataResponseModel,
  ));
}


}

/// @nodoc


class CreateGroupeFailed implements GroupState {
  const CreateGroupeFailed(this.message);
  

 final  String message;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateGroupeFailedCopyWith<CreateGroupeFailed> get copyWith => _$CreateGroupeFailedCopyWithImpl<CreateGroupeFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateGroupeFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'GroupState.createGroupeFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $CreateGroupeFailedCopyWith<$Res> implements $GroupStateCopyWith<$Res> {
  factory $CreateGroupeFailedCopyWith(CreateGroupeFailed value, $Res Function(CreateGroupeFailed) _then) = _$CreateGroupeFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CreateGroupeFailedCopyWithImpl<$Res>
    implements $CreateGroupeFailedCopyWith<$Res> {
  _$CreateGroupeFailedCopyWithImpl(this._self, this._then);

  final CreateGroupeFailed _self;
  final $Res Function(CreateGroupeFailed) _then;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CreateGroupeFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
