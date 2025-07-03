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
    required TResult Function() pickLocationToggled,
    required TResult Function(int spotId, String userId) checkInRequested,
    required TResult Function(int spotId, String userId) checkOutRequested,
    required TResult Function(String message) logMessage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? toggleDebugMode,
    TResult? Function()? pickLocationToggled,
    TResult? Function(int spotId, String userId)? checkInRequested,
    TResult? Function(int spotId, String userId)? checkOutRequested,
    TResult? Function(String message)? logMessage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? toggleDebugMode,
    TResult Function()? pickLocationToggled,
    TResult Function(int spotId, String userId)? checkInRequested,
    TResult Function(int spotId, String userId)? checkOutRequested,
    TResult Function(String message)? logMessage,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ToggleDebugMode value) toggleDebugMode,
    required TResult Function(_PickLocationToggled value) pickLocationToggled,
    required TResult Function(_CheckInRequested value) checkInRequested,
    required TResult Function(_CheckOutRequested value) checkOutRequested,
    required TResult Function(_LogMessage value) logMessage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(_PickLocationToggled value)? pickLocationToggled,
    TResult? Function(_CheckInRequested value)? checkInRequested,
    TResult? Function(_CheckOutRequested value)? checkOutRequested,
    TResult? Function(_LogMessage value)? logMessage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggleDebugMode value)? toggleDebugMode,
    TResult Function(_PickLocationToggled value)? pickLocationToggled,
    TResult Function(_CheckInRequested value)? checkInRequested,
    TResult Function(_CheckOutRequested value)? checkOutRequested,
    TResult Function(_LogMessage value)? logMessage,
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
    required TResult Function() pickLocationToggled,
    required TResult Function(int spotId, String userId) checkInRequested,
    required TResult Function(int spotId, String userId) checkOutRequested,
    required TResult Function(String message) logMessage,
  }) {
    return toggleDebugMode();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? toggleDebugMode,
    TResult? Function()? pickLocationToggled,
    TResult? Function(int spotId, String userId)? checkInRequested,
    TResult? Function(int spotId, String userId)? checkOutRequested,
    TResult? Function(String message)? logMessage,
  }) {
    return toggleDebugMode?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? toggleDebugMode,
    TResult Function()? pickLocationToggled,
    TResult Function(int spotId, String userId)? checkInRequested,
    TResult Function(int spotId, String userId)? checkOutRequested,
    TResult Function(String message)? logMessage,
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
    required TResult Function(_PickLocationToggled value) pickLocationToggled,
    required TResult Function(_CheckInRequested value) checkInRequested,
    required TResult Function(_CheckOutRequested value) checkOutRequested,
    required TResult Function(_LogMessage value) logMessage,
  }) {
    return toggleDebugMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(_PickLocationToggled value)? pickLocationToggled,
    TResult? Function(_CheckInRequested value)? checkInRequested,
    TResult? Function(_CheckOutRequested value)? checkOutRequested,
    TResult? Function(_LogMessage value)? logMessage,
  }) {
    return toggleDebugMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggleDebugMode value)? toggleDebugMode,
    TResult Function(_PickLocationToggled value)? pickLocationToggled,
    TResult Function(_CheckInRequested value)? checkInRequested,
    TResult Function(_CheckOutRequested value)? checkOutRequested,
    TResult Function(_LogMessage value)? logMessage,
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
abstract class _$$PickLocationToggledImplCopyWith<$Res> {
  factory _$$PickLocationToggledImplCopyWith(
    _$PickLocationToggledImpl value,
    $Res Function(_$PickLocationToggledImpl) then,
  ) = __$$PickLocationToggledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PickLocationToggledImplCopyWithImpl<$Res>
    extends _$DebugEventCopyWithImpl<$Res, _$PickLocationToggledImpl>
    implements _$$PickLocationToggledImplCopyWith<$Res> {
  __$$PickLocationToggledImplCopyWithImpl(
    _$PickLocationToggledImpl _value,
    $Res Function(_$PickLocationToggledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebugEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PickLocationToggledImpl implements _PickLocationToggled {
  const _$PickLocationToggledImpl();

  @override
  String toString() {
    return 'DebugEvent.pickLocationToggled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickLocationToggledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() toggleDebugMode,
    required TResult Function() pickLocationToggled,
    required TResult Function(int spotId, String userId) checkInRequested,
    required TResult Function(int spotId, String userId) checkOutRequested,
    required TResult Function(String message) logMessage,
  }) {
    return pickLocationToggled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? toggleDebugMode,
    TResult? Function()? pickLocationToggled,
    TResult? Function(int spotId, String userId)? checkInRequested,
    TResult? Function(int spotId, String userId)? checkOutRequested,
    TResult? Function(String message)? logMessage,
  }) {
    return pickLocationToggled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? toggleDebugMode,
    TResult Function()? pickLocationToggled,
    TResult Function(int spotId, String userId)? checkInRequested,
    TResult Function(int spotId, String userId)? checkOutRequested,
    TResult Function(String message)? logMessage,
    required TResult orElse(),
  }) {
    if (pickLocationToggled != null) {
      return pickLocationToggled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ToggleDebugMode value) toggleDebugMode,
    required TResult Function(_PickLocationToggled value) pickLocationToggled,
    required TResult Function(_CheckInRequested value) checkInRequested,
    required TResult Function(_CheckOutRequested value) checkOutRequested,
    required TResult Function(_LogMessage value) logMessage,
  }) {
    return pickLocationToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(_PickLocationToggled value)? pickLocationToggled,
    TResult? Function(_CheckInRequested value)? checkInRequested,
    TResult? Function(_CheckOutRequested value)? checkOutRequested,
    TResult? Function(_LogMessage value)? logMessage,
  }) {
    return pickLocationToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggleDebugMode value)? toggleDebugMode,
    TResult Function(_PickLocationToggled value)? pickLocationToggled,
    TResult Function(_CheckInRequested value)? checkInRequested,
    TResult Function(_CheckOutRequested value)? checkOutRequested,
    TResult Function(_LogMessage value)? logMessage,
    required TResult orElse(),
  }) {
    if (pickLocationToggled != null) {
      return pickLocationToggled(this);
    }
    return orElse();
  }
}

abstract class _PickLocationToggled implements DebugEvent {
  const factory _PickLocationToggled() = _$PickLocationToggledImpl;
}

/// @nodoc
abstract class _$$CheckInRequestedImplCopyWith<$Res> {
  factory _$$CheckInRequestedImplCopyWith(
    _$CheckInRequestedImpl value,
    $Res Function(_$CheckInRequestedImpl) then,
  ) = __$$CheckInRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int spotId, String userId});
}

/// @nodoc
class __$$CheckInRequestedImplCopyWithImpl<$Res>
    extends _$DebugEventCopyWithImpl<$Res, _$CheckInRequestedImpl>
    implements _$$CheckInRequestedImplCopyWith<$Res> {
  __$$CheckInRequestedImplCopyWithImpl(
    _$CheckInRequestedImpl _value,
    $Res Function(_$CheckInRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebugEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? spotId = null, Object? userId = null}) {
    return _then(
      _$CheckInRequestedImpl(
        spotId: null == spotId
            ? _value.spotId
            : spotId // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CheckInRequestedImpl implements _CheckInRequested {
  const _$CheckInRequestedImpl({required this.spotId, required this.userId});

  @override
  final int spotId;
  @override
  final String userId;

  @override
  String toString() {
    return 'DebugEvent.checkInRequested(spotId: $spotId, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInRequestedImpl &&
            (identical(other.spotId, spotId) || other.spotId == spotId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, spotId, userId);

  /// Create a copy of DebugEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInRequestedImplCopyWith<_$CheckInRequestedImpl> get copyWith =>
      __$$CheckInRequestedImplCopyWithImpl<_$CheckInRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() toggleDebugMode,
    required TResult Function() pickLocationToggled,
    required TResult Function(int spotId, String userId) checkInRequested,
    required TResult Function(int spotId, String userId) checkOutRequested,
    required TResult Function(String message) logMessage,
  }) {
    return checkInRequested(spotId, userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? toggleDebugMode,
    TResult? Function()? pickLocationToggled,
    TResult? Function(int spotId, String userId)? checkInRequested,
    TResult? Function(int spotId, String userId)? checkOutRequested,
    TResult? Function(String message)? logMessage,
  }) {
    return checkInRequested?.call(spotId, userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? toggleDebugMode,
    TResult Function()? pickLocationToggled,
    TResult Function(int spotId, String userId)? checkInRequested,
    TResult Function(int spotId, String userId)? checkOutRequested,
    TResult Function(String message)? logMessage,
    required TResult orElse(),
  }) {
    if (checkInRequested != null) {
      return checkInRequested(spotId, userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ToggleDebugMode value) toggleDebugMode,
    required TResult Function(_PickLocationToggled value) pickLocationToggled,
    required TResult Function(_CheckInRequested value) checkInRequested,
    required TResult Function(_CheckOutRequested value) checkOutRequested,
    required TResult Function(_LogMessage value) logMessage,
  }) {
    return checkInRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(_PickLocationToggled value)? pickLocationToggled,
    TResult? Function(_CheckInRequested value)? checkInRequested,
    TResult? Function(_CheckOutRequested value)? checkOutRequested,
    TResult? Function(_LogMessage value)? logMessage,
  }) {
    return checkInRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggleDebugMode value)? toggleDebugMode,
    TResult Function(_PickLocationToggled value)? pickLocationToggled,
    TResult Function(_CheckInRequested value)? checkInRequested,
    TResult Function(_CheckOutRequested value)? checkOutRequested,
    TResult Function(_LogMessage value)? logMessage,
    required TResult orElse(),
  }) {
    if (checkInRequested != null) {
      return checkInRequested(this);
    }
    return orElse();
  }
}

abstract class _CheckInRequested implements DebugEvent {
  const factory _CheckInRequested({
    required final int spotId,
    required final String userId,
  }) = _$CheckInRequestedImpl;

  int get spotId;
  String get userId;

  /// Create a copy of DebugEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInRequestedImplCopyWith<_$CheckInRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckOutRequestedImplCopyWith<$Res> {
  factory _$$CheckOutRequestedImplCopyWith(
    _$CheckOutRequestedImpl value,
    $Res Function(_$CheckOutRequestedImpl) then,
  ) = __$$CheckOutRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int spotId, String userId});
}

/// @nodoc
class __$$CheckOutRequestedImplCopyWithImpl<$Res>
    extends _$DebugEventCopyWithImpl<$Res, _$CheckOutRequestedImpl>
    implements _$$CheckOutRequestedImplCopyWith<$Res> {
  __$$CheckOutRequestedImplCopyWithImpl(
    _$CheckOutRequestedImpl _value,
    $Res Function(_$CheckOutRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebugEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? spotId = null, Object? userId = null}) {
    return _then(
      _$CheckOutRequestedImpl(
        spotId: null == spotId
            ? _value.spotId
            : spotId // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CheckOutRequestedImpl implements _CheckOutRequested {
  const _$CheckOutRequestedImpl({required this.spotId, required this.userId});

  @override
  final int spotId;
  @override
  final String userId;

  @override
  String toString() {
    return 'DebugEvent.checkOutRequested(spotId: $spotId, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckOutRequestedImpl &&
            (identical(other.spotId, spotId) || other.spotId == spotId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, spotId, userId);

  /// Create a copy of DebugEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckOutRequestedImplCopyWith<_$CheckOutRequestedImpl> get copyWith =>
      __$$CheckOutRequestedImplCopyWithImpl<_$CheckOutRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() toggleDebugMode,
    required TResult Function() pickLocationToggled,
    required TResult Function(int spotId, String userId) checkInRequested,
    required TResult Function(int spotId, String userId) checkOutRequested,
    required TResult Function(String message) logMessage,
  }) {
    return checkOutRequested(spotId, userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? toggleDebugMode,
    TResult? Function()? pickLocationToggled,
    TResult? Function(int spotId, String userId)? checkInRequested,
    TResult? Function(int spotId, String userId)? checkOutRequested,
    TResult? Function(String message)? logMessage,
  }) {
    return checkOutRequested?.call(spotId, userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? toggleDebugMode,
    TResult Function()? pickLocationToggled,
    TResult Function(int spotId, String userId)? checkInRequested,
    TResult Function(int spotId, String userId)? checkOutRequested,
    TResult Function(String message)? logMessage,
    required TResult orElse(),
  }) {
    if (checkOutRequested != null) {
      return checkOutRequested(spotId, userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ToggleDebugMode value) toggleDebugMode,
    required TResult Function(_PickLocationToggled value) pickLocationToggled,
    required TResult Function(_CheckInRequested value) checkInRequested,
    required TResult Function(_CheckOutRequested value) checkOutRequested,
    required TResult Function(_LogMessage value) logMessage,
  }) {
    return checkOutRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(_PickLocationToggled value)? pickLocationToggled,
    TResult? Function(_CheckInRequested value)? checkInRequested,
    TResult? Function(_CheckOutRequested value)? checkOutRequested,
    TResult? Function(_LogMessage value)? logMessage,
  }) {
    return checkOutRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggleDebugMode value)? toggleDebugMode,
    TResult Function(_PickLocationToggled value)? pickLocationToggled,
    TResult Function(_CheckInRequested value)? checkInRequested,
    TResult Function(_CheckOutRequested value)? checkOutRequested,
    TResult Function(_LogMessage value)? logMessage,
    required TResult orElse(),
  }) {
    if (checkOutRequested != null) {
      return checkOutRequested(this);
    }
    return orElse();
  }
}

abstract class _CheckOutRequested implements DebugEvent {
  const factory _CheckOutRequested({
    required final int spotId,
    required final String userId,
  }) = _$CheckOutRequestedImpl;

  int get spotId;
  String get userId;

  /// Create a copy of DebugEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckOutRequestedImplCopyWith<_$CheckOutRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LogMessageImplCopyWith<$Res> {
  factory _$$LogMessageImplCopyWith(
    _$LogMessageImpl value,
    $Res Function(_$LogMessageImpl) then,
  ) = __$$LogMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$LogMessageImplCopyWithImpl<$Res>
    extends _$DebugEventCopyWithImpl<$Res, _$LogMessageImpl>
    implements _$$LogMessageImplCopyWith<$Res> {
  __$$LogMessageImplCopyWithImpl(
    _$LogMessageImpl _value,
    $Res Function(_$LogMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebugEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$LogMessageImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LogMessageImpl implements _LogMessage {
  const _$LogMessageImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'DebugEvent.logMessage(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogMessageImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of DebugEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LogMessageImplCopyWith<_$LogMessageImpl> get copyWith =>
      __$$LogMessageImplCopyWithImpl<_$LogMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() toggleDebugMode,
    required TResult Function() pickLocationToggled,
    required TResult Function(int spotId, String userId) checkInRequested,
    required TResult Function(int spotId, String userId) checkOutRequested,
    required TResult Function(String message) logMessage,
  }) {
    return logMessage(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? toggleDebugMode,
    TResult? Function()? pickLocationToggled,
    TResult? Function(int spotId, String userId)? checkInRequested,
    TResult? Function(int spotId, String userId)? checkOutRequested,
    TResult? Function(String message)? logMessage,
  }) {
    return logMessage?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? toggleDebugMode,
    TResult Function()? pickLocationToggled,
    TResult Function(int spotId, String userId)? checkInRequested,
    TResult Function(int spotId, String userId)? checkOutRequested,
    TResult Function(String message)? logMessage,
    required TResult orElse(),
  }) {
    if (logMessage != null) {
      return logMessage(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ToggleDebugMode value) toggleDebugMode,
    required TResult Function(_PickLocationToggled value) pickLocationToggled,
    required TResult Function(_CheckInRequested value) checkInRequested,
    required TResult Function(_CheckOutRequested value) checkOutRequested,
    required TResult Function(_LogMessage value) logMessage,
  }) {
    return logMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggleDebugMode value)? toggleDebugMode,
    TResult? Function(_PickLocationToggled value)? pickLocationToggled,
    TResult? Function(_CheckInRequested value)? checkInRequested,
    TResult? Function(_CheckOutRequested value)? checkOutRequested,
    TResult? Function(_LogMessage value)? logMessage,
  }) {
    return logMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggleDebugMode value)? toggleDebugMode,
    TResult Function(_PickLocationToggled value)? pickLocationToggled,
    TResult Function(_CheckInRequested value)? checkInRequested,
    TResult Function(_CheckOutRequested value)? checkOutRequested,
    TResult Function(_LogMessage value)? logMessage,
    required TResult orElse(),
  }) {
    if (logMessage != null) {
      return logMessage(this);
    }
    return orElse();
  }
}

abstract class _LogMessage implements DebugEvent {
  const factory _LogMessage(final String message) = _$LogMessageImpl;

  String get message;

  /// Create a copy of DebugEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LogMessageImplCopyWith<_$LogMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DebugState {
  bool get isDebugModeEnabled => throw _privateConstructorUsedError;
  bool get isPickingLocation => throw _privateConstructorUsedError;

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
  $Res call({bool isDebugModeEnabled, bool isPickingLocation});
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
  $Res call({
    Object? isDebugModeEnabled = null,
    Object? isPickingLocation = null,
  }) {
    return _then(
      _value.copyWith(
            isDebugModeEnabled: null == isDebugModeEnabled
                ? _value.isDebugModeEnabled
                : isDebugModeEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPickingLocation: null == isPickingLocation
                ? _value.isPickingLocation
                : isPickingLocation // ignore: cast_nullable_to_non_nullable
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
  $Res call({bool isDebugModeEnabled, bool isPickingLocation});
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
  $Res call({
    Object? isDebugModeEnabled = null,
    Object? isPickingLocation = null,
  }) {
    return _then(
      _$DebugStateImpl(
        isDebugModeEnabled: null == isDebugModeEnabled
            ? _value.isDebugModeEnabled
            : isDebugModeEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPickingLocation: null == isPickingLocation
            ? _value.isPickingLocation
            : isPickingLocation // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$DebugStateImpl implements _DebugState {
  const _$DebugStateImpl({
    this.isDebugModeEnabled = false,
    this.isPickingLocation = false,
  });

  @override
  @JsonKey()
  final bool isDebugModeEnabled;
  @override
  @JsonKey()
  final bool isPickingLocation;

  @override
  String toString() {
    return 'DebugState(isDebugModeEnabled: $isDebugModeEnabled, isPickingLocation: $isPickingLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DebugStateImpl &&
            (identical(other.isDebugModeEnabled, isDebugModeEnabled) ||
                other.isDebugModeEnabled == isDebugModeEnabled) &&
            (identical(other.isPickingLocation, isPickingLocation) ||
                other.isPickingLocation == isPickingLocation));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isDebugModeEnabled, isPickingLocation);

  /// Create a copy of DebugState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DebugStateImplCopyWith<_$DebugStateImpl> get copyWith =>
      __$$DebugStateImplCopyWithImpl<_$DebugStateImpl>(this, _$identity);
}

abstract class _DebugState implements DebugState {
  const factory _DebugState({
    final bool isDebugModeEnabled,
    final bool isPickingLocation,
  }) = _$DebugStateImpl;

  @override
  bool get isDebugModeEnabled;
  @override
  bool get isPickingLocation;

  /// Create a copy of DebugState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DebugStateImplCopyWith<_$DebugStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
