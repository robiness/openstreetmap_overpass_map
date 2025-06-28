// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(User? user) userChanged,
    required TResult Function() signInWithGoogleRequested,
    required TResult Function() signInWithAppleRequested,
    required TResult Function() signOutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(User? user)? userChanged,
    TResult? Function()? signInWithGoogleRequested,
    TResult? Function()? signInWithAppleRequested,
    TResult? Function()? signOutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(User? user)? userChanged,
    TResult Function()? signInWithGoogleRequested,
    TResult Function()? signInWithAppleRequested,
    TResult Function()? signOutRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(UserChanged value) userChanged,
    required TResult Function(SignInWithGoogleRequested value)
    signInWithGoogleRequested,
    required TResult Function(SignInWithAppleRequested value)
    signInWithAppleRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(UserChanged value)? userChanged,
    TResult? Function(SignInWithGoogleRequested value)?
    signInWithGoogleRequested,
    TResult? Function(SignInWithAppleRequested value)? signInWithAppleRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(UserChanged value)? userChanged,
    TResult Function(SignInWithGoogleRequested value)?
    signInWithGoogleRequested,
    TResult Function(SignInWithAppleRequested value)? signInWithAppleRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AppStartedImplCopyWith<$Res> {
  factory _$$AppStartedImplCopyWith(
    _$AppStartedImpl value,
    $Res Function(_$AppStartedImpl) then,
  ) = __$$AppStartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppStartedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AppStartedImpl>
    implements _$$AppStartedImplCopyWith<$Res> {
  __$$AppStartedImplCopyWithImpl(
    _$AppStartedImpl _value,
    $Res Function(_$AppStartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AppStartedImpl implements AppStarted {
  const _$AppStartedImpl();

  @override
  String toString() {
    return 'AuthEvent.appStarted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(User? user) userChanged,
    required TResult Function() signInWithGoogleRequested,
    required TResult Function() signInWithAppleRequested,
    required TResult Function() signOutRequested,
  }) {
    return appStarted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(User? user)? userChanged,
    TResult? Function()? signInWithGoogleRequested,
    TResult? Function()? signInWithAppleRequested,
    TResult? Function()? signOutRequested,
  }) {
    return appStarted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(User? user)? userChanged,
    TResult Function()? signInWithGoogleRequested,
    TResult Function()? signInWithAppleRequested,
    TResult Function()? signOutRequested,
    required TResult orElse(),
  }) {
    if (appStarted != null) {
      return appStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(UserChanged value) userChanged,
    required TResult Function(SignInWithGoogleRequested value)
    signInWithGoogleRequested,
    required TResult Function(SignInWithAppleRequested value)
    signInWithAppleRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
  }) {
    return appStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(UserChanged value)? userChanged,
    TResult? Function(SignInWithGoogleRequested value)?
    signInWithGoogleRequested,
    TResult? Function(SignInWithAppleRequested value)? signInWithAppleRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
  }) {
    return appStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(UserChanged value)? userChanged,
    TResult Function(SignInWithGoogleRequested value)?
    signInWithGoogleRequested,
    TResult Function(SignInWithAppleRequested value)? signInWithAppleRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    required TResult orElse(),
  }) {
    if (appStarted != null) {
      return appStarted(this);
    }
    return orElse();
  }
}

abstract class AppStarted implements AuthEvent {
  const factory AppStarted() = _$AppStartedImpl;
}

/// @nodoc
abstract class _$$UserChangedImplCopyWith<$Res> {
  factory _$$UserChangedImplCopyWith(
    _$UserChangedImpl value,
    $Res Function(_$UserChangedImpl) then,
  ) = __$$UserChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User? user});
}

/// @nodoc
class __$$UserChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$UserChangedImpl>
    implements _$$UserChangedImplCopyWith<$Res> {
  __$$UserChangedImplCopyWithImpl(
    _$UserChangedImpl _value,
    $Res Function(_$UserChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = freezed}) {
    return _then(
      _$UserChangedImpl(
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as User?,
      ),
    );
  }
}

/// @nodoc

class _$UserChangedImpl implements UserChanged {
  const _$UserChangedImpl({this.user});

  @override
  final User? user;

  @override
  String toString() {
    return 'AuthEvent.userChanged(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserChangedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserChangedImplCopyWith<_$UserChangedImpl> get copyWith =>
      __$$UserChangedImplCopyWithImpl<_$UserChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(User? user) userChanged,
    required TResult Function() signInWithGoogleRequested,
    required TResult Function() signInWithAppleRequested,
    required TResult Function() signOutRequested,
  }) {
    return userChanged(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(User? user)? userChanged,
    TResult? Function()? signInWithGoogleRequested,
    TResult? Function()? signInWithAppleRequested,
    TResult? Function()? signOutRequested,
  }) {
    return userChanged?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(User? user)? userChanged,
    TResult Function()? signInWithGoogleRequested,
    TResult Function()? signInWithAppleRequested,
    TResult Function()? signOutRequested,
    required TResult orElse(),
  }) {
    if (userChanged != null) {
      return userChanged(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(UserChanged value) userChanged,
    required TResult Function(SignInWithGoogleRequested value)
    signInWithGoogleRequested,
    required TResult Function(SignInWithAppleRequested value)
    signInWithAppleRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
  }) {
    return userChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(UserChanged value)? userChanged,
    TResult? Function(SignInWithGoogleRequested value)?
    signInWithGoogleRequested,
    TResult? Function(SignInWithAppleRequested value)? signInWithAppleRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
  }) {
    return userChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(UserChanged value)? userChanged,
    TResult Function(SignInWithGoogleRequested value)?
    signInWithGoogleRequested,
    TResult Function(SignInWithAppleRequested value)? signInWithAppleRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    required TResult orElse(),
  }) {
    if (userChanged != null) {
      return userChanged(this);
    }
    return orElse();
  }
}

abstract class UserChanged implements AuthEvent {
  const factory UserChanged({final User? user}) = _$UserChangedImpl;

  User? get user;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserChangedImplCopyWith<_$UserChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignInWithGoogleRequestedImplCopyWith<$Res> {
  factory _$$SignInWithGoogleRequestedImplCopyWith(
    _$SignInWithGoogleRequestedImpl value,
    $Res Function(_$SignInWithGoogleRequestedImpl) then,
  ) = __$$SignInWithGoogleRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignInWithGoogleRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignInWithGoogleRequestedImpl>
    implements _$$SignInWithGoogleRequestedImplCopyWith<$Res> {
  __$$SignInWithGoogleRequestedImplCopyWithImpl(
    _$SignInWithGoogleRequestedImpl _value,
    $Res Function(_$SignInWithGoogleRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignInWithGoogleRequestedImpl implements SignInWithGoogleRequested {
  const _$SignInWithGoogleRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.signInWithGoogleRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInWithGoogleRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(User? user) userChanged,
    required TResult Function() signInWithGoogleRequested,
    required TResult Function() signInWithAppleRequested,
    required TResult Function() signOutRequested,
  }) {
    return signInWithGoogleRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(User? user)? userChanged,
    TResult? Function()? signInWithGoogleRequested,
    TResult? Function()? signInWithAppleRequested,
    TResult? Function()? signOutRequested,
  }) {
    return signInWithGoogleRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(User? user)? userChanged,
    TResult Function()? signInWithGoogleRequested,
    TResult Function()? signInWithAppleRequested,
    TResult Function()? signOutRequested,
    required TResult orElse(),
  }) {
    if (signInWithGoogleRequested != null) {
      return signInWithGoogleRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(UserChanged value) userChanged,
    required TResult Function(SignInWithGoogleRequested value)
    signInWithGoogleRequested,
    required TResult Function(SignInWithAppleRequested value)
    signInWithAppleRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
  }) {
    return signInWithGoogleRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(UserChanged value)? userChanged,
    TResult? Function(SignInWithGoogleRequested value)?
    signInWithGoogleRequested,
    TResult? Function(SignInWithAppleRequested value)? signInWithAppleRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
  }) {
    return signInWithGoogleRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(UserChanged value)? userChanged,
    TResult Function(SignInWithGoogleRequested value)?
    signInWithGoogleRequested,
    TResult Function(SignInWithAppleRequested value)? signInWithAppleRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    required TResult orElse(),
  }) {
    if (signInWithGoogleRequested != null) {
      return signInWithGoogleRequested(this);
    }
    return orElse();
  }
}

abstract class SignInWithGoogleRequested implements AuthEvent {
  const factory SignInWithGoogleRequested() = _$SignInWithGoogleRequestedImpl;
}

/// @nodoc
abstract class _$$SignInWithAppleRequestedImplCopyWith<$Res> {
  factory _$$SignInWithAppleRequestedImplCopyWith(
    _$SignInWithAppleRequestedImpl value,
    $Res Function(_$SignInWithAppleRequestedImpl) then,
  ) = __$$SignInWithAppleRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignInWithAppleRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignInWithAppleRequestedImpl>
    implements _$$SignInWithAppleRequestedImplCopyWith<$Res> {
  __$$SignInWithAppleRequestedImplCopyWithImpl(
    _$SignInWithAppleRequestedImpl _value,
    $Res Function(_$SignInWithAppleRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignInWithAppleRequestedImpl implements SignInWithAppleRequested {
  const _$SignInWithAppleRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.signInWithAppleRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInWithAppleRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(User? user) userChanged,
    required TResult Function() signInWithGoogleRequested,
    required TResult Function() signInWithAppleRequested,
    required TResult Function() signOutRequested,
  }) {
    return signInWithAppleRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(User? user)? userChanged,
    TResult? Function()? signInWithGoogleRequested,
    TResult? Function()? signInWithAppleRequested,
    TResult? Function()? signOutRequested,
  }) {
    return signInWithAppleRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(User? user)? userChanged,
    TResult Function()? signInWithGoogleRequested,
    TResult Function()? signInWithAppleRequested,
    TResult Function()? signOutRequested,
    required TResult orElse(),
  }) {
    if (signInWithAppleRequested != null) {
      return signInWithAppleRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(UserChanged value) userChanged,
    required TResult Function(SignInWithGoogleRequested value)
    signInWithGoogleRequested,
    required TResult Function(SignInWithAppleRequested value)
    signInWithAppleRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
  }) {
    return signInWithAppleRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(UserChanged value)? userChanged,
    TResult? Function(SignInWithGoogleRequested value)?
    signInWithGoogleRequested,
    TResult? Function(SignInWithAppleRequested value)? signInWithAppleRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
  }) {
    return signInWithAppleRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(UserChanged value)? userChanged,
    TResult Function(SignInWithGoogleRequested value)?
    signInWithGoogleRequested,
    TResult Function(SignInWithAppleRequested value)? signInWithAppleRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    required TResult orElse(),
  }) {
    if (signInWithAppleRequested != null) {
      return signInWithAppleRequested(this);
    }
    return orElse();
  }
}

abstract class SignInWithAppleRequested implements AuthEvent {
  const factory SignInWithAppleRequested() = _$SignInWithAppleRequestedImpl;
}

/// @nodoc
abstract class _$$SignOutRequestedImplCopyWith<$Res> {
  factory _$$SignOutRequestedImplCopyWith(
    _$SignOutRequestedImpl value,
    $Res Function(_$SignOutRequestedImpl) then,
  ) = __$$SignOutRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignOutRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignOutRequestedImpl>
    implements _$$SignOutRequestedImplCopyWith<$Res> {
  __$$SignOutRequestedImplCopyWithImpl(
    _$SignOutRequestedImpl _value,
    $Res Function(_$SignOutRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignOutRequestedImpl implements SignOutRequested {
  const _$SignOutRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.signOutRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignOutRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(User? user) userChanged,
    required TResult Function() signInWithGoogleRequested,
    required TResult Function() signInWithAppleRequested,
    required TResult Function() signOutRequested,
  }) {
    return signOutRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(User? user)? userChanged,
    TResult? Function()? signInWithGoogleRequested,
    TResult? Function()? signInWithAppleRequested,
    TResult? Function()? signOutRequested,
  }) {
    return signOutRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(User? user)? userChanged,
    TResult Function()? signInWithGoogleRequested,
    TResult Function()? signInWithAppleRequested,
    TResult Function()? signOutRequested,
    required TResult orElse(),
  }) {
    if (signOutRequested != null) {
      return signOutRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(UserChanged value) userChanged,
    required TResult Function(SignInWithGoogleRequested value)
    signInWithGoogleRequested,
    required TResult Function(SignInWithAppleRequested value)
    signInWithAppleRequested,
    required TResult Function(SignOutRequested value) signOutRequested,
  }) {
    return signOutRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(UserChanged value)? userChanged,
    TResult? Function(SignInWithGoogleRequested value)?
    signInWithGoogleRequested,
    TResult? Function(SignInWithAppleRequested value)? signInWithAppleRequested,
    TResult? Function(SignOutRequested value)? signOutRequested,
  }) {
    return signOutRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(UserChanged value)? userChanged,
    TResult Function(SignInWithGoogleRequested value)?
    signInWithGoogleRequested,
    TResult Function(SignInWithAppleRequested value)? signInWithAppleRequested,
    TResult Function(SignOutRequested value)? signOutRequested,
    required TResult orElse(),
  }) {
    if (signOutRequested != null) {
      return signOutRequested(this);
    }
    return orElse();
  }
}

abstract class SignOutRequested implements AuthEvent {
  const factory SignOutRequested() = _$SignOutRequestedImpl;
}
