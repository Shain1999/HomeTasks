// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'description.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Description extends Description {
  @override
  final String value;

  factory _$Description([void Function(DescriptionBuilder)? updates]) =>
      (new DescriptionBuilder()..update(updates))._build();

  _$Description._({required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(value, r'Description', 'value');
  }

  @override
  Description rebuild(void Function(DescriptionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DescriptionBuilder toBuilder() => new DescriptionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Description && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }
}

class DescriptionBuilder implements Builder<Description, DescriptionBuilder> {
  _$Description? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  DescriptionBuilder();

  DescriptionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Description other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Description;
  }

  @override
  void update(void Function(DescriptionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Description build() => _build();

  _$Description _build() {
    final _$result = _$v ??
        new _$Description._(
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'Description', 'value'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
