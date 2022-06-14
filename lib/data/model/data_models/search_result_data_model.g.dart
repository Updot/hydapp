// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultDataModel _$SearchResultDataModelFromJson(
    Map<String, dynamic> json) {
  final eventList = json['events'] as List;
  final amenitiesList = json['amenities'] as List;
  final eventListModel = eventList.map((e) => EventInfo.fromJson(e)).toList();
  final amentiesListModel = amenitiesList.map((e) {
    print(e);
    return PlaceModel.fromJson(e);
  }).toList();
  print(amenitiesList);
  return SearchResultDataModel(
      events: eventListModel, amenities: amentiesListModel);
}

Map<String, dynamic> _$SearchResultDataModelToJson(
        SearchResultDataModel instance) =>
    <String, dynamic>{
      'events': instance.events,
      'amenities': instance.amenities,
    };
