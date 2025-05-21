import 'dart:async';

import 'package:device_apps/device_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>(
  (final ref) => SearchNotifier(),
);

class SearchState {
  const SearchState({
    this.filteredApps = const [],
    this.isSearchEnabled = false,
    this.noResults = false,
  });

  final List<Application> filteredApps;
  final bool isSearchEnabled;
  final bool noResults;

  SearchState copyWith({
    final List<Application>? filteredApps,
    final bool? isSearchEnabled,
    final bool? noResults,
  }) => SearchState(
    filteredApps: filteredApps ?? this.filteredApps,
    isSearchEnabled: isSearchEnabled ?? this.isSearchEnabled,
    noResults: noResults ?? this.noResults,
  );
}

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(const SearchState());

  Timer? _searchDebounce;

  void updateSearch(final String query, final List<Application> apps) {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      final trimmedQuery = query.trim().toLowerCase();

      final results =
          apps
              .where(
                (final app) => app.appName.toLowerCase().contains(trimmedQuery),
              )
              .toList();

      state = state.copyWith(
        filteredApps: results,
        noResults: results.isEmpty && trimmedQuery.isNotEmpty,
      );
    });
  }

  void handleSearchToggle(final bool searchEnabled) {
    searchEnabled ? clearSearch() : enableSearch();
  }

  void enableSearch() {
    state = state.copyWith(isSearchEnabled: true);
  }

  void clearSearch() {
    _searchDebounce?.cancel();
    state = const SearchState();
  }
}
