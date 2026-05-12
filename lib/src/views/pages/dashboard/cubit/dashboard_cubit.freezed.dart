// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState()';
}


}

/// @nodoc
class $DashboardStateCopyWith<$Res>  {
$DashboardStateCopyWith(DashboardState _, $Res Function(DashboardState) __);
}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _DashboardLoading value)?  dashboardLoading,TResult Function( _DashboardError value)?  dashboardError,TResult Function( _DashboardLoaded value)?  dashboardLoaded,TResult Function( _ProvisioningStatsLoading value)?  provisioningStatsLoading,TResult Function( _ProvisioningStatsError value)?  provisioningStatsError,TResult Function( _ProvisioningStatsLoaded value)?  provisioningStatsLoaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _DashboardLoading() when dashboardLoading != null:
return dashboardLoading(_that);case _DashboardError() when dashboardError != null:
return dashboardError(_that);case _DashboardLoaded() when dashboardLoaded != null:
return dashboardLoaded(_that);case _ProvisioningStatsLoading() when provisioningStatsLoading != null:
return provisioningStatsLoading(_that);case _ProvisioningStatsError() when provisioningStatsError != null:
return provisioningStatsError(_that);case _ProvisioningStatsLoaded() when provisioningStatsLoaded != null:
return provisioningStatsLoaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _DashboardLoading value)  dashboardLoading,required TResult Function( _DashboardError value)  dashboardError,required TResult Function( _DashboardLoaded value)  dashboardLoaded,required TResult Function( _ProvisioningStatsLoading value)  provisioningStatsLoading,required TResult Function( _ProvisioningStatsError value)  provisioningStatsError,required TResult Function( _ProvisioningStatsLoaded value)  provisioningStatsLoaded,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _DashboardLoading():
return dashboardLoading(_that);case _DashboardError():
return dashboardError(_that);case _DashboardLoaded():
return dashboardLoaded(_that);case _ProvisioningStatsLoading():
return provisioningStatsLoading(_that);case _ProvisioningStatsError():
return provisioningStatsError(_that);case _ProvisioningStatsLoaded():
return provisioningStatsLoaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _DashboardLoading value)?  dashboardLoading,TResult? Function( _DashboardError value)?  dashboardError,TResult? Function( _DashboardLoaded value)?  dashboardLoaded,TResult? Function( _ProvisioningStatsLoading value)?  provisioningStatsLoading,TResult? Function( _ProvisioningStatsError value)?  provisioningStatsError,TResult? Function( _ProvisioningStatsLoaded value)?  provisioningStatsLoaded,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _DashboardLoading() when dashboardLoading != null:
return dashboardLoading(_that);case _DashboardError() when dashboardError != null:
return dashboardError(_that);case _DashboardLoaded() when dashboardLoaded != null:
return dashboardLoaded(_that);case _ProvisioningStatsLoading() when provisioningStatsLoading != null:
return provisioningStatsLoading(_that);case _ProvisioningStatsError() when provisioningStatsError != null:
return provisioningStatsError(_that);case _ProvisioningStatsLoaded() when provisioningStatsLoaded != null:
return provisioningStatsLoaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  dashboardLoading,TResult Function( String? message)?  dashboardError,TResult Function()?  dashboardLoaded,TResult Function()?  provisioningStatsLoading,TResult Function( String? message)?  provisioningStatsError,TResult Function()?  provisioningStatsLoaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _DashboardLoading() when dashboardLoading != null:
return dashboardLoading();case _DashboardError() when dashboardError != null:
return dashboardError(_that.message);case _DashboardLoaded() when dashboardLoaded != null:
return dashboardLoaded();case _ProvisioningStatsLoading() when provisioningStatsLoading != null:
return provisioningStatsLoading();case _ProvisioningStatsError() when provisioningStatsError != null:
return provisioningStatsError(_that.message);case _ProvisioningStatsLoaded() when provisioningStatsLoaded != null:
return provisioningStatsLoaded();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  dashboardLoading,required TResult Function( String? message)  dashboardError,required TResult Function()  dashboardLoaded,required TResult Function()  provisioningStatsLoading,required TResult Function( String? message)  provisioningStatsError,required TResult Function()  provisioningStatsLoaded,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _DashboardLoading():
return dashboardLoading();case _DashboardError():
return dashboardError(_that.message);case _DashboardLoaded():
return dashboardLoaded();case _ProvisioningStatsLoading():
return provisioningStatsLoading();case _ProvisioningStatsError():
return provisioningStatsError(_that.message);case _ProvisioningStatsLoaded():
return provisioningStatsLoaded();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  dashboardLoading,TResult? Function( String? message)?  dashboardError,TResult? Function()?  dashboardLoaded,TResult? Function()?  provisioningStatsLoading,TResult? Function( String? message)?  provisioningStatsError,TResult? Function()?  provisioningStatsLoaded,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _DashboardLoading() when dashboardLoading != null:
return dashboardLoading();case _DashboardError() when dashboardError != null:
return dashboardError(_that.message);case _DashboardLoaded() when dashboardLoaded != null:
return dashboardLoaded();case _ProvisioningStatsLoading() when provisioningStatsLoading != null:
return provisioningStatsLoading();case _ProvisioningStatsError() when provisioningStatsError != null:
return provisioningStatsError(_that.message);case _ProvisioningStatsLoaded() when provisioningStatsLoaded != null:
return provisioningStatsLoaded();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements DashboardState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState.initial()';
}


}




/// @nodoc


class _DashboardLoading implements DashboardState {
  const _DashboardLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState.dashboardLoading()';
}


}




/// @nodoc


class _DashboardError implements DashboardState {
  const _DashboardError(this.message);
  

 final  String? message;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardErrorCopyWith<_DashboardError> get copyWith => __$DashboardErrorCopyWithImpl<_DashboardError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DashboardState.dashboardError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$DashboardErrorCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardErrorCopyWith(_DashboardError value, $Res Function(_DashboardError) _then) = __$DashboardErrorCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$DashboardErrorCopyWithImpl<$Res>
    implements _$DashboardErrorCopyWith<$Res> {
  __$DashboardErrorCopyWithImpl(this._self, this._then);

  final _DashboardError _self;
  final $Res Function(_DashboardError) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_DashboardError(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _DashboardLoaded implements DashboardState {
  const _DashboardLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState.dashboardLoaded()';
}


}




/// @nodoc


class _ProvisioningStatsLoading implements DashboardState {
  const _ProvisioningStatsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProvisioningStatsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState.provisioningStatsLoading()';
}


}




/// @nodoc


class _ProvisioningStatsError implements DashboardState {
  const _ProvisioningStatsError(this.message);
  

 final  String? message;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProvisioningStatsErrorCopyWith<_ProvisioningStatsError> get copyWith => __$ProvisioningStatsErrorCopyWithImpl<_ProvisioningStatsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProvisioningStatsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DashboardState.provisioningStatsError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ProvisioningStatsErrorCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$ProvisioningStatsErrorCopyWith(_ProvisioningStatsError value, $Res Function(_ProvisioningStatsError) _then) = __$ProvisioningStatsErrorCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$ProvisioningStatsErrorCopyWithImpl<$Res>
    implements _$ProvisioningStatsErrorCopyWith<$Res> {
  __$ProvisioningStatsErrorCopyWithImpl(this._self, this._then);

  final _ProvisioningStatsError _self;
  final $Res Function(_ProvisioningStatsError) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_ProvisioningStatsError(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ProvisioningStatsLoaded implements DashboardState {
  const _ProvisioningStatsLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProvisioningStatsLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState.provisioningStatsLoaded()';
}


}




// dart format on
