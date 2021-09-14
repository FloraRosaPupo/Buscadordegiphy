import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {
  final Map _gifData; //dados do gif q eu selecionei

  GifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gifData["title"]), //pegar o titulo
        backgroundColor: Colors.black,
        actions: <Widget>[
          //botao de compartilhamento
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(_gifData["images"]["fixed_height"]["url"]); //compartilha o link da imagem
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData["images"]["fixed_height"]
            ["url"]), // colocando a imagem do gif
      ),
    );
  }
}
