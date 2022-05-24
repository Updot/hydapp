// ignore_for_file: unnecessary_lambdas

import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../amenity_detail_model.dart';
import '../amenity_model.dart';
import '../data_models/search_result_data_model.dart';
import '../recent_model.dart';
import '../suggestion.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse<T> extends Equatable {
  ApiResponse(
    this.status,
    this.data,
  );

  @JsonKey(name: 'status')
  final int status;

  @JsonKey(name: 'data', includeIfNull: false, nullable: true)
  @_Converter()
  final T data;

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  @override
  List<Object> get props => [data as List<Object>];
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    switch (T) {
      case SearchResultDataModel:
        return SearchResultDataModel.fromJson(json as Map<String, dynamic>)
            as T;
      case AmenityDetailModel:
        return AmenityDetailModel.fromJson(json as Map<String, dynamic>) as T;
      default:
        break;
    }
    if (json is List) {
      if (T.toString() == <AmenityInfo>[].runtimeType.toString() ||
          T.toString() == 'List<AmenityInfo>') {
        return json.map((v) => AmenityInfo.fromJson(v)).toList() as T ??
            [] as T;
      } else if (T.toString() == <AmenityModel>[].runtimeType.toString() ||
          T.toString() == 'List<AmenityModel>') {
        return json.map((v) => AmenityModel.fromJson(v)).toList() as T ??
            [] as T;
      } else if (T.toString() == <RecentModel>[].runtimeType.toString() ||
          T.toString() == 'List<RecentModel>') {
        return json.map((v) => RecentModel.fromJson(v)).toList() as T ??
            [] as T;
      }
    }

    return json as T;
  }

  @override
  Object toJson(T object) {
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return object!;
  }
}
