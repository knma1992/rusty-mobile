// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simple.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorldEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorldEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WorldEvent()';
}


}

/// @nodoc
class $WorldEventCopyWith<$Res>  {
$WorldEventCopyWith(WorldEvent _, $Res Function(WorldEvent) __);
}


/// Adds pattern-matching-related methods to [WorldEvent].
extension WorldEventPatterns on WorldEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WorldEvent_TerrainGenerated value)?  terrainGenerated,TResult Function( WorldEvent_WeatherChanged value)?  weatherChanged,TResult Function( WorldEvent_RegionEntered value)?  regionEntered,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WorldEvent_TerrainGenerated() when terrainGenerated != null:
return terrainGenerated(_that);case WorldEvent_WeatherChanged() when weatherChanged != null:
return weatherChanged(_that);case WorldEvent_RegionEntered() when regionEntered != null:
return regionEntered(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WorldEvent_TerrainGenerated value)  terrainGenerated,required TResult Function( WorldEvent_WeatherChanged value)  weatherChanged,required TResult Function( WorldEvent_RegionEntered value)  regionEntered,}){
final _that = this;
switch (_that) {
case WorldEvent_TerrainGenerated():
return terrainGenerated(_that);case WorldEvent_WeatherChanged():
return weatherChanged(_that);case WorldEvent_RegionEntered():
return regionEntered(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WorldEvent_TerrainGenerated value)?  terrainGenerated,TResult? Function( WorldEvent_WeatherChanged value)?  weatherChanged,TResult? Function( WorldEvent_RegionEntered value)?  regionEntered,}){
final _that = this;
switch (_that) {
case WorldEvent_TerrainGenerated() when terrainGenerated != null:
return terrainGenerated(_that);case WorldEvent_WeatherChanged() when weatherChanged != null:
return weatherChanged(_that);case WorldEvent_RegionEntered() when regionEntered != null:
return regionEntered(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int x,  int y,  int width,  int height,  BigInt seed)?  terrainGenerated,TResult Function( double temperature,  double humidity,  double windSpeed,  String description)?  weatherChanged,TResult Function( String regionName,  int population,  bool hostile)?  regionEntered,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WorldEvent_TerrainGenerated() when terrainGenerated != null:
return terrainGenerated(_that.x,_that.y,_that.width,_that.height,_that.seed);case WorldEvent_WeatherChanged() when weatherChanged != null:
return weatherChanged(_that.temperature,_that.humidity,_that.windSpeed,_that.description);case WorldEvent_RegionEntered() when regionEntered != null:
return regionEntered(_that.regionName,_that.population,_that.hostile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int x,  int y,  int width,  int height,  BigInt seed)  terrainGenerated,required TResult Function( double temperature,  double humidity,  double windSpeed,  String description)  weatherChanged,required TResult Function( String regionName,  int population,  bool hostile)  regionEntered,}) {final _that = this;
switch (_that) {
case WorldEvent_TerrainGenerated():
return terrainGenerated(_that.x,_that.y,_that.width,_that.height,_that.seed);case WorldEvent_WeatherChanged():
return weatherChanged(_that.temperature,_that.humidity,_that.windSpeed,_that.description);case WorldEvent_RegionEntered():
return regionEntered(_that.regionName,_that.population,_that.hostile);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int x,  int y,  int width,  int height,  BigInt seed)?  terrainGenerated,TResult? Function( double temperature,  double humidity,  double windSpeed,  String description)?  weatherChanged,TResult? Function( String regionName,  int population,  bool hostile)?  regionEntered,}) {final _that = this;
switch (_that) {
case WorldEvent_TerrainGenerated() when terrainGenerated != null:
return terrainGenerated(_that.x,_that.y,_that.width,_that.height,_that.seed);case WorldEvent_WeatherChanged() when weatherChanged != null:
return weatherChanged(_that.temperature,_that.humidity,_that.windSpeed,_that.description);case WorldEvent_RegionEntered() when regionEntered != null:
return regionEntered(_that.regionName,_that.population,_that.hostile);case _:
  return null;

}
}

}

/// @nodoc


class WorldEvent_TerrainGenerated extends WorldEvent {
  const WorldEvent_TerrainGenerated({required this.x, required this.y, required this.width, required this.height, required this.seed}): super._();
  

 final  int x;
 final  int y;
 final  int width;
 final  int height;
 final  BigInt seed;

/// Create a copy of WorldEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorldEvent_TerrainGeneratedCopyWith<WorldEvent_TerrainGenerated> get copyWith => _$WorldEvent_TerrainGeneratedCopyWithImpl<WorldEvent_TerrainGenerated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorldEvent_TerrainGenerated&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.seed, seed) || other.seed == seed));
}


@override
int get hashCode => Object.hash(runtimeType,x,y,width,height,seed);

@override
String toString() {
  return 'WorldEvent.terrainGenerated(x: $x, y: $y, width: $width, height: $height, seed: $seed)';
}


}

/// @nodoc
abstract mixin class $WorldEvent_TerrainGeneratedCopyWith<$Res> implements $WorldEventCopyWith<$Res> {
  factory $WorldEvent_TerrainGeneratedCopyWith(WorldEvent_TerrainGenerated value, $Res Function(WorldEvent_TerrainGenerated) _then) = _$WorldEvent_TerrainGeneratedCopyWithImpl;
@useResult
$Res call({
 int x, int y, int width, int height, BigInt seed
});




}
/// @nodoc
class _$WorldEvent_TerrainGeneratedCopyWithImpl<$Res>
    implements $WorldEvent_TerrainGeneratedCopyWith<$Res> {
  _$WorldEvent_TerrainGeneratedCopyWithImpl(this._self, this._then);

  final WorldEvent_TerrainGenerated _self;
  final $Res Function(WorldEvent_TerrainGenerated) _then;

/// Create a copy of WorldEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,Object? width = null,Object? height = null,Object? seed = null,}) {
  return _then(WorldEvent_TerrainGenerated(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as int,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,seed: null == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as BigInt,
  ));
}


}

/// @nodoc


class WorldEvent_WeatherChanged extends WorldEvent {
  const WorldEvent_WeatherChanged({required this.temperature, required this.humidity, required this.windSpeed, required this.description}): super._();
  

 final  double temperature;
 final  double humidity;
 final  double windSpeed;
 final  String description;

/// Create a copy of WorldEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorldEvent_WeatherChangedCopyWith<WorldEvent_WeatherChanged> get copyWith => _$WorldEvent_WeatherChangedCopyWithImpl<WorldEvent_WeatherChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorldEvent_WeatherChanged&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,temperature,humidity,windSpeed,description);

@override
String toString() {
  return 'WorldEvent.weatherChanged(temperature: $temperature, humidity: $humidity, windSpeed: $windSpeed, description: $description)';
}


}

/// @nodoc
abstract mixin class $WorldEvent_WeatherChangedCopyWith<$Res> implements $WorldEventCopyWith<$Res> {
  factory $WorldEvent_WeatherChangedCopyWith(WorldEvent_WeatherChanged value, $Res Function(WorldEvent_WeatherChanged) _then) = _$WorldEvent_WeatherChangedCopyWithImpl;
@useResult
$Res call({
 double temperature, double humidity, double windSpeed, String description
});




}
/// @nodoc
class _$WorldEvent_WeatherChangedCopyWithImpl<$Res>
    implements $WorldEvent_WeatherChangedCopyWith<$Res> {
  _$WorldEvent_WeatherChangedCopyWithImpl(this._self, this._then);

  final WorldEvent_WeatherChanged _self;
  final $Res Function(WorldEvent_WeatherChanged) _then;

/// Create a copy of WorldEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? temperature = null,Object? humidity = null,Object? windSpeed = null,Object? description = null,}) {
  return _then(WorldEvent_WeatherChanged(
temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double,windSpeed: null == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class WorldEvent_RegionEntered extends WorldEvent {
  const WorldEvent_RegionEntered({required this.regionName, required this.population, required this.hostile}): super._();
  

 final  String regionName;
 final  int population;
 final  bool hostile;

/// Create a copy of WorldEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorldEvent_RegionEnteredCopyWith<WorldEvent_RegionEntered> get copyWith => _$WorldEvent_RegionEnteredCopyWithImpl<WorldEvent_RegionEntered>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorldEvent_RegionEntered&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.population, population) || other.population == population)&&(identical(other.hostile, hostile) || other.hostile == hostile));
}


@override
int get hashCode => Object.hash(runtimeType,regionName,population,hostile);

@override
String toString() {
  return 'WorldEvent.regionEntered(regionName: $regionName, population: $population, hostile: $hostile)';
}


}

/// @nodoc
abstract mixin class $WorldEvent_RegionEnteredCopyWith<$Res> implements $WorldEventCopyWith<$Res> {
  factory $WorldEvent_RegionEnteredCopyWith(WorldEvent_RegionEntered value, $Res Function(WorldEvent_RegionEntered) _then) = _$WorldEvent_RegionEnteredCopyWithImpl;
@useResult
$Res call({
 String regionName, int population, bool hostile
});




}
/// @nodoc
class _$WorldEvent_RegionEnteredCopyWithImpl<$Res>
    implements $WorldEvent_RegionEnteredCopyWith<$Res> {
  _$WorldEvent_RegionEnteredCopyWithImpl(this._self, this._then);

  final WorldEvent_RegionEntered _self;
  final $Res Function(WorldEvent_RegionEntered) _then;

/// Create a copy of WorldEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? regionName = null,Object? population = null,Object? hostile = null,}) {
  return _then(WorldEvent_RegionEntered(
regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,population: null == population ? _self.population : population // ignore: cast_nullable_to_non_nullable
as int,hostile: null == hostile ? _self.hostile : hostile // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
