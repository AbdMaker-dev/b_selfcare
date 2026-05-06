// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsState()';
}


}

/// @nodoc
class $ProductsStateCopyWith<$Res>  {
$ProductsStateCopyWith(ProductsState _, $Res Function(ProductsState) __);
}


/// Adds pattern-matching-related methods to [ProductsState].
extension ProductsStatePatterns on ProductsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _ProductsLoading value)?  productsLoading,TResult Function( _ProductsError value)?  productsError,TResult Function( ProductsLoaded value)?  productsLoaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _ProductsLoading() when productsLoading != null:
return productsLoading(_that);case _ProductsError() when productsError != null:
return productsError(_that);case ProductsLoaded() when productsLoaded != null:
return productsLoaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _ProductsLoading value)  productsLoading,required TResult Function( _ProductsError value)  productsError,required TResult Function( ProductsLoaded value)  productsLoaded,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _ProductsLoading():
return productsLoading(_that);case _ProductsError():
return productsError(_that);case ProductsLoaded():
return productsLoaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _ProductsLoading value)?  productsLoading,TResult? Function( _ProductsError value)?  productsError,TResult? Function( ProductsLoaded value)?  productsLoaded,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _ProductsLoading() when productsLoading != null:
return productsLoading(_that);case _ProductsError() when productsError != null:
return productsError(_that);case ProductsLoaded() when productsLoaded != null:
return productsLoaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  productsLoading,TResult Function( String? message)?  productsError,TResult Function()?  productsLoaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _ProductsLoading() when productsLoading != null:
return productsLoading();case _ProductsError() when productsError != null:
return productsError(_that.message);case ProductsLoaded() when productsLoaded != null:
return productsLoaded();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  productsLoading,required TResult Function( String? message)  productsError,required TResult Function()  productsLoaded,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _ProductsLoading():
return productsLoading();case _ProductsError():
return productsError(_that.message);case ProductsLoaded():
return productsLoaded();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  productsLoading,TResult? Function( String? message)?  productsError,TResult? Function()?  productsLoaded,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _ProductsLoading() when productsLoading != null:
return productsLoading();case _ProductsError() when productsError != null:
return productsError(_that.message);case ProductsLoaded() when productsLoaded != null:
return productsLoaded();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ProductsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsState.initial()';
}


}




/// @nodoc


class _ProductsLoading implements ProductsState {
  const _ProductsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsState.productsLoading()';
}


}




/// @nodoc


class _ProductsError implements ProductsState {
  const _ProductsError(this.message);
  

 final  String? message;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductsErrorCopyWith<_ProductsError> get copyWith => __$ProductsErrorCopyWithImpl<_ProductsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProductsState.productsError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ProductsErrorCopyWith<$Res> implements $ProductsStateCopyWith<$Res> {
  factory _$ProductsErrorCopyWith(_ProductsError value, $Res Function(_ProductsError) _then) = __$ProductsErrorCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$ProductsErrorCopyWithImpl<$Res>
    implements _$ProductsErrorCopyWith<$Res> {
  __$ProductsErrorCopyWithImpl(this._self, this._then);

  final _ProductsError _self;
  final $Res Function(_ProductsError) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_ProductsError(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ProductsLoaded implements ProductsState {
  const ProductsLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsState.productsLoaded()';
}


}




// dart format on
