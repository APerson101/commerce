/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Users type in your schema. */
@immutable
class Users extends Model {
  static const classType = const _UsersModelType();
  final String id;
  final String? _name;
  final bool? _isBusiness;
  final String? _cac;
  final List<String>? _pics;
  final String? _number;
  final String? _country;
  final String? _bank;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get isBusiness {
    try {
      return _isBusiness!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get cac {
    return _cac;
  }
  
  List<String> get pics {
    try {
      return _pics!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get number {
    return _number;
  }
  
  String? get country {
    return _country;
  }
  
  String? get bank {
    return _bank;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Users._internal({required this.id, required name, required isBusiness, cac, required pics, number, country, bank, createdAt, updatedAt}): _name = name, _isBusiness = isBusiness, _cac = cac, _pics = pics, _number = number, _country = country, _bank = bank, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Users({String? id, required String name, required bool isBusiness, String? cac, required List<String> pics, String? number, String? country, String? bank}) {
    return Users._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      isBusiness: isBusiness,
      cac: cac,
      pics: pics != null ? List<String>.unmodifiable(pics) : pics,
      number: number,
      country: country,
      bank: bank);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Users &&
      id == other.id &&
      _name == other._name &&
      _isBusiness == other._isBusiness &&
      _cac == other._cac &&
      DeepCollectionEquality().equals(_pics, other._pics) &&
      _number == other._number &&
      _country == other._country &&
      _bank == other._bank;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Users {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("isBusiness=" + (_isBusiness != null ? _isBusiness!.toString() : "null") + ", ");
    buffer.write("cac=" + "$_cac" + ", ");
    buffer.write("pics=" + (_pics != null ? _pics!.toString() : "null") + ", ");
    buffer.write("number=" + "$_number" + ", ");
    buffer.write("country=" + "$_country" + ", ");
    buffer.write("bank=" + "$_bank" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Users copyWith({String? id, String? name, bool? isBusiness, String? cac, List<String>? pics, String? number, String? country, String? bank}) {
    return Users._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      isBusiness: isBusiness ?? this.isBusiness,
      cac: cac ?? this.cac,
      pics: pics ?? this.pics,
      number: number ?? this.number,
      country: country ?? this.country,
      bank: bank ?? this.bank);
  }
  
  Users.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _isBusiness = json['isBusiness'],
      _cac = json['cac'],
      _pics = json['pics']?.cast<String>(),
      _number = json['number'],
      _country = json['country'],
      _bank = json['bank'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'isBusiness': _isBusiness, 'cac': _cac, 'pics': _pics, 'number': _number, 'country': _country, 'bank': _bank, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "users.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ISBUSINESS = QueryField(fieldName: "isBusiness");
  static final QueryField CAC = QueryField(fieldName: "cac");
  static final QueryField PICS = QueryField(fieldName: "pics");
  static final QueryField NUMBER = QueryField(fieldName: "number");
  static final QueryField COUNTRY = QueryField(fieldName: "country");
  static final QueryField BANK = QueryField(fieldName: "bank");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Users";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.ISBUSINESS,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.CAC,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.PICS,
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.NUMBER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.COUNTRY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.BANK,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UsersModelType extends ModelType<Users> {
  const _UsersModelType();
  
  @override
  Users fromJson(Map<String, dynamic> jsonData) {
    return Users.fromJson(jsonData);
  }
}