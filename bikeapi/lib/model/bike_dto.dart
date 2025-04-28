//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BikeDTO {
  /// Returns a new [BikeDTO] instance.
  BikeDTO({
    this.id,
    this.partNumber,
    this.description,
    this.sizeFrame,
    this.sizeWheel,
    this.isMTB,
    this.manufacturedDate,
    this.createdDate,
  });

  /// Chave do registro da bike
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  /// Código do modelo da bike
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? partNumber;

  /// Descrição do modelo da bike
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  /// Tamanho do quadro da bike
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? sizeFrame;

  /// Tamanho da roda da bike
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? sizeWheel;

  /// O modelo é Mountain-Bike?
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isMTB;

  /// Data de fabricação do modelo da bike
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? manufacturedDate;

  /// Data de criação do registro
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BikeDTO &&
    other.id == id &&
    other.partNumber == partNumber &&
    other.description == description &&
    other.sizeFrame == sizeFrame &&
    other.sizeWheel == sizeWheel &&
    other.isMTB == isMTB &&
    other.manufacturedDate == manufacturedDate &&
    other.createdDate == createdDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (partNumber == null ? 0 : partNumber!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (sizeFrame == null ? 0 : sizeFrame!.hashCode) +
    (sizeWheel == null ? 0 : sizeWheel!.hashCode) +
    (isMTB == null ? 0 : isMTB!.hashCode) +
    (manufacturedDate == null ? 0 : manufacturedDate!.hashCode) +
    (createdDate == null ? 0 : createdDate!.hashCode);

  @override
  String toString() => 'BikeDTO[id=$id, partNumber=$partNumber, description=$description, sizeFrame=$sizeFrame, sizeWheel=$sizeWheel, isMTB=$isMTB, manufacturedDate=$manufacturedDate, createdDate=$createdDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.partNumber != null) {
      json[r'partNumber'] = this.partNumber;
    } else {
      json[r'partNumber'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.sizeFrame != null) {
      json[r'sizeFrame'] = this.sizeFrame;
    } else {
      json[r'sizeFrame'] = null;
    }
    if (this.sizeWheel != null) {
      json[r'sizeWheel'] = this.sizeWheel;
    } else {
      json[r'sizeWheel'] = null;
    }
    if (this.isMTB != null) {
      json[r'isMTB'] = this.isMTB;
    } else {
      json[r'isMTB'] = null;
    }
    if (this.manufacturedDate != null) {
      json[r'manufacturedDate'] = _dateFormatter.format(this.manufacturedDate!.toUtc());
    } else {
      json[r'manufacturedDate'] = null;
    }
    if (this.createdDate != null) {
      json[r'createdDate'] = _dateFormatter.format(this.createdDate!.toUtc());
    } else {
      json[r'createdDate'] = null;
    }
    return json;
  }

  /// Returns a new [BikeDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BikeDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BikeDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BikeDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BikeDTO(
        id: mapValueOfType<int>(json, r'id'),
        partNumber: mapValueOfType<String>(json, r'partNumber'),
        description: mapValueOfType<String>(json, r'description'),
        sizeFrame: mapValueOfType<double>(json, r'sizeFrame'),
        sizeWheel: mapValueOfType<double>(json, r'sizeWheel'),
        isMTB: mapValueOfType<bool>(json, r'isMTB'),
        manufacturedDate: mapDateTime(json, r'manufacturedDate', r''),
        createdDate: mapDateTime(json, r'createdDate', r''),
      );
    }
    return null;
  }

  static List<BikeDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BikeDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BikeDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BikeDTO> mapFromJson(dynamic json) {
    final map = <String, BikeDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BikeDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BikeDTO-objects as value to a dart map
  static Map<String, List<BikeDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BikeDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BikeDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

