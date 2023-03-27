// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskDocument _$TaskDocumentFromJson(Map<String, dynamic> json) {
  return _TaskDocument.fromJson(json);
}

/// @nodoc
mixin _$TaskDocument {
// ignore: invalid_annotation_target
  @JsonKey(name: 'userId')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'token')
  String? get token => throw _privateConstructorUsedError;
  @JsonKey(name: 'tokens')
  List<String>? get tokens => throw _privateConstructorUsedError;
  @JsonKey(name: 'taskId')
  String get taskId => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @TimestampConverter()
  @JsonKey(name: 'deadline')
  DateTime get deadline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskDocumentCopyWith<TaskDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDocumentCopyWith<$Res> {
  factory $TaskDocumentCopyWith(
          TaskDocument value, $Res Function(TaskDocument) then) =
      _$TaskDocumentCopyWithImpl<$Res, TaskDocument>;
  @useResult
  $Res call(
      {@JsonKey(name: 'userId') String userId,
      @JsonKey(name: 'token') String? token,
      @JsonKey(name: 'tokens') List<String>? tokens,
      @JsonKey(name: 'taskId') String taskId,
      @JsonKey(name: 'title') String title,
      @TimestampConverter() @JsonKey(name: 'deadline') DateTime deadline});
}

/// @nodoc
class _$TaskDocumentCopyWithImpl<$Res, $Val extends TaskDocument>
    implements $TaskDocumentCopyWith<$Res> {
  _$TaskDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? token = freezed,
    Object? tokens = freezed,
    Object? taskId = null,
    Object? title = null,
    Object? deadline = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      tokens: freezed == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskDocumentCopyWith<$Res>
    implements $TaskDocumentCopyWith<$Res> {
  factory _$$_TaskDocumentCopyWith(
          _$_TaskDocument value, $Res Function(_$_TaskDocument) then) =
      __$$_TaskDocumentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'userId') String userId,
      @JsonKey(name: 'token') String? token,
      @JsonKey(name: 'tokens') List<String>? tokens,
      @JsonKey(name: 'taskId') String taskId,
      @JsonKey(name: 'title') String title,
      @TimestampConverter() @JsonKey(name: 'deadline') DateTime deadline});
}

/// @nodoc
class __$$_TaskDocumentCopyWithImpl<$Res>
    extends _$TaskDocumentCopyWithImpl<$Res, _$_TaskDocument>
    implements _$$_TaskDocumentCopyWith<$Res> {
  __$$_TaskDocumentCopyWithImpl(
      _$_TaskDocument _value, $Res Function(_$_TaskDocument) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? token = freezed,
    Object? tokens = freezed,
    Object? taskId = null,
    Object? title = null,
    Object? deadline = null,
  }) {
    return _then(_$_TaskDocument(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      tokens: freezed == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskDocument extends _TaskDocument {
  const _$_TaskDocument(
      {@JsonKey(name: 'userId') required this.userId,
      @JsonKey(name: 'token') this.token,
      @JsonKey(name: 'tokens') final List<String>? tokens,
      @JsonKey(name: 'taskId') required this.taskId,
      @JsonKey(name: 'title') required this.title,
      @TimestampConverter() @JsonKey(name: 'deadline') required this.deadline})
      : _tokens = tokens,
        super._();

  factory _$_TaskDocument.fromJson(Map<String, dynamic> json) =>
      _$$_TaskDocumentFromJson(json);

// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'userId')
  final String userId;
  @override
  @JsonKey(name: 'token')
  final String? token;
  final List<String>? _tokens;
  @override
  @JsonKey(name: 'tokens')
  List<String>? get tokens {
    final value = _tokens;
    if (value == null) return null;
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'taskId')
  final String taskId;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @TimestampConverter()
  @JsonKey(name: 'deadline')
  final DateTime deadline;

  @override
  String toString() {
    return 'TaskDocument(userId: $userId, token: $token, tokens: $tokens, taskId: $taskId, title: $title, deadline: $deadline)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskDocument &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.token, token) || other.token == token) &&
            const DeepCollectionEquality().equals(other._tokens, _tokens) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, token,
      const DeepCollectionEquality().hash(_tokens), taskId, title, deadline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskDocumentCopyWith<_$_TaskDocument> get copyWith =>
      __$$_TaskDocumentCopyWithImpl<_$_TaskDocument>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskDocumentToJson(
      this,
    );
  }
}

abstract class _TaskDocument extends TaskDocument {
  const factory _TaskDocument(
      {@JsonKey(name: 'userId')
          required final String userId,
      @JsonKey(name: 'token')
          final String? token,
      @JsonKey(name: 'tokens')
          final List<String>? tokens,
      @JsonKey(name: 'taskId')
          required final String taskId,
      @JsonKey(name: 'title')
          required final String title,
      @TimestampConverter()
      @JsonKey(name: 'deadline')
          required final DateTime deadline}) = _$_TaskDocument;
  const _TaskDocument._() : super._();

  factory _TaskDocument.fromJson(Map<String, dynamic> json) =
      _$_TaskDocument.fromJson;

  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'userId')
  String get userId;
  @override
  @JsonKey(name: 'token')
  String? get token;
  @override
  @JsonKey(name: 'tokens')
  List<String>? get tokens;
  @override
  @JsonKey(name: 'taskId')
  String get taskId;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @TimestampConverter()
  @JsonKey(name: 'deadline')
  DateTime get deadline;
  @override
  @JsonKey(ignore: true)
  _$$_TaskDocumentCopyWith<_$_TaskDocument> get copyWith =>
      throw _privateConstructorUsedError;
}
