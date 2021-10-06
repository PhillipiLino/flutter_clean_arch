import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/http_client/http_client.dart';
import 'package:nasa_clean_arch/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_converter.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/datasources/nasa_datasource_implementation.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_mock.dart';

class MockHttpClient extends Mock implements HttpClient {}

main() {
  late DateToStringConverter converter;
  late ISpaceMediaDatasource datasource;
  late HttpClient client;

  setUp(() {
    client = MockHttpClient();
    converter = DateToStringConverter();
    datasource =
        NasaDatasourceImplementation(converter: converter, client: client);
  });

  const urlExpected =
      'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-02-02';

  void successMock() {
    when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(data: spaceMediaMock, statusCode: 200));
  }

  test('Should call the get method with correct url', () async {
    // Arrange
    successMock();

    // Act
    await datasource.getSpaceMediaFromDate(tDate);

    // Assert
    verify(() => client.get(urlExpected)).called(1);
  });

  test('Should return a SpaceMediaModel when is successful', () async {
    // Arrange
    successMock();
    const tSpaceMediaModelExpected = SpaceMediaModel(
      description:
          'Almost every object in the above photograph is a galaxy. The Coma Cluster of Galaxies pictured is one of the densest clusters known - it contains thousands of galaxies. Each of these galaxies house billions of stars - just as our own Milky Way Galaxy does. Although nearby when compared to most other clusters, light from the Coma Cluster still takes hundreds of millions of years to reach us.  In fact, the Coma Cluster is so big it takes light millions of years just to go from one side to the other!   Most galaxies in Coma and other clusters are ellipticals, while most galaxies outside of clusters are spirals. The nature of Coma\'s X-ray emission is still being investigated.',
      mediaType: 'image',
      title: 'The Coma Cluster of Galaxies',
      mediaUrl: 'https://apod.nasa.gov/apod/image/9903/coma_kpno.jpg',
    );

    // Act
    final result = await datasource.getSpaceMediaFromDate(tDate);

    // Assert
    expect(result, tSpaceMediaModelExpected);
  });

  test('Should throw a ServerException when the call is unccessful', () async {
    // Arrange
    when(() => client.get(any())).thenAnswer((_) async =>
        HttpResponse(data: 'something went wrong', statusCode: 400));

    // Act
    final result = datasource.getSpaceMediaFromDate(tDate);

    // Assert
    expect(() => result, throwsA(ServerException()));
  });
}
