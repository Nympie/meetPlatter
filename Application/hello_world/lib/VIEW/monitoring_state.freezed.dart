// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'monitoring_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MonitoringState _$MonitoringStateFromJson(Map<String, dynamic> json) {
  return _MonitoringState.fromJson(json);
}

/// @nodoc
mixin _$MonitoringState {
  List<Sensordata> get data => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MonitoringStateCopyWith<MonitoringState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonitoringStateCopyWith<$Res> {
  factory $MonitoringStateCopyWith(
          MonitoringState value, $Res Function(MonitoringState) then) =
      _$MonitoringStateCopyWithImpl<$Res>;
  $Res call({List<Sensordata> data, bool isLoading});
}

/// @nodoc
class _$MonitoringStateCopyWithImpl<$Res>
    implements $MonitoringStateCopyWith<$Res> {
  _$MonitoringStateCopyWithImpl(this._value, this._then);

  final MonitoringState _value;
  // ignore: unused_field
  final $Res Function(MonitoringState) _then;

  @override
  $Res call({
    Object? data = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Sensordata>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_MonitoringStateCopyWith<$Res>
    implements $MonitoringStateCopyWith<$Res> {
  factory _$$_MonitoringStateCopyWith(
          _$_MonitoringState value, $Res Function(_$_MonitoringState) then) =
      __$$_MonitoringStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Sensordata> data, bool isLoading});
}

/// @nodoc
class __$$_MonitoringStateCopyWithImpl<$Res>
    extends _$MonitoringStateCopyWithImpl<$Res>
    implements _$$_MonitoringStateCopyWith<$Res> {
  __$$_MonitoringStateCopyWithImpl(
      _$_MonitoringState _value, $Res Function(_$_MonitoringState) _then)
      : super(_value, (v) => _then(v as _$_MonitoringState));

  @override
  _$_MonitoringState get _value => super._value as _$_MonitoringState;

  @override
  $Res call({
    Object? data = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_$_MonitoringState(
      data: data == freezed
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Sensordata>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MonitoringState implements _MonitoringState {
  _$_MonitoringState(
      {final List<Sensordata> data = const [], this.isLoading = false})
      : _data = data;

  factory _$_MonitoringState.fromJson(Map<String, dynamic> json) =>
      _$$_MonitoringStateFromJson(json);

  final List<Sensordata> _data;
  @override
  @JsonKey()
  List<Sensordata> get data {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'MonitoringState(data: $data, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MonitoringState &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  _$$_MonitoringStateCopyWith<_$_MonitoringState> get copyWith =>
      __$$_MonitoringStateCopyWithImpl<_$_MonitoringState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MonitoringStateToJson(
      this,
    );
  }
}

abstract class _MonitoringState implements MonitoringState {
  factory _MonitoringState(
      {final List<Sensordata> data, final bool isLoading}) = _$_MonitoringState;

  factory _MonitoringState.fromJson(Map<String, dynamic> json) =
      _$_MonitoringState.fromJson;

  @override
  List<Sensordata> get data;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_MonitoringStateCopyWith<_$_MonitoringState> get copyWith =>
      throw _privateConstructorUsedError;
}
