import 'package:flutter_riverpod/flutter_riverpod.dart';

final longPressProvider = StateProvider<bool>((final ref) => false);

final selectedItemsProvider = StateProvider<List<int>>((final ref) => []);

void toggleSelectedIndex(final WidgetRef ref, final int index) {
  final selectedList = [...ref.read(selectedItemsProvider)];
  final selectedNotifier = ref.read(selectedItemsProvider.notifier);
  final longPressNotifier = ref.read(longPressProvider.notifier);

  selectedList.contains(index)
      ? selectedList.remove(index)
      : selectedList.add(index);

  selectedNotifier.state = selectedList;

  if (selectedList.isEmpty) {
    longPressNotifier.state = false;
  }
}

void resetSelection(final WidgetRef ref) {
  ref.read(selectedItemsProvider.notifier).state = [];
  ref.read(longPressProvider.notifier).state = false;
}
