import 'package:flutter/material.dart';
import '../../../core/core_export.dart'; 

class Validation {
  String text;

  String fieldName;
  //rules
  bool _length = true;
  bool _unique = true;
  bool _required = true;
  bool _numeric = true;
  bool _email = true;
  bool _date = true;
  bool _time = true;

  // validation results :
  // => errors
  List<String> _errors = [];
  //
  bool _isValid = false;

  Validation(this.text, {this.fieldName = ''});

  Validation length({required int minLength, int? maxLength}) {
    if (maxLength != null) {
      _length = text.length >= minLength && text.length <= maxLength;
      _length
          ? null
          : _errors.add('$fieldName length must be $minLength ~ $maxLength');
    } else {
      _length = text.length >= minLength;
      _length ? null : _errors.add('$fieldName length must be $minLength');
    }
    return this;
  }

  Validation numeric() {
    if (text.isEmpty){//nullable case 
      _numeric = true;
      return this; 
    }
    try {
      int.parse(text);
    } catch (e) {
      _numeric = false;
      _numeric ? null : _errors.add('$fieldName must be numeric only');
    }
    return this;
  }

  Future<Validation> unique(String table, String column) async {
    if (text.isEmpty){//nullable case 
      _unique = true;
      return this; 
    }
    await appDatabase
        .table(table)
        .selectWhere('$column  = ?', [text]).then((queryResult) {
      _unique = queryResult.isEmpty;
      _unique ? null : _errors.add('$fieldName already exist');
    });
    return this;
  }

  Validation required() {
    _required = text.isNotEmpty;
    _required ? null : _errors.add('$fieldName is required');
    return this;
  }

  Validation email() {
    if (text.isEmpty){//nullable case 
      _email = true;
      return this; 
    }
    _email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false)
        .hasMatch(text);
    _email ? null : _errors.add('$fieldName is invalid email address');
    return this;
  }

  Validation date() {
    if (text.isEmpty){//nullable case 
      _date = true;
      return this; 
    }
    _date = RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(text);
    //convert date format to ISO8601
    String dateISO8601 = text.split('/').reversed.toList().join('-');
    try {
      DateTime.parse(dateISO8601);
      _date = true ; 
    } catch (e) {
      debugPrint('Validation.dart : Line 76 : $e'); 
      _date = false;
    }
    _date ? null : _errors.add('$fieldName is Invalid');
    return this;
  }

  Validation time() {
    if (text.isEmpty){//nullable case 
      _time = true;
      return this; 
    }
    _time = RegExp(r'^([0-1][0-9]|2[0-3]):[0-5][0-9]$').hasMatch(text);
    _time ? null : _errors.add('$fieldName is Invalid');
    return this;
  }

  Validation validate() {
    _isValid = (_length && _unique && _required && _numeric && _email);
    return this;
  }

  List<String> get errors {
    return _errors;
  }

  bool get isValid {
    return _isValid;
  }
}
