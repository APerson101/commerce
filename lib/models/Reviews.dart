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


/** This is an auto generated class representing the Reviews type in your schema. */
@immutable
class Reviews extends Model {
  static const classType = const _ReviewsModelType();
  final String id;
  final String? _userID;
  final String? _businessID;
  final String? _comment;
  final int? _stars;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get userID {
    return _userID;
  }
  
  String? get businessID {
    return _businessID;
  }
  
  String? get comment {
    return _comment;
  }
  
  int? get stars {
    return _stars;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Reviews._internal({required this.id, userID, businessID, comment, stars, createdAt, updatedAt}): _userID = userID, _businessID = businessID, _comment = comment, _stars = stars, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Reviews({String? id, String? userID, String? businessID, String? comment, int? stars}) {
    return Reviews._internal(
      id: id == null ? UUID.getUUID() : id,
      userID: userID,
      businessID: businessID,
      comment: comment,
      stars: stars);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Reviews &&
      id == other.id &&
      _userID == other._userID &&
      _businessID == other._businessID &&
      _comment == other._comment &&
      _stars == other._stars;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Reviews {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("businessID=" + "$_businessID" + ", ");
    buffer.write("comment=" + "$_comment" + ", ");
    buffer.write("stars=" + (_stars != null ? _stars!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Reviews copyWith({String? id, String? userID, String? businessID, String? comment, int? stars}) {
    return Reviews._internal(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      businessID: businessID ?? this.businessID,
      comment: comment ?? this.comment,
      stars: stars ?? this.stars);
  }
  
  Reviews.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userID = json['userID'],
      _businessID = json['businessID'],
      _comment = json['comment'],
      _stars = (json['stars'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userID': _userID, 'businessID': _businessID, 'comment': _comment, 'stars': _stars, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "reviews.id");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField BUSINESSID = QueryField(fieldName: "businessID");
  static final QueryField COMMENT = QueryField(fieldName: "comment");
  static final QueryField STARS = QueryField(fieldName: "stars");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Reviews";
    modelSchemaDefinition.pluralName = "Reviews";
    
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
      key: Reviews.USERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Reviews.BUSINESSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Reviews.COMMENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Reviews.STARS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
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

class _ReviewsModelType extends ModelType<Reviews> {
  const _ReviewsModelType();
  
  @override
  Reviews fromJson(Map<String, dynamic> jsonData) {
    return Reviews.fromJson(jsonData);
  }
}