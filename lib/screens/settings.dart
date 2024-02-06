import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_movies/theme/theme_state.dart';
import 'package:flutter_movies/login.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? option;
  final List<Color> colors = [Colors.white, Color(0xff242248), Colors.black];
  final List<Color> borders = [Colors.black, Colors.white, Colors.white];
  final List<String> themes = ['Claro', 'Oscuro'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);
    return Theme(
        data: state.themeData,
        child: Container(
          color: state.themeData.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAvatar(
                              backgroundColor: state.themeData.colorScheme
                                  .secondary,
                              radius: 40,
                              child: Icon(
                                Icons.person_outline,
                                size: 40,
                                color: state.themeData.primaryColor,
                              )),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            _salir(context);
                          },
                          label: Text(
                            'Salir',
                            style: TextStyle(fontSize: 25, color: state.themeData.brightness == Brightness.light ? Colors.black : Colors.white),
                          ),
                          icon: Icon(
                            Icons.logout,
                            color: state.themeData.brightness == Brightness.light ? Colors.black : Colors.white,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Temas',
                      style: state.themeData.textTheme.bodyText1,
                    ),
                  ],
                ),
                subtitle: SizedBox(
                  height: 100,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2, color: borders[index]),
                                        color: colors[index]),
                                  ),
                                ),
                                Text(themes[index],
                                    style: state.themeData.textTheme.bodyText1)
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        switch (index) {
                                          case 0:
                                            state.saveOptionValue(
                                                ThemeStateEnum.light);
                                            break;
                                          case 1:
                                            state.saveOptionValue(
                                                ThemeStateEnum.dark);
                                            break;
                                        //case 2:
                                        //  state.saveOptionValue(
                                        //      ThemeStateEnum.amoled);
                                        //  break;
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: state.themeData.primaryColor ==
                                          colors[index]
                                          ? Icon(Icons.done,
                                          color:
                                          state.themeData.colorScheme.secondary)
                                          : Container(),
                                    ),
                                  ),
                                ),
                                Text(themes[index],
                                    style: state.themeData.textTheme.bodyText1)
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
void _salir(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MainPage()), // Reemplaza LoginPage con el nombre correcto de tu clase de inicio de sesión
  );
}
