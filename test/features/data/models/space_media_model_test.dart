import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';

import '../../../mocks/space_media_mock.dart';

main() {
  const tSpaceMediaModel = SpaceMediaModel(
    description:
        'Almost every object in the above photograph is a galaxy. The Coma Cluster of Galaxies pictured is one of the densest clusters known - it contains thousands of galaxies. Each of these galaxies house billions of stars - just as our own Milky Way Galaxy does. Although nearby when compared to most other clusters, light from the Coma Cluster still takes hundreds of millions of years to reach us.  In fact, the Coma Cluster is so big it takes light millions of years just to go from one side to the other!   Most galaxies in Coma and other clusters are ellipticals, while most galaxies outside of clusters are spirals. The nature of Coma\'s X-ray emission is still being investigated.',
    mediaType: 'image',
    title: 'The Coma Cluster of Galaxies',
    mediaUrl: 'https://apod.nasa.gov/apod/image/9903/coma_kpno.jpg',
  );

  test('Should be a subclass of SpaceMediaEntity', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('Should return a valid model', () {
    // Arrange
    final Map<String, dynamic> jsonMap = jsonDecode(spaceMediaMock);

    // Act
    final result = SpaceMediaModel.fromJson(jsonMap);

    // Assert
    expect(result, tSpaceMediaModel);
  });

  test('Should return a json map containing the proper data', () {
    // Arrange
    final expectMap = {
      "explanation":
          "Almost every object in the above photograph is a galaxy. The Coma Cluster of Galaxies pictured is one of the densest clusters known - it contains thousands of galaxies. Each of these galaxies house billions of stars - just as our own Milky Way Galaxy does. Although nearby when compared to most other clusters, light from the Coma Cluster still takes hundreds of millions of years to reach us.  In fact, the Coma Cluster is so big it takes light millions of years just to go from one side to the other!   Most galaxies in Coma and other clusters are ellipticals, while most galaxies outside of clusters are spirals. The nature of Coma's X-ray emission is still being investigated.",
      "media_type": "image",
      "title": "The Coma Cluster of Galaxies",
      "url": "https://apod.nasa.gov/apod/image/9903/coma_kpno.jpg",
    };

    // Act
    final result = tSpaceMediaModel.toJson();

    // Assert
    expect(result, expectMap);
  });
}
