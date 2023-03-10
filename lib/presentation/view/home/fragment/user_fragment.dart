

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_apps_deall/data/models/body/user_body.dart';
import 'package:github_apps_deall/inject_container.dart';
import 'package:github_apps_deall/presentation/bloc/display/change_display.dart';
import 'package:github_apps_deall/presentation/bloc/paginate/paginate_event.dart';
import 'package:github_apps_deall/presentation/bloc/search/search_bloc.dart';
import 'package:github_apps_deall/presentation/bloc/user/bloc.dart';
import 'package:github_apps_deall/presentation/view/home/component/paginate.dart';
import 'package:github_apps_deall/presentation/view/home/component/user_component.dart';
import 'package:github_apps_deall/utils/empty_view.dart';
import 'package:github_apps_deall/utils/helpers.dart';
import 'package:github_apps_deall/utils/loading_indicator.dart';

class UserFragment extends StatefulWidget {
  const UserFragment({Key? key}) : super(key: key);

  @override
  _UserFragmentState createState() => _UserFragmentState();
}

class _UserFragmentState extends State<UserFragment> {
  late SearchBloc searchBloc;
  late ChangeDisplay changeDisplay;

  List<UserBody> items = [];
  List<UserBody> itemsDisplay = [];

  int page = 1;
  int limit = 10;

  int lastPage = 0;
  String search = "";


  @override
  void initState() {
    searchBloc = inject<SearchBloc>();
    changeDisplay = inject<ChangeDisplay>();
    if (searchBloc.state.isNotEmpty) {
      page = 1;
      getFetch(page, searchBloc.state);
    }

    eventBus.on<PaginateEventBus>().listen((event) {
      if (event.index == 0) {
        page++;
        getFetch(page, search);
      }
    });

    eventBus.on<RefreshEventBus>().listen((event) {
      if (event.index == 0) {
        items.clear();
        itemsDisplay.clear();
        page = 1;
        getFetch(page, search);
      }
    });

    searchBloc.stream.listen((searchData) {
      if (mounted) {
        page = 1;
        items.clear();
        itemsDisplay.clear();
        search = searchData;
        getFetch(page, search);
      }
    });

    changeDisplay.stream.listen((state) {
      if (mounted) {
        setState(() {
          itemsDisplay.clear();
          if (state == DisplayState.indexState) {
            itemsDisplay.addAll(items.sublist((page - 1) * limit, page * limit));
          } else {
            itemsDisplay.addAll(items);
          }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<UserBloc, UserState>(
          bloc: inject<UserBloc>(),
          listener: (context, state) {
            if (state is UserLoaded) {
              setState(() {
                lastPage =  (state.userBody.total_count! / limit).ceil();
                itemsDisplay.clear();

                items.addAll(state.userBody.items!);

                if (changeDisplay.state == DisplayState.loadingState) {
                  itemsDisplay.addAll(items);
                } else {
                  itemsDisplay.addAll(items.sublist((page - 1) * limit, page * limit));
                }
              });
            }

            if (state is UserNotLoaded) {
              Helpers.showSnackBar(
                  context,
                  snackBarMode: SnackBarMode.ERROR,
                  content: state.error
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                if (itemsDisplay.isNotEmpty) ...[
                  ListView.builder(
                    itemCount: itemsDisplay.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return UserComponent(
                        data: itemsDisplay[index],
                      );
                    },
                  ),
                ] else ...[
                  const EmptyView(),
                ],


                if (state is UserLoading) ... [
                  const SizedBox(height: 16,),
                  FadeIn(
                    child: const LoadingIndicator(),
                  ),
                ]
              ],
            );
          },
        ),
        BlocBuilder(
          bloc: changeDisplay,
          builder: (context, state) {
            if (state == DisplayState.indexState) {
              return Column(
                children: [
                  const SizedBox(height: 16,),
                  if (itemsDisplay.isNotEmpty) ...[
                    PaginateCustom(
                      page: page,
                      lastPage: lastPage,
                      onTap: (index) {
                        setState(() {
                          page = index;
                          getFetch(page, searchBloc.state);
                        });
                      },
                    )
                  ]
                ],
              );
            }

            return Container();
          },
        ),
      ],
    );
  }

  void getFetch(int offset, String search) {
    if (mounted) {
      inject<UserBloc>().add(UserFetchFromRemote(page: offset, query: search));
    }
  }
}

