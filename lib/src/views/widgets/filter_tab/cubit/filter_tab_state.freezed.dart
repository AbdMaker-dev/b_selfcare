// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_tab_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FilterTabState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterTabState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FilterTabState()';
}


}

/// @nodoc
class $FilterTabStateCopyWith<$Res>  {
$FilterTabStateCopyWith(FilterTabState _, $Res Function(FilterTabState) __);
}


/// Adds pattern-matching-related methods to [FilterTabState].
extension FilterTabStatePatterns on FilterTabState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( ChangeLoading value)?  changeLoading,TResult Function( Change value)?  change,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ChangeLoading() when changeLoading != null:
return changeLoading(_that);case Change() when change != null:
return change(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( ChangeLoading value)  changeLoading,required TResult Function( Change value)  change,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case ChangeLoading():
return changeLoading(_that);case Change():
return change(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( ChangeLoading value)?  changeLoading,TResult? Function( Change value)?  change,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ChangeLoading() when changeLoading != null:
return changeLoading(_that);case Change() when change != null:
return change(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  changeLoading,TResult Function( int selectedIndex)?  change,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ChangeLoading() when changeLoading != null:
return changeLoading();case Change() when change != null:
return change(_that.selectedIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  changeLoading,required TResult Function( int selectedIndex)  change,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case ChangeLoading():
return changeLoading();case Change():
return change(_that.selectedIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  changeLoading,TResult? Function( int selectedIndex)?  change,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ChangeLoading() when changeLoading != null:
return changeLoading();case Change() when change != null:
return change(_that.selectedIndex);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements FilterTabState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FilterTabState.initial()';
}


}




/// @nodoc


class ChangeLoading implements FilterTabState {
  const ChangeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FilterTabState.changeLoading()';
}


}




/// @nodoc


class Change implements FilterTabState {
  const Change({required this.selectedIndex});
  

 final  int selectedIndex;

/// Create a copy of FilterTabState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeCopyWith<Change> get copyWith => _$ChangeCopyWithImpl<Change>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Change&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex));
}


@override
int get hashCode => Object.hash(runtimeType,selectedIndex);

@override
String toString() {
  return 'FilterTabState.change(selectedIndex: $selectedIndex)';
}


}

/// @nodoc
abstract mixin class $ChangeCopyWith<$Res> implements $FilterTabStateCopyWith<$Res> {
  factory $ChangeCopyWith(Change value, $Res Function(Change) _then) = _$ChangeCopyWithImpl;
@useResult
$Res call({
 int selectedIndex
});




}
/// @nodoc
class _$ChangeCopyWithImpl<$Res>
    implements $ChangeCopyWith<$Res> {
  _$ChangeCopyWithImpl(this._self, this._then);

  final Change _self;
  final $Res Function(Change) _then;

/// Create a copy of FilterTabState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedIndex = null,}) {
  return _then(Change(
selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
