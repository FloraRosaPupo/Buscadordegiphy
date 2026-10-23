import '../data/gif_repository.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

import 'gif_page.dart';

class HomePage extends StatefulWidget {
  final GifRepository? repository;
  const HomePage({super.key, this.repository});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _search; //pesquisa

  late Future<Map> _gifs;

  @override
  void initState() {
    super.initState();
    _gifs = _getGifs();
  }

  int _offset = 0; //procurando outros gifs

  late final GifRepository _repository = widget.repository ?? GifRepository();

  Future<Map> _getGifs() => _repository.fetch(search: _search, offset: _offset);

  @override
  void dispose() {
    if (widget.repository == null) _repository.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/static/img/dev-logo-lg.gif",
            errorBuilder: (context, error, stack) =>
                const Text("GIPHY")), //colocando uma imagem
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Pesquise Aqui",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder() //colocando uma borda
                  ),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _offset = 0;
                  _gifs = _getGifs();
                });
              }, //recebe o texto q ta no pesquise aqui
            ),
          ),
          Expanded(
              child: FutureBuilder(
            //carregando os dados
            future: _gifs,

            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                //caso ele esteja esperando
                case ConnectionState.waiting: //caso esteja carregando
                case ConnectionState.none: //caso nao tenha os dados
                  return Container(
                    width: 200.0, //largura
                    height: 200.0, //altura
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      //indicar uma cor na minha animaçao (parada)
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white), //circulo girando
                      strokeWidth: 5.0,
                    ),
                  );
                default:
                  if (snapshot.hasError)
                    return const Center(
                        child: Text('Não foi possível carregar os GIFs.',
                            style: TextStyle(color: Colors.white)));
                  else
                    return _createGifTable(context, snapshot);
              }
            },
          ))
        ],
      ),
    );
  }

  //quantidade de intens
  int _getCount(List data) {
    if (_search == null) {
      return data.length;
    } else {
      return data.length + 1; //+1 pra colocar o botao de mais icones
    }
  }

  //criando a tabela de gif
  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    //formato de grade
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //quantos itens vai poder ter na horizontal
        crossAxisCount: 2,
        //espacamento entre as grades na horizontal
        crossAxisSpacing: 10.0,
        //espacamento na vertical
        mainAxisSpacing: 10.0,
      ), //mostrar como intens vao ser organizados
      itemCount: _getCount(snapshot.data["data"]), //quantidade de gifs na tela

      //funçao q retona um widget
      itemBuilder: (context, index) {
        //se nao tiver pesquisando ou se tiver pesquisando e nao for o ultimo item
        if (_search == null || index < snapshot.data["data"].length) {
          return GestureDetector(
            //poder clicar na imagem
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage, //image transparente
              image: snapshot.data["data"][index]["images"]["fixed_height"]
                  ["url"],
              height: 300.0, //altura
              fit: BoxFit.cover,
            ),
            onTap: () {
              //trocando de tela
              Navigator.push(
                  context,
                  /*rota */
                  MaterialPageRoute(
                      builder: (context) =>
                          GifPage(snapshot.data["data"][index])));
            },
            onLongPress: () {
              Share.share(snapshot.data["data"][index]["images"]["fixed_height"]
                  ["url"]); //ao precisar no gif ele compartilhar
            },
          );
        } else {
          //intem para carregar mais
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 70.0,
                  ),
                  Text(
                    "Carregar mais..",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  _offset += 19;
                  _gifs = _getGifs(); //pegar os proximos 19 itens
                });
              },
            ),
          );
        }
      },
    );
  }
}
