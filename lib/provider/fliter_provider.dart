import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Fliters {
  gultenFree,
  lactoseFree,
  vegeterian,
  vegan,
}

class FilterNotifer extends StateNotifier<Map<Fliters, bool>> {
  FilterNotifer()
      : super({
          Fliters.gultenFree: false,
          Fliters.lactoseFree: false,
          Fliters.vegeterian: false,
          Fliters.vegan: false,
        });

  void setFliter(Fliters fliter, bool isActive) {
    state = {
      ...state,
      fliter: isActive,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifer, Map<Fliters, bool>>((ref) {
  return FilterNotifer();
});
