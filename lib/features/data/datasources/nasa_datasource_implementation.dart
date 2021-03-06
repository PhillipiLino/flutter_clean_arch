import 'dart:convert';

import 'package:nasa_clean_arch/core/http_client/http_client.dart';
import 'package:nasa_clean_arch/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_converter.dart';
import 'package:nasa_clean_arch/core/utils/keys/nasa_api_keys.dart';
import 'package:nasa_clean_arch/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

import 'space_media_datasource.dart';

class NasaDatasourceImplementation implements ISpaceMediaDatasource {
  final HttpClient client;
  final DateToStringConverter converter;

  NasaDatasourceImplementation({
    required this.converter,
    required this.client,
  });

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(
      NasaEndpoints.apod(
        NasaApiKeys.apiKey,
        DateToStringConverter.convert(date),
      ),
    );

    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    }

    throw ServerException();
  }
}
