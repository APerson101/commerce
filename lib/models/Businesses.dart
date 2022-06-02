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


/** This is an auto generated class representing the Businesses type in your schema. */
@immutable
class Businesses extends Model {
  static const classType = const _BusinessesModelType();
  final String id;
  final String? _type;
  final String? _location;
  final String? _about;
  final String? _cac;
  final List<int>? _AvailableDays;
  final List<String>? _StarTimes;
  final List<String>? _EndTimes;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get type {
    return _type;
  }
  
  String? get location {
    return _location;
  }
  
  String? get about {
    return _about;
  }
  
  String? get cac {
    return _cac;
  }
  
  List<int>? get AvailableDays {
    return _AvailableDays;
  }
  
  List<String>? get StarTimes {
    return _StarTimes;
  }
  
  List<String>? get EndTimes {
    return _EndTimes;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Businesses._internal({required this.id, type, location, about, cac, AvailableDays, StarTimes, EndTimes, createdAt, updatedAt}): _type = type, _location = location, _about = about, _cac = cac, _AvailableDays = AvailableDays, _StarTimes = StarTimes, _EndTimes = EndTimes, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Businesses({String? id, String? type, String? location, String? about, String? cac, List<int>? AvailableDays, List<String>? StarTimes, List<String>? EndTimes}) {
    return Businesses._internal(
      id: id == null ? UUID.getUUID() : id,
      type: type,
      location: location,
      about: about,
      cac: cac,
      AvailableDays: AvailableDays != null ? List<int>.unmodifiable(AvailableDays) : AvailableDays,
      StarTimes: StarTimes != null ? List<String>.unmodifiable(StarTimes) : StarTimes,
      EndTimes: EndTimes != null ? List<String>.unmodifiable(EndTimes) : EndTimes);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Businesses &&
      id == other.id &&
      _type == other._type &&
      _location == other._location &&
      _about == other._about &&
      _cac == other._cac &&
      DeepCollectionEquality().equals(_AvailableDays, other._AvailableDays) &&
      DeepCollectionEquality().equals(_StarTimes, other._StarTimes) &&
      DeepCollectionEquality().equals(_EndTimes, other._EndTimes);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Businesses {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("type=" + "$_type" + ", ");
    buffer.write("location=" + "$_location" + ", ");
    buffer.write("about=" + "$_about" + ", ");
    buffer.write("cac=" + "$_cac" + ", ");
    buffer.write("AvailableDays=" + (_AvailableDays != null ? _AvailableDays!.toString() : "null") + ", ");
    buffer.write("StarTimes=" + (_StarTimes != null ? _StarTimes!.toString() : "null") + ", ");
    buffer.write("EndTimes=" + (_EndTimes != null ? _EndTimes!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Businesses copyWith({String? id, String? type, String? location, String? about, String? cac, List<int>? AvailableDays, List<String>? StarTimes, List<String>? EndTimes}) {
    return Businesses._internal(
      id: id ?? this.id,
      type: type ?? this.type,
      location: location ?? this.location,
      about: about ?? this.about,
      cac: cac ?? this.cac,
      AvailableDays: AvailableDays ?? this.AvailableDays,
      StarTimes: StarTimes ?? this.StarTimes,
      EndTimes: EndTimes ?? this.EndTimes);
  }
  
  Businesses.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _type = json['type'],
      _location = json['location'],
      _about = json['about'],
      _cac = json['cac'],
      _AvailableDays = (json['AvailableDays'] as List?)?.map((e) => (e as num).toInt()).toList(),
      _StarTimes = json['StarTimes']?.cast<String>(),
      _EndTimes = json['EndTimes']?.cast<String>(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'type': _type, 'location': _location, 'about': _about, 'cac': _cac, 'AvailableDays': _AvailableDays, 'StarTimes': _StarTimes, 'EndTimes': _EndTimes, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "businesses.id");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static final QueryField ABOUT = QueryField(fieldName: "about");
  static final QueryField CAC = QueryField(fieldName: "cac");
  static final QueryField AVAILABLEDAYS = QueryField(fieldName: "AvailableDays");
  static final QueryField STARTIMES = QueryField(fieldName: "StarTimes");
  static final QueryField ENDTIMES = QueryField(fieldName: "EndTimes");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Businesses";
    modelSchemaDefinition.pluralName = "Businesses";
    
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
      key: Businesses.TYPE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Businesses.LOCATION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Businesses.ABOUT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Businesses.CAC,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Businesses.AVAILABLEDAYS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.int))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Businesses.STARTIMES,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Businesses.ENDTIMES,
      isRequired: false,
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

class _BusinessesModelType extends ModelType<Businesses> {
  const _BusinessesModelType();
  
  @override
  Businesses fromJson(Map<String, dynamic> jsonData) {
    return Businesses.fromJson(jsonData);
  }
}