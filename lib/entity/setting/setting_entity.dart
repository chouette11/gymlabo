import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_entity.freezed.dart';

@freezed
class SettingEntity with _$SettingEntity {
  const factory SettingEntity({
    required String title,
    required IconData icon,
    required String desc,
    required String route,
  }) = _SettingEntity;
}
