// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sensor_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Sensordata _$SensordataFromJson(Map<String, dynamic> json) {
  return _Sensordata.fromJson(json);
}

/// @nodoc
mixin _$Sensordata {
  int get Temperature => throw _privateConstructorUsedError;
  int get Humidity => throw _privateConstructorUsedError;
  String get Time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SensordataCopyWith<Sensordata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SensordataCopyWith<$Res> {
  factory $SensordataCopyWith(
          Sensordata value, $Res Function(Sensordata) then) =
      _$SensordataCopyWithImpl<$Res>;
  $Res call({int Temperature, int Humidity, String Time});
}

/// @nodoc
class _$SensordataCopyWithImpl<$Res> implements $SensordataCopyWith<$Res> {
  _$SensordataCopyWithImpl(this._value, this._then);

  final Sensordata _value;
  // ignore: unused_field
  final $Res Function(Sensordata) _then;

  @override
  $Res call({
    Object? Temperature = freezed,
    Object? Humidity = freezed,
    Object? Time = freezed,
  }) {
    return _then(_value.copyWith(
      Temperature: Temperature == freezed
          ? _value.Temperature
          : Temperature // ignore: cast_nullable_to_non_nullable
              as int,
      Humidity: Humidity == freezed
          ? _value.Humidity
          : Humidity // ignore: cast_nullable_to_non_nullable
              as int,
      Time: Time == freezed
          ? _value.Time
          : Time // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_SensordataCopyWith<$Res>
    implements $SensordataCopyWith<$Res> {
  factory _$$_SensordataCopyWith(
          _$_Sensordata value, $Res Function(_$_Sensordata) then) =
      __$$_SensordataCopyWithImpl<$Res>;
  @override
  $Res call({int Temperature, int Humidity, String Time});
}

/// @nodoc
class __$$_SensordataCopyWithImpl<$Res> extends _$SensordataCopyWithImpl<$Res>
    implements _$$_SensordataCopyWith<$Res> {
  __$$_SensordataCopyWithImpl(
      _$_Sensordata _value, $Res Function(_$_Sensordata) _then)
      : super(_value, (v) => _then(v as _$_Sensordata));

  @override
  _$_Sensordata get _value => super._value as _$_Sensordata;

  @override
  $Res call({
    Object? Temperature = freezed,
    Object? Humidity = freezed,
    Object? Time = freezed,
  }) {
    return _then(_$_Sensordata(
      Temperature: Temperature == freezed
          ? _value.Temperature
          : Temperature // ignore: cast_nullable_to_non_nullable
              as int,
      Humidity: Humidity == freezed
          ? _value.Humidity
          : Humidity // ignore: cast_nullable_to_non_nullable
              as int,
      Time: Time == freezed
          ? _value.Time
          : Time // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Sensordata implements _Sensordata {
  _$_Sensordata(
      {required this.Temperature, required this.Humidity, required this.Time});

  factory _$_Sensordata.fromJson(Map<String, dynamic> json) =>
      _$$_SensordataFromJson(json);

  @override
  final int Temperature;
  @override
  final int Humidity;
  @override
  final String Time;

  @override
  String toString() {
    return 'Sensordata(Temperature: $Temperature, Humidity: $Humidity, Time: $Time)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Sensordata &&
            const DeepCollectionEquality()
                .equals(other.Temperature, Temperature) &&
            const DeepCollectionEquality().equals(other.Humidity, Humidity) &&
            const DeepCollectionEquality().equals(other.Time, Time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(Temperature),
      const DeepCollectionEquality().hash(Humidity),
      const DeepCollectionEquality().hash(Time));

  @JsonKey(ignore: true)
  @override
  _$$_SensordataCopyWith<_$_Sensordata> get copyWith =>
      __$$_SensordataCopyWithImpl<_$_Sensordata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SensordataToJson(
      this,
    );
  }
}

abstract class _Sensordata implements Sensordata {
  factory _Sensordata(
      {required final int Temperature,
      required final int Humidity,
      required final String Time}) = _$_Sensordata;

  factory _Sensordata.fromJson(Map<String, dynamic> json) =
      _$_Sensordata.fromJson;

  @override
  int get Temperature;
  @override
  int get Humidity;
  @override
  String get Time;
  @override
  @JsonKey(ignore: true)
  _$$_SensordataCopyWith<_$_Sensordata> get copyWith =>
      throw _privateConstructorUsedError;
}
