//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateBikeDTO {
  /// Returns a new [UpdateBikeDTO] instance.
  UpdateBikeDTO({
    this.partNumber,
    this.description,
    this.sizeFrame,
    this.sizeWheel,
    this.isMTB,
    this.manufacturedDate,
  });

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

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateBikeDTO &&
    other.partNumber == partNumber &&
    other.description == description &&
    other.sizeFrame == sizeFrame &&
    other.sizeWheel == sizeWheel &&
    other.isMTB == isMTB &&
    other.manufacturedDate == manufacturedDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (partNumber == null ? 0 : partNumber!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (sizeFrame == null ? 0 : sizeFrame!.hashCode) +
    (sizeWheel == null ? 0 : sizeWheel!.hashCode) +
    (isMTB == null ? 0 : isMTB!.hashCode) +
    (manufacturedDate == null ? 0 : manufacturedDate!.hashCode);

  @override
  String toString() => 'UpdateBikeDTO[partNumber=$partNumber, description=$description, sizeFrame=$sizeFrame, sizeWheel=$sizeWheel, isMTB=$isMTB, manufacturedDate=$manufacturedDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
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
    return json;
  }

  /// Returns a new [UpdateBikeDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateBikeDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateBikeDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateBikeDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateBikeDTO(
        partNumber: mapValueOfType<String>(json, r'partNumber'),
        description: mapValueOfType<String>(json, r'description'),
        sizeFrame: mapValueOfType<double>(json, r'sizeFrame'),
        sizeWheel: mapValueOfType<double>(json, r'sizeWheel'),
        isMTB: mapValueOfType<bool>(json, r'isMTB'),
        manufacturedDate: mapDateTime(json, r'manufacturedDate', r''),
      );
    }
    return null;
  }

  static List<UpdateBikeDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateBikeDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateBikeDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateBikeDTO> mapFromJson(dynamic json) {
    final map = <String, UpdateBikeDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateBikeDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateBikeDTO-objects as value to a dart map
  static Map<String, List<UpdateBikeDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateBikeDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateBikeDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

