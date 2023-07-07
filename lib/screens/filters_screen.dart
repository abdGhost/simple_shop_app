import 'package:flutter/material.dart';
import 'package:shop_app/screens/tabs_screen.dart';
import 'package:shop_app/widgets/main_drawer_widget.dart';

enum Fliters {
  gultenFree,
  lactoseFree,
  vegeterian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFlits,
  });

  final Map<Fliters, bool> currentFlits;

  @override
  State<StatefulWidget> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _gultenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegterianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _gultenFreeFilterSet = widget.currentFlits[Fliters.gultenFree]!;
    _lactoseFreeFilterSet = widget.currentFlits[Fliters.lactoseFree]!;
    _vegterianFilterSet = widget.currentFlits[Fliters.vegeterian]!;
    _veganFilterSet = widget.currentFlits[Fliters.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop({
          Fliters.gultenFree: _gultenFreeFilterSet,
          Fliters.lactoseFree: _lactoseFreeFilterSet,
          Fliters.vegeterian: _vegterianFilterSet,
          Fliters.vegan: _veganFilterSet,
        });
        return false;
      },
      child: Scaffold(
        // drawer: MainDrawerWidget(
        //   onSelectScreen: (identifier) {
        //     Navigator.of(context).pop();
        //     if (identifier == 'meals') {
        //       Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(
        //           builder: (ctx) => const TabsScreen(),
        //         ),
        //       );
        //     }
        //   },
        // ),
        appBar: AppBar(
          title: const Text("Filter"),
        ),
        body: Column(
          children: [
            SwitchListTile(
              value: _gultenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _gultenFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Gluten-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'This meals are gluten free',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 33,
                right: 22,
              ),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Lactose-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'This meals are Lactose free',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 33,
                right: 22,
              ),
            ),
            SwitchListTile(
              value: _vegterianFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegterianFilterSet = isChecked;
                });
              },
              title: Text(
                'Vegterian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'This are Vegterian Meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 33,
                right: 22,
              ),
            ),
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
              title: Text(
                'Vegans',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'This are Vegans Meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 33,
                right: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}
