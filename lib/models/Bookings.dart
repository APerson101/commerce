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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Bookings type in your schema. */
@immutable
class Bookings extends Model {
  static const classType = const _BookingsModelType();
  final String id;
  final String? _user;
  final String? _business;
  final TemporalDateTime? _dateTime;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get user {
    return _user;
  }
  
  String? get business {
    return _business;
  }
  
  TemporalDateTime? get dateTime {
    return _dateTime;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Bookings._internal({required this.id, user, business, dateTime, createdAt, updatedAt}): _user = user, _business = business, _dateTime = dateTime, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Bookings({String? id, String? user, String? business, TemporalDateTime? dateTime}) {
    return Bookings._internal(
      id: id == null ? UUID.getUUID() : id,
      user: user,
      business: business,
      dateTime: dateTime);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Bookings &&
      id == other.id &&
      _user == other._user &&
      _business == other._business &&
      _dateTime == other._dateTime;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Bookings {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + "$_user" + ", ");
    buffer.write("business=" + "$_business" + ", ");
    buffer.write("dateTime=" + (_dateTime != null ? _dateTime!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Bookings copyWith({String? id, String? user, String? business, TemporalDateTime? dateTime}) {
    return Bookings._internal(
      id: id ?? this.id,
      user: user ?? this.user,
      business: business ?? this.business,
      dateTime: dateTime ?? this.dateTime);
  }
  
  Bookings.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _user = json['user'],
      _business = json['business'],
      _dateTime = json['dateTime'] != null ? TemporalDateTime.fromString(json['dateTime']) : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'user': _user, 'business': _business, 'dateTime': _dateTime?.format(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "bookings.id");
  static final QueryField USER = QueryField(fieldName: "user");
  static final QueryField BUSINESS = QueryField(fieldName: "business");
  static final QueryField DATETIME = QueryField(fieldName: "dateTime");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Bookings";
    modelSchemaDefinition.pluralName = "Bookings";
    
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
      key: Bookings.USER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bookings.BUSINESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bookings.DATETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
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

class _BookingsModelType extends ModelType<Bookings> {
  const _BookingsModelType();
  
  @override
  Bookings fromJson(Map<String, dynamic> jsonData) {
    return Bookings.fromJson(jsonData);
  }
}