import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_template/entity/json_converter/timestamp_converter.dart';

part 'task_document.freezed.dart';

part 'task_document.g.dart';

@freezed
class TaskDocument with _$TaskDocument {
  const TaskDocument._();

  const factory TaskDocument({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'userId') required String userId,
    @JsonKey(name: 'token') String? token,
    @JsonKey(name: 'tokens') List<String>? tokens,
    @JsonKey(name: 'taskId') required String taskId,
    @JsonKey(name: 'title') required String title,
    @TimestampConverter() @JsonKey(name: 'deadline') required DateTime deadline,
  }) = _TaskDocument;

  factory TaskDocument.fromJson(Map<String, dynamic> json) =>
      _$TaskDocumentFromJson(json);
}
