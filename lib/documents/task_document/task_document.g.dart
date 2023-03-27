// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskDocument _$$_TaskDocumentFromJson(Map<String, dynamic> json) =>
    _$_TaskDocument(
      userId: json['userId'] as String,
      token: json['token'] as String?,
      tokens:
          (json['tokens'] as List<dynamic>?)?.map((e) => e as String).toList(),
      taskId: json['taskId'] as String,
      title: json['title'] as String,
      deadline:
          const TimestampConverter().fromJson(json['deadline'] as Timestamp),
    );

Map<String, dynamic> _$$_TaskDocumentToJson(_$_TaskDocument instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'token': instance.token,
      'tokens': instance.tokens,
      'taskId': instance.taskId,
      'title': instance.title,
      'deadline': const TimestampConverter().toJson(instance.deadline),
    };
