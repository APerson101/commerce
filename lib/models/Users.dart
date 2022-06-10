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
  final String? _bank;
  final bool? _isBusiness;
  final String? _country;
  final String? _number;
  final String? _cac;
  final List<String>? _pics;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  String? get bank {
    return _bank;
  }
  
  bool? get isBusiness {
    return _isBusiness;
  }
  
  String? get country {
    return _country;
  }
  
  String? get number {
    return _number;
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
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Users._internal({required this.id, name, bank, isBusiness, country, number, cac, required pics, createdAt, updatedAt}): _name = name, _bank = bank, _isBusiness = isBusiness, _country = country, _number = number, _cac = cac, _pics = pics, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Users({String? id, String? name, String? bank, bool? isBusiness, String? country, String? number, String? cac, required List<String> pics}) {
    return Users._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      bank: bank,
      isBusiness: isBusiness,
      country: country,
      number: number,
      cac: cac,
      pics: pics != null ? List<String>.unmodifiable(pics) : pics);
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
      _bank == other._bank &&
      _isBusiness == other._isBusiness &&
      _country == other._country &&
      _number == other._number &&
      _cac == other._cac &&
      DeepCollectionEquality().equals(_pics, other._pics);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Users {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("bank=" + "$_bank" + ", ");
    buffer.write("isBusiness=" + (_isBusiness != null ? _isBusiness!.toString() : "null") + ", ");
    buffer.write("country=" + "$_country" + ", ");
    buffer.write("number=" + "$_number" + ", ");
    buffer.write("cac=" + "$_cac" + ", ");
    buffer.write("pics=" + (_pics != null ? _pics!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Users copyWith({String? id, String? name, String? bank, bool? isBusiness, String? country, String? number, String? cac, List<String>? pics}) {
    return Users._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      bank: bank ?? this.bank,
      isBusiness: isBusiness ?? this.isBusiness,
      country: country ?? this.country,
      number: number ?? this.number,
      cac: cac ?? this.cac,
      pics: pics ?? this.pics);
  }
  
  Users.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _bank = json['bank'],
      _isBusiness = json['isBusiness'],
      _country = json['country'],
      _number = json['number'],
      _cac = json['cac'],
      _pics = json['pics']?.cast<String>(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'bank': _bank, 'isBusiness': _isBusiness, 'country': _country, 'number': _number, 'cac': _cac, 'pics': _pics, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "users.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField BANK = QueryField(fieldName: "bank");
  static final QueryField ISBUSINESS = QueryField(fieldName: "isBusiness");
  static final QueryField COUNTRY = QueryField(fieldName: "country");
  static final QueryField NUMBER = QueryField(fieldName: "number");
  static final QueryField CAC = QueryField(fieldName: "cac");
  static final QueryField PICS = QueryField(fieldName: "pics");
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
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.BANK,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.ISBUSINESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.COUNTRY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.NUMBER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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