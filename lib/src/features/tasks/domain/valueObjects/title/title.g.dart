// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'title.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Title extends Title {
  @override
  final String value;

  factory _$Title([void Function(TitleBuilder)? updates]) =>
      (new TitleBuilder()..update(updates))._build();

  _$Title._({required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(value, r'Title', 'value');
  }

  @override
  Title rebuild(void Function(TitleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TitleBuilder toBuilder() => new TitleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Title && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }
}

class TitleBuilder implements Builder<Title, TitleBuilder> {
  _$Title? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  TitleBuilder();

  TitleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Title other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Title;
  }

  @override
  void update(void Function(TitleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Title build() => _build();

  _$Title _build() {
    final _$result = _$v ??
        new _$Title._(
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'Title', 'value'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
