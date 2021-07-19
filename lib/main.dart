import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/services/shared_preferences_service.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesServiceProvider.overrideWithValue(
        SharedPreferencesService(sharedPreferences),
      ),
    ],
    child: const WeddingApp(),
  ));
}

class WeddingApp extends StatefulWidget {
  const WeddingApp({Key? key}) : super(key: key);
  @override
  _WeddingAppState createState() => _WeddingAppState();
}

class _WeddingAppState extends State<WeddingApp> {
  var theme = ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Wedding App!';
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: theme,
        builder: (context, value, child) => MaterialApp(
              title: appTitle,
              home: MyHomePage(theme: theme),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.blue,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: Colors.lightBlue[900],
              ),
              themeMode: value,
            ));
  }
}

class MyHomePage extends StatefulWidget {
  final ValueNotifier<ThemeMode> theme;
  const MyHomePage({required this.theme});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isDialOpen = ValueNotifier<bool>(false);
  var selectedfABLocation = FloatingActionButtonLocation.endFloat;
  // FloatingActionButtonLocation.startFloat,
  // FloatingActionButtonLocation.startDocked,
  // FloatingActionButtonLocation.centerFloat,
  // FloatingActionButtonLocation.endFloat,
  // FloatingActionButtonLocation.endDocked,
  // FloatingActionButtonLocation.startTop,
  // FloatingActionButtonLocation.centerTop,
  // FloatingActionButtonLocation.endTop,
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Wedding App!'),
        // ),
        floatingActionButtonLocation: selectedfABLocation,
        floatingActionButton: SpeedDial(
          // animatedIcon: AnimatedIcons.menu_close,
          // animatedIconTheme: IconThemeData(size: 22.0),
          // / This is ignored if animatedIcon is non null
          // child: Text("open"),
          // activeChild: Text("close"),
          icon: Icons.menu,
          activeIcon: Icons.close,
          spacing: 3,
          openCloseDial: isDialOpen,
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,
          buttonSize: 56, // it's the SpeedDial size which defaults to 56 itself
          // iconTheme: IconThemeData(size: 22),
          label: const Text('Menu'), // The label of the main button.
          /// The active label of the main button, Defaults to label if not specified.
          activeLabel: null,

          /// Transition Builder between label and activeLabel, defaults to FadeTransition.
          // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
          /// The below button size defaults to 56 itself, its the SpeedDial childrens size
          childrenButtonSize: 56.0,
          visible: true,
          direction: SpeedDialDirection.Up,
          switchLabelPosition: false,

          /// If true user is forced to close dial manually
          closeManually: false,

          /// If false, backgroundOverlay will not be rendered.
          renderOverlay: true,
          // overlayColor: Colors.black,
          // overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          useRotationAnimation: true,
          tooltip: 'Open Menu',
          heroTag: 'speed-dial-hero-tag',
          // foregroundColor: Colors.black,
          // backgroundColor: Colors.white,
          // activeForegroundColor: Colors.red,
          // activeBackgroundColor: Colors.blue,
          elevation: 8.0,
          isOpenOnStart: false,
          animationSpeed: 200,
          shape: const StadiumBorder(),
          // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          children: [
            SpeedDialChild(
              child: const Icon(Icons.accessibility),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'First',
              onTap: () => print('FIRST CHILD'),
            ),
            SpeedDialChild(
              child: const Icon(Icons.brush),
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              label: 'Second',
              onTap: () => print('SECOND CHILD'),
            ),
            SpeedDialChild(
              child: const Icon(Icons.margin),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              label: 'Show Snackbar',
              visible: true,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(('Third Child Pressed')))),
              onLongPress: () => print('THIRD CHILD LONG PRESS'),
            ),
          ],
        ),
      ),
    );
  }
}
