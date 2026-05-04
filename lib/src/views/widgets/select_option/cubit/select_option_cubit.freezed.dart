// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_option_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectState()';
}


}

/// @nodoc
class $SelectStateCopyWith<$Res>  {
$SelectStateCopyWith(SelectState _, $Res Function(SelectState) __);
}


/// Adds pattern-matching-related methods to [SelectState].
extension SelectStatePatterns on SelectState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SelectInitial value)?  initial,TResult Function( _SelectOpen value)?  open,TResult Function( _SelectChosen value)?  chosen,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectInitial() when initial != null:
return initial(_that);case _SelectOpen() when open != null:
return open(_that);case _SelectChosen() when chosen != null:
return chosen(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SelectInitial value)  initial,required TResult Function( _SelectOpen value)  open,required TResult Function( _SelectChosen value)  chosen,}){
final _that = this;
switch (_that) {
case _SelectInitial():
return initial(_that);case _SelectOpen():
return open(_that);case _SelectChosen():
return chosen(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SelectInitial value)?  initial,TResult? Function( _SelectOpen value)?  open,TResult? Function( _SelectChosen value)?  chosen,}){
final _that = this;
switch (_that) {
case _SelectInitial() when initial != null:
return initial(_that);case _SelectOpen() when open != null:
return open(_that);case _SelectChosen() when chosen != null:
return chosen(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( SelectOptionModel? selected)?  open,TResult Function( SelectOptionModel option)?  chosen,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectInitial() when initial != null:
return initial();case _SelectOpen() when open != null:
return open(_that.selected);case _SelectChosen() when chosen != null:
return chosen(_that.option);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( SelectOptionModel? selected)  open,required TResult Function( SelectOptionModel option)  chosen,}) {final _that = this;
switch (_that) {
case _SelectInitial():
return initial();case _SelectOpen():
return open(_that.selected);case _SelectChosen():
return chosen(_that.option);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( SelectOptionModel? selected)?  open,TResult? Function( SelectOptionModel option)?  chosen,}) {final _that = this;
switch (_that) {
case _SelectInitial() when initial != null:
return initial();case _SelectOpen() when open != null:
return open(_that.selected);case _SelectChosen() when chosen != null:
return chosen(_that.option);case _:
  return null;

}
}

}

/// @nodoc


class _SelectInitial implements SelectState {
  const _SelectInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectState.initial()';
}


}




/// @nodoc


class _SelectOpen implements SelectState {
  const _SelectOpen({this.selected});
  

 final  SelectOptionModel? selected;

/// Create a copy of SelectState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectOpenCopyWith<_SelectOpen> get copyWith => __$SelectOpenCopyWithImpl<_SelectOpen>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectOpen&&(identical(other.selected, selected) || other.selected == selected));
}


@override
int get hashCode => Object.hash(runtimeType,selected);

@override
String toString() {
  return 'SelectState.open(selected: $selected)';
}


}

/// @nodoc
abstract mixin class _$SelectOpenCopyWith<$Res> implements $SelectStateCopyWith<$Res> {
  factory _$SelectOpenCopyWith(_SelectOpen value, $Res Function(_SelectOpen) _then) = __$SelectOpenCopyWithImpl;
@useResult
$Res call({
 SelectOptionModel? selected
});




}
/// @nodoc
class __$SelectOpenCopyWithImpl<$Res>
    implements _$SelectOpenCopyWith<$Res> {
  __$SelectOpenCopyWithImpl(this._self, this._then);

  final _SelectOpen _self;
  final $Res Function(_SelectOpen) _then;

/// Create a copy of SelectState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selected = freezed,}) {
  return _then(_SelectOpen(
selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as SelectOptionModel?,
  ));
}


}

/// @nodoc


class _SelectChosen implements SelectState {
  const _SelectChosen({required this.option});
  

 final  SelectOptionModel option;

/// Create a copy of SelectState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectChosenCopyWith<_SelectChosen> get copyWith => __$SelectChosenCopyWithImpl<_SelectChosen>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectChosen&&(identical(other.option, option) || other.option == option));
}


@override
int get hashCode => Object.hash(runtimeType,option);

@override
String toString() {
  return 'SelectState.chosen(option: $option)';
}


}

/// @nodoc
abstract mixin class _$SelectChosenCopyWith<$Res> implements $SelectStateCopyWith<$Res> {
  factory _$SelectChosenCopyWith(_SelectChosen value, $Res Function(_SelectChosen) _then) = __$SelectChosenCopyWithImpl;
@useResult
$Res call({
 SelectOptionModel option
});




}
/// @nodoc
class __$SelectChosenCopyWithImpl<$Res>
    implements _$SelectChosenCopyWith<$Res> {
  __$SelectChosenCopyWithImpl(this._self, this._then);

  final _SelectChosen _self;
  final $Res Function(_SelectChosen) _then;

/// Create a copy of SelectState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? option = null,}) {
  return _then(_SelectChosen(
option: null == option ? _self.option : option // ignore: cast_nullable_to_non_nullable
as SelectOptionModel,
  ));
}


}

// dart format on
