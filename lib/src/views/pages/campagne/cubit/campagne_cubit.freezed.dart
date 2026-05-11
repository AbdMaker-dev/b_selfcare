// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campagne_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CampagneState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampagneState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CampagneState()';
}


}

/// @nodoc
class $CampagneStateCopyWith<$Res>  {
$CampagneStateCopyWith(CampagneState _, $Res Function(CampagneState) __);
}


/// Adds pattern-matching-related methods to [CampagneState].
extension CampagneStatePatterns on CampagneState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( GetCampaignsLoading value)?  getCampaignsLoading,TResult Function( GetCampaignsLoaded value)?  getCampaignsLoaded,TResult Function( GetCampaignsFailed value)?  getCampaignsFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GetCampaignsLoading() when getCampaignsLoading != null:
return getCampaignsLoading(_that);case GetCampaignsLoaded() when getCampaignsLoaded != null:
return getCampaignsLoaded(_that);case GetCampaignsFailed() when getCampaignsFailed != null:
return getCampaignsFailed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( GetCampaignsLoading value)  getCampaignsLoading,required TResult Function( GetCampaignsLoaded value)  getCampaignsLoaded,required TResult Function( GetCampaignsFailed value)  getCampaignsFailed,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case GetCampaignsLoading():
return getCampaignsLoading(_that);case GetCampaignsLoaded():
return getCampaignsLoaded(_that);case GetCampaignsFailed():
return getCampaignsFailed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( GetCampaignsLoading value)?  getCampaignsLoading,TResult? Function( GetCampaignsLoaded value)?  getCampaignsLoaded,TResult? Function( GetCampaignsFailed value)?  getCampaignsFailed,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case GetCampaignsLoading() when getCampaignsLoading != null:
return getCampaignsLoading(_that);case GetCampaignsLoaded() when getCampaignsLoaded != null:
return getCampaignsLoaded(_that);case GetCampaignsFailed() when getCampaignsFailed != null:
return getCampaignsFailed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  getCampaignsLoading,TResult Function( DataCampaignResponseModel data)?  getCampaignsLoaded,TResult Function( String message)?  getCampaignsFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GetCampaignsLoading() when getCampaignsLoading != null:
return getCampaignsLoading();case GetCampaignsLoaded() when getCampaignsLoaded != null:
return getCampaignsLoaded(_that.data);case GetCampaignsFailed() when getCampaignsFailed != null:
return getCampaignsFailed(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  getCampaignsLoading,required TResult Function( DataCampaignResponseModel data)  getCampaignsLoaded,required TResult Function( String message)  getCampaignsFailed,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case GetCampaignsLoading():
return getCampaignsLoading();case GetCampaignsLoaded():
return getCampaignsLoaded(_that.data);case GetCampaignsFailed():
return getCampaignsFailed(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  getCampaignsLoading,TResult? Function( DataCampaignResponseModel data)?  getCampaignsLoaded,TResult? Function( String message)?  getCampaignsFailed,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case GetCampaignsLoading() when getCampaignsLoading != null:
return getCampaignsLoading();case GetCampaignsLoaded() when getCampaignsLoaded != null:
return getCampaignsLoaded(_that.data);case GetCampaignsFailed() when getCampaignsFailed != null:
return getCampaignsFailed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CampagneState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CampagneState.initial()';
}


}




/// @nodoc


class GetCampaignsLoading implements CampagneState {
  const GetCampaignsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCampaignsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CampagneState.getCampaignsLoading()';
}


}




/// @nodoc


class GetCampaignsLoaded implements CampagneState {
  const GetCampaignsLoaded({required this.data});
  

 final  DataCampaignResponseModel data;

/// Create a copy of CampagneState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetCampaignsLoadedCopyWith<GetCampaignsLoaded> get copyWith => _$GetCampaignsLoadedCopyWithImpl<GetCampaignsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCampaignsLoaded&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CampagneState.getCampaignsLoaded(data: $data)';
}


}

/// @nodoc
abstract mixin class $GetCampaignsLoadedCopyWith<$Res> implements $CampagneStateCopyWith<$Res> {
  factory $GetCampaignsLoadedCopyWith(GetCampaignsLoaded value, $Res Function(GetCampaignsLoaded) _then) = _$GetCampaignsLoadedCopyWithImpl;
@useResult
$Res call({
 DataCampaignResponseModel data
});




}
/// @nodoc
class _$GetCampaignsLoadedCopyWithImpl<$Res>
    implements $GetCampaignsLoadedCopyWith<$Res> {
  _$GetCampaignsLoadedCopyWithImpl(this._self, this._then);

  final GetCampaignsLoaded _self;
  final $Res Function(GetCampaignsLoaded) _then;

/// Create a copy of CampagneState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(GetCampaignsLoaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DataCampaignResponseModel,
  ));
}


}

/// @nodoc


class GetCampaignsFailed implements CampagneState {
  const GetCampaignsFailed(this.message);
  

 final  String message;

/// Create a copy of CampagneState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetCampaignsFailedCopyWith<GetCampaignsFailed> get copyWith => _$GetCampaignsFailedCopyWithImpl<GetCampaignsFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCampaignsFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CampagneState.getCampaignsFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $GetCampaignsFailedCopyWith<$Res> implements $CampagneStateCopyWith<$Res> {
  factory $GetCampaignsFailedCopyWith(GetCampaignsFailed value, $Res Function(GetCampaignsFailed) _then) = _$GetCampaignsFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$GetCampaignsFailedCopyWithImpl<$Res>
    implements $GetCampaignsFailedCopyWith<$Res> {
  _$GetCampaignsFailedCopyWithImpl(this._self, this._then);

  final GetCampaignsFailed _self;
  final $Res Function(GetCampaignsFailed) _then;

/// Create a copy of CampagneState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(GetCampaignsFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
