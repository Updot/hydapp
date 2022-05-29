import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'lat')
  final String? lat;
  @JsonKey(name: 'long')
  final String long;
  @JsonKey(name: 'location_at')
  final String? locationAt;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'title')
  final String? title;

  LocationModel({
    required this.id,
    required this.locationAt,
    required this.lat,
    required this.long,
    required this.address,
    required this.title,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  @override
  List<Object> get props => [id, lat??'', long, locationAt??'', address ?? '', title ?? ''];
}

enum TravelMode { driving, walking, bicycling, transit }
