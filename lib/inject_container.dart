
import 'package:get_it/get_it.dart';
import 'package:github_apps_deall/data/repositories/remote/dio_client.dart';
import 'package:github_apps_deall/data/repositories/remote/github_repository.dart';
import 'package:github_apps_deall/presentation/bloc/display/change_display.dart';
import 'package:github_apps_deall/presentation/bloc/issue/issue_bloc.dart';
import 'package:github_apps_deall/presentation/bloc/repositories/repositories_bloc.dart';
import 'package:github_apps_deall/presentation/bloc/search/search_bloc.dart';
import 'package:github_apps_deall/presentation/bloc/tabbar/tab_bar_cubit.dart';
import 'package:github_apps_deall/presentation/bloc/user/user_bloc.dart';

final inject = GetIt.instance;

Future<void> init(String baseUrl) async {
  //BLOC
  inject.registerLazySingleton(() => TabBarCubit());
  inject.registerLazySingleton(() => UserBloc(repository: inject()));
  inject.registerLazySingleton(() => RepositoriesBloc(repository: inject()));
  inject.registerLazySingleton(() => IssueBloc(repository: inject()));
  inject.registerLazySingleton(() => ChangeDisplay());
  inject.registerLazySingleton(() => SearchBloc());

  //Remote
  inject.registerLazySingleton(() => DioClient(baseUrl));
  inject.registerLazySingleton(() => inject<DioClient>().dio);
  inject.registerLazySingleton(() => GithubRepository(inject()));
}