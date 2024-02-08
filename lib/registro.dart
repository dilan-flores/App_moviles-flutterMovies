import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_movies/login.dart';
import 'package:flutter_movies/auxiliar.dart';


class PaginaRegistro extends StatefulWidget {
  const PaginaRegistro({super.key});

  @override
  PaginaRegistroState createState() => PaginaRegistroState();
}

class PaginaRegistroState extends State<PaginaRegistro> {
  bool _contrasenaVisible1 = false;
  bool _contrasenaVisible2 = false;
  static bool visible = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    visible = false;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  //TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController1 = TextEditingController();
  final TextEditingController _contrasenaController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      body: Container(
        child: Scaffold(
          backgroundColor: Colors.lightBlue[900],
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 150.0, bottom: 50),
                    child: const Text('Nuevo usuario',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 20, bottom: 0),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail_outline_rounded,
                            color: Colors.white70,
                          ),
                          filled: true,
                          fillColor: Colors.black12,
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white54),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 1.5),
                          ),
                          labelText: 'Email',
                          hintText: 'Email'),
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10, bottom: 0),
                    //  padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: _usuarioController,
                      keyboardType: TextInputType.name,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.white70,
                          ),
                          filled: true,
                          fillColor: Colors.black12,
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white54),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 1.5),
                          ),
                          labelText: 'Nombre',
                          hintText: 'Nombre'),
                    ),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 0.0),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _contrasenaController1,
                      obscureText: !_contrasenaVisible1,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: Colors.white70,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(
                                // Según el valor de passwordVisible se elige el icono
                                _contrasenaVisible1 ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _contrasenaVisible1 = !_contrasenaVisible1;
                                });
                              }),
                          filled: true,
                          fillColor: Colors.black12,
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          hintStyle: const TextStyle(color: Colors.white54),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                            BorderSide(color: Colors.white, width: 0.5),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                            BorderSide(color: Colors.white, width: 1.5),
                          ),

                          labelText: 'Contraseña',
                          hintText: 'Contraseña'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 40.0),
                    child: TextFormField(
                      controller: _contrasenaController2,
                      obscureText: !_contrasenaVisible2,
                      keyboardType: TextInputType.visiblePassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: Colors.white70,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(
                                _contrasenaVisible2 ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _contrasenaVisible2 = !_contrasenaVisible2;
                                });
                              }),
                          filled: true,
                          fillColor: Colors.black12,
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          hintStyle: const TextStyle(color: Colors.white54),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                            BorderSide(color: Colors.white, width: 0.5),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                            BorderSide(color: Colors.white, width: 1.5),
                          ),
                          labelText: 'Repite contraseña',
                          hintText: 'Repite contraseña'),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_emailController.text.contains('@')) {
                          mostrarSnackBar('Introduzca un email correcto', context);
                        }/* else if (_usuarioController.text.isEmpty) {
                          mostrarSnackBar('Introduzca su nombre', context);
                        }*/ else if (_contrasenaController1.text.length < 6) {
                          mostrarSnackBar(
                              'La contraseña debe tener al menos 6 caracteres',
                              context);
                        } else if (_contrasenaController1.text !=
                            _contrasenaController2.text) {
                          mostrarSnackBar(
                              'Las contraseñas no coinciden', context);
                        } else {
                          setState(() {
                            cambiarVisibilidadIndicadorProgreso();
                          });
                          registroNuevoUsuario(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.black45,
                        shadowColor: Colors.black45,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                            color: Colors.white70,
                            width: 2,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: visible,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: Container(
                            width: 290,
                            margin: const EdgeInsets.only(),
                            child: LinearProgressIndicator(
                              minHeight: 2,
                              backgroundColor: Colors.blueGrey[800],
                              valueColor: const AlwaysStoppedAnimation(Colors.white),
                            ))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _contrasenaController1.dispose();
    _contrasenaController2.dispose();
    //_usuarioController.dispose();
    super.dispose();
  }


  Future<void> registroNuevoUsuario(BuildContext context) async {
    User usuario;
    try {
      usuario = (await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _contrasenaController1.text.trim())).user!;
      mostrarSnackBar("Usuario creado correctamente",context);
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MainPage()));

    } on FirebaseAuthException catch(e) {
      if (e.code == "weak-password") {
        mostrarSnackBar("Contraseña demasidado débil",context);
      } else if (e.code == "email-already-in-use")
        mostrarSnackBar("Ese usuario ya existe",context);
      else
        mostrarSnackBar("Lo sentimos, hubo un error",context);
    } catch(e) {
      mostrarSnackBar("Lo sentimos, hubo un error",context);
    }
    finally {
      setState((){
        cambiarVisibilidadIndicadorProgreso();
      });
    }
  }

  void cambiarVisibilidadIndicadorProgreso() {
    visible = !visible;
  }


}