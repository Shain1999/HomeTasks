// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Score extends Score {
  @override
  final int value;

  factory _$Score([void Function(ScoreBuilder)? updates]) =>
      (new ScoreBuilder()..update(updates))._build();

  _$Score._({required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(value, r'Score', 'value');
  }

  @override
  Score rebuild(void Function(ScoreBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScoreBuilder toBuilder() => new ScoreBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Score && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Score')..add('value', value))
        .toString();
  }
}

class ScoreBuilder implements Builder<Score, ScoreBuilder> {
  _$Score? _$v;

  int? _value;
  int? get value => _$this._value;
  set value(int? value) => _$this._value = value;

  ScoreBuilder();

  ScoreBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Score other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Score;
  }

  @override
  void update(void Function(ScoreBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Score build() => _build();

  _$Score _build() {
    final _$result = _$v ??
        new _$Score._(
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'Score', 'value'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
