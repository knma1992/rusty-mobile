// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frb_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FrbData {

 ui.Image? get image; ServiceState get serviceState; Float32List get audio; double get turns; WaveformStyle get waveformStyle;
/// Create a copy of FrbData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FrbDataCopyWith<FrbData> get copyWith => _$FrbDataCopyWithImpl<FrbData>(this as FrbData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FrbData&&(identical(other.image, image) || other.image == image)&&(identical(other.serviceState, serviceState) || other.serviceState == serviceState)&&const DeepCollectionEquality().equals(other.audio, audio)&&(identical(other.turns, turns) || other.turns == turns)&&(identical(other.waveformStyle, waveformStyle) || other.waveformStyle == waveformStyle));
}


@override
int get hashCode => Object.hash(runtimeType,image,serviceState,const DeepCollectionEquality().hash(audio),turns,waveformStyle);

@override
String toString() {
  return 'FrbData(image: $image, serviceState: $serviceState, audio: $audio, turns: $turns, waveformStyle: $waveformStyle)';
}


}

/// @nodoc
abstract mixin class $FrbDataCopyWith<$Res>  {
  factory $FrbDataCopyWith(FrbData value, $Res Function(FrbData) _then) = _$FrbDataCopyWithImpl;
@useResult
$Res call({
 ui.Image? image, ServiceState serviceState, Float32List audio, double turns, WaveformStyle waveformStyle
});




}
/// @nodoc
class _$FrbDataCopyWithImpl<$Res>
    implements $FrbDataCopyWith<$Res> {
  _$FrbDataCopyWithImpl(this._self, this._then);

  final FrbData _self;
  final $Res Function(FrbData) _then;

/// Create a copy of FrbData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? image = freezed,Object? serviceState = null,Object? audio = null,Object? turns = null,Object? waveformStyle = null,}) {
  return _then(_self.copyWith(
image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as ui.Image?,serviceState: null == serviceState ? _self.serviceState : serviceState // ignore: cast_nullable_to_non_nullable
as ServiceState,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as Float32List,turns: null == turns ? _self.turns : turns // ignore: cast_nullable_to_non_nullable
as double,waveformStyle: null == waveformStyle ? _self.waveformStyle : waveformStyle // ignore: cast_nullable_to_non_nullable
as WaveformStyle,
  ));
}

}


/// Adds pattern-matching-related methods to [FrbData].
extension FrbDataPatterns on FrbData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FrbData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FrbData() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FrbData value)  $default,){
final _that = this;
switch (_that) {
case _FrbData():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FrbData value)?  $default,){
final _that = this;
switch (_that) {
case _FrbData() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ui.Image? image,  ServiceState serviceState,  Float32List audio,  double turns,  WaveformStyle waveformStyle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FrbData() when $default != null:
return $default(_that.image,_that.serviceState,_that.audio,_that.turns,_that.waveformStyle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ui.Image? image,  ServiceState serviceState,  Float32List audio,  double turns,  WaveformStyle waveformStyle)  $default,) {final _that = this;
switch (_that) {
case _FrbData():
return $default(_that.image,_that.serviceState,_that.audio,_that.turns,_that.waveformStyle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ui.Image? image,  ServiceState serviceState,  Float32List audio,  double turns,  WaveformStyle waveformStyle)?  $default,) {final _that = this;
switch (_that) {
case _FrbData() when $default != null:
return $default(_that.image,_that.serviceState,_that.audio,_that.turns,_that.waveformStyle);case _:
  return null;

}
}

}

/// @nodoc


class _FrbData implements FrbData {
  const _FrbData({required this.image, required this.serviceState, required this.audio, required this.turns, required this.waveformStyle});
  

@override final  ui.Image? image;
@override final  ServiceState serviceState;
@override final  Float32List audio;
@override final  double turns;
@override final  WaveformStyle waveformStyle;

/// Create a copy of FrbData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FrbDataCopyWith<_FrbData> get copyWith => __$FrbDataCopyWithImpl<_FrbData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FrbData&&(identical(other.image, image) || other.image == image)&&(identical(other.serviceState, serviceState) || other.serviceState == serviceState)&&const DeepCollectionEquality().equals(other.audio, audio)&&(identical(other.turns, turns) || other.turns == turns)&&(identical(other.waveformStyle, waveformStyle) || other.waveformStyle == waveformStyle));
}


@override
int get hashCode => Object.hash(runtimeType,image,serviceState,const DeepCollectionEquality().hash(audio),turns,waveformStyle);

@override
String toString() {
  return 'FrbData(image: $image, serviceState: $serviceState, audio: $audio, turns: $turns, waveformStyle: $waveformStyle)';
}


}

/// @nodoc
abstract mixin class _$FrbDataCopyWith<$Res> implements $FrbDataCopyWith<$Res> {
  factory _$FrbDataCopyWith(_FrbData value, $Res Function(_FrbData) _then) = __$FrbDataCopyWithImpl;
@override @useResult
$Res call({
 ui.Image? image, ServiceState serviceState, Float32List audio, double turns, WaveformStyle waveformStyle
});




}
/// @nodoc
class __$FrbDataCopyWithImpl<$Res>
    implements _$FrbDataCopyWith<$Res> {
  __$FrbDataCopyWithImpl(this._self, this._then);

  final _FrbData _self;
  final $Res Function(_FrbData) _then;

/// Create a copy of FrbData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? image = freezed,Object? serviceState = null,Object? audio = null,Object? turns = null,Object? waveformStyle = null,}) {
  return _then(_FrbData(
image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as ui.Image?,serviceState: null == serviceState ? _self.serviceState : serviceState // ignore: cast_nullable_to_non_nullable
as ServiceState,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as Float32List,turns: null == turns ? _self.turns : turns // ignore: cast_nullable_to_non_nullable
as double,waveformStyle: null == waveformStyle ? _self.waveformStyle : waveformStyle // ignore: cast_nullable_to_non_nullable
as WaveformStyle,
  ));
}


}

// dart format on
