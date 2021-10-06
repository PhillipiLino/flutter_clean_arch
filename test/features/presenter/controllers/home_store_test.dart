import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/usecase/errors/failures.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_arch/features/presenter/controllers/home_store.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockGetSpaceMediaFromDateUsecase extends Mock
    implements GetSpaceMediaFromDateUsecase {}

main() {
  late HomeStore store;
  late GetSpaceMediaFromDateUsecase usecase;

  setUp(() {
    usecase = MockGetSpaceMediaFromDateUsecase();
    store = HomeStore(usecase);
  });

  final tFailure = ServerFailure();

  test('Should return SpaceMedia from the usecase', () async {
    // Arrange
    when(() => usecase(any()))
        .thenAnswer((_) async => const Right(tSpaceMedia));

    // Act
    await store.getSpaceMediaFromDate(tDate);

    // Assert
    store.observer(onState: (state) {
      expect(state, tSpaceMedia);
      verify(() => usecase(tDate)).called(1);
    });
  });

  test('Should return a failure from the usecase when there is an error',
      () async {
    // Arrange
    when(() => usecase(any())).thenAnswer((_) async => Left(tFailure));

    // Act
    await store.getSpaceMediaFromDate(tDate);

    // Assert
    store.observer(onError: (error) {
      expect(error, tFailure);
      verify(() => usecase(tDate)).called(1);
    });
  });
}
