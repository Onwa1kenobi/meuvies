import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meuvies/bloc/shows_bloc.dart';
import 'package:meuvies/util/extensions.dart';
import 'package:meuvies/util/values/colors.dart';
import 'package:meuvies/util/values/dimensions.dart';
import 'package:meuvies/util/values/routes.dart';
import 'package:meuvies/util/values/strings.dart';
import 'package:meuvies/util/values/styles.dart';
import 'package:meuvies/widgets/error_widget.dart';
import 'package:meuvies/widgets/loading.dart';
import 'package:meuvies/widgets/show_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchInputController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _showClearButton = false;
  String _lastSearchQuery = '';
  Timer? _debounce;

  @override
  void initState() {
    _searchFocusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.textDoubleMargin,
              vertical: AppDimensions.textMargin,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_sharp),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: AppStrings.searchShows,
                      hintStyle: AppTextStyle.bodyNormal.apply(
                        color: AppColors.lightGray,
                      ),
                      isDense: false,
                      filled: true,
                      fillColor: AppColors.lightBlack,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.textMargin,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: AppDimensions.buttonMargin * 2,
                      ),
                      suffixIcon: _showClearButton
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.grey,
                                size: AppDimensions.buttonMargin * 2,
                              ),
                              onPressed: () {
                                setState(() {
                                  _showClearButton = false;
                                  _searchInputController.clear();
                                });
                              },
                            )
                          : null,
                      contentPadding: EdgeInsets.zero,
                    ),
                    maxLines: 1,
                    minLines: 1,
                    style: AppTextStyle.bodyNormal.apply(color: AppColors.mainGray),
                    controller: _searchInputController,
                    focusNode: _searchFocusNode,
                    keyboardType: TextInputType.name,
                    onChanged: _onSearchChanged,
                    textInputAction: TextInputAction.search,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<ShowsBloc, ShowsState>(
          builder: (context, state) {
            if (state is ShowError) {
              return Center(
                child: ErrorDisplayWidget(
                  onRetry: () {
                    BlocProvider.of<ShowsBloc>(context).add(
                      SearchShows(_searchInputController.text.trim()),
                    );
                  },
                  message: state.message,
                ),
              );
            } else if (state is ShowsLoading) {
              return const CircularLoading();
            }

            final shows = BlocProvider.of<ShowsBloc>(context).showsSearchList;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 100 / 150,
                crossAxisSpacing: AppDimensions.textDoubleMargin,
                mainAxisSpacing: AppDimensions.textDoubleMargin,
                crossAxisCount: 2,
              ),
              itemBuilder: (ctx, index) {
                final show = shows[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.showDetails,
                      arguments: show,
                    );
                  },
                  child: ShowItem(
                    show: show,
                  ),
                );
              },
              itemCount: shows.length,
            );
          },
        ),
      ),
    );
  }

  void _onSearchChanged(String input) {
    setState(() {
      _showClearButton = _searchInputController.text.isNotNullOrEmpty();
    });
    if (input.trim().length < 2) return;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 750), () {
      if (_lastSearchQuery != _searchInputController.text.trim()) {
        _lastSearchQuery = _searchInputController.text.trim();
        BlocProvider.of<ShowsBloc>(context).add(
          SearchShows(_lastSearchQuery),
        );
      }
    });
  }

  @override
  void dispose() {
    _searchInputController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
