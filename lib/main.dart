import 'package:flutter/material.dart';
import 'package:flutter_application_5/ui/home_page.dart';//importando um arquivo 
//nome do app/pasta/arquivo
import 'package:flutter_application_5/ui/gif_page.dart';
void main(){
  runApp(MaterialApp(
    //especificando a pag
    home: HomePage(),
    theme: ThemeData(hintColor: Colors.white), //definindo um tema 

  ));
}
