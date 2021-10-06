import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/usecase/errors/failures.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_implementation.dart';

import '../../mocks/date_mock.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  const tSpaceMediaModel = SpaceMediaModel(
    description: 'description',
    mediaType: 'mediaType',
    title: 'title',
    mediaUrl: 'mediaUrl',
  );

  test('Should return space media model when calls the datasource', () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(any()))
        .thenAnswer((_) async => tSpaceMediaModel);

    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);

    // Assert
    expect(result, const Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test(
      'Should return a server failure when the call to datasource is unsuccessful',
      () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(any()))
        .thenThrow(ServerException());

    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);

    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });
}
