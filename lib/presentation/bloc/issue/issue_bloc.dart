import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_apps_deall/data/repositories/remote/github_repository.dart';
import 'package:github_apps_deall/presentation/bloc/issue/bloc.dart';


class IssueBloc extends  Bloc<IssueEvent, IssueState> {
  final GithubRepository repository;
  
  IssueBloc({required this.repository}) : super(InitialIssueState()) {
    on<IssueFetchFromRemote>((event, emit) => _onEvent(event, emit));
  }

  FutureOr<void> _onEvent(IssueEvent event, Emitter<IssueState> state) async {
    if (event is IssueFetchFromRemote) {
      emit(IssueLoading());
      try {
        final response = await repository.getIssuesData(event.page, event.query);
        emit(IssueLoaded(response));
      } catch (e) {
        emit(IssueNotLoaded(e.toString()));
      }
    }
  }

}