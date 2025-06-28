// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debug_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DebugEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() toggleDebugMode,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? toggleDebugMode,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? toggleDebugMode,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ToggleDebugMode value) toggleDebugMode,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggleDebugMode value)? toggleDebugMode,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggleDebugMode value)? toggleDebugMode,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebugEventCopyWith<$Res> {
  factory $DebugEventCopyWith(
    DebugEvent value,
    $Res Function(DebugEvent) then,
  ) = _$DebugEventCopyWithImpl<$Res, DebugEvent>;
}

/// @nodoc
class _$DebugEventCopyWithImpl<$Res, $Val extends DebugEvent>
    implements $DebugEventCopyWith<$Res> {
  _$DebugEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DebugEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ToggleDebugModeImplCopyWith<$Res> {
  factory _$$ToggleDebugModeImplCopyWith(
    _$ToggleDebugModeImpl value,
    $Res Function(_$ToggleDebugModeImpl) then,
  ) = __$$ToggleDebugModeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleDebugModeImplCopyWithImpl<$Res>
    extends _$DebugEventCopyWithImpl<$Res, _$ToggleDebugModeImpl>
    implements _$$ToggleDebugModeImplCopyWith<$Res> {
  __$$ToggleDebugModeImplCopyWithImpl(
    _$ToggleDebugModeImpl _value,
    $Res Function(_$ToggleDebugModeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebugEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ToggleDebugModeImpl implements _ToggleDebugMode {
  const _$ToggleDebugModeImpl();

  @override
  String toString() {
    return 'DebugEvent.toggleDebugMode()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleDebugModeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() toggleDebugMode,
  }) {
    return toggleDebugMode();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? toggleDebugMode,
  }) {
    return toggleDebugMode?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? toggleDebugMode,
    required TResult orElse(),
  }) {
    if (toggleDebugMode != null) {
      return toggleDebugMode();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ToggleDebugMode value) toggleDebugMode,
  }) {
    return toggleDebugMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggleDebugMode value)? toggleDebugMode,
  }) {
    return toggleDebugMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggleDebugMode value)? toggleDebugMode,
    required TResult orElse(),
  }) {
    if (toggleDebugMode != null) {
      return toggleDebugMode(this);
    }
    return orElse();
  }
}

abstract class _ToggleDebugMode implements DebugEvent {
  const factory _ToggleDebugMode() = _$ToggleDebugModeImpl;
}

/// @nodoc
mixin _$DebugState {
  bool get isDebugModeEnabled => throw _privateConstructorUsedError;

  /// Create a copy of DebugState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DebugStateCopyWith<DebugState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebugStateCopyWith<$Res> {
  factory $DebugStateCopyWith(
    DebugState value,
    $Res Function(DebugState) then,
  ) = _$DebugStateCopyWithImpl<$Res, DebugState>;
  @useResult
  $Res call({bool isDebugModeEnabled});
}

/// @nodoc
class _$DebugStateCopyWithImpl<$Res, $Val extends DebugState>
    implements $DebugStateCopyWith<$Res> {
  _$DebugStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DebugState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isDebugModeEnabled = null}) {
    return _then(
      _value.copyWith(
            isDebugModeEnabled: null == isDebugModeEnabled
                ? _value.isDebugModeEnabled
                : isDebugModeEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DebugStateImplCopyWith<$Res>
    implements $DebugStateCopyWith<$Res> {
  factory _$$DebugStateImplCopyWith(
    _$DebugStateImpl value,
    $Res Function(_$DebugStateImpl) then,
  ) = __$$DebugStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isDebugModeEnabled});
}

/// @nodoc
class __$$DebugStateImplCopyWithImpl<$Res>
    extends _$DebugStateCopyWithImpl<$Res, _$DebugStateImpl>
    implements _$$DebugStateImplCopyWith<$Res> {
  __$$DebugStateImplCopyWithImpl(
    _$DebugStateImpl _value,
    $Res Function(_$DebugStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebugState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isDebugModeEnabled = null}) {
    return _then(
      _$DebugStateImpl(
        isDebugModeEnabled: null == isDebugModeEnabled
            ? _value.isDebugModeEnabled
            : isDebugModeEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$DebugStateImpl implements _DebugState {
  const _$DebugStateImpl({this.isDebugModeEnabled = false});

  @override
  @JsonKey()
  final bool isDebugModeEnabled;

  @override
  String toString() {
    return 'DebugState(isDebugModeEnabled: $isDebugModeEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DebugStateImpl &&
            (identical(other.isDebugModeEnabled, isDebugModeEnabled) ||
                other.isDebugModeEnabled == isDebugModeEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isDebugModeEnabled);

  /// Create a copy of DebugState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DebugStateImplCopyWith<_$DebugStateImpl> get copyWith =>
      __$$DebugStateImplCopyWithImpl<_$DebugStateImpl>(this, _$identity);
}

abstract class _DebugState implements DebugState {
  const factory _DebugState({final bool isDebugModeEnabled}) = _$DebugStateImpl;

  @override
  bool get isDebugModeEnabled;

  /// Create a copy of DebugState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DebugStateImplCopyWith<_$DebugStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
