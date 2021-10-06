import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_clean_arch/core/http_client/http_implementation.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_converter.dart';
import 'package:nasa_clean_arch/features/data/datasources/nasa_datasource_implementation.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_implementation.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_arch/features/presenter/controllers/home_store.dart';
import 'package:nasa_clean_arch/features/presenter/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_clean_arch/features/presenter/pages/picture_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeStore(i.get())),
    Bind.lazySingleton((i) => GetSpaceMediaFromDateUsecase(i.get())),
    Bind.lazySingleton((i) => SpaceMediaRepositoryImplementation(i.get())),
    Bind.lazySingleton((i) =>
        NasaDatasourceImplementation(converter: i.get(), client: i.get())),
    Bind.lazySingleton((i) => HttpImplementation(i.get())),
    Bind.lazySingleton((i) => http.Client()),
    Bind.lazySingleton((i) => DateToStringConverter()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const HomePage()),
    ChildRoute('/picture', child: (_, __) => const PicturePage()),
  ];
}
