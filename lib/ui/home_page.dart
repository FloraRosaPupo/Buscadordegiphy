import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

import 'gif_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search; //pesquisa

  int _offset = 0; //procurando outros gifs

  //requisiçao dos gifs
  Future<Map> _getGifs() async {
    http.Response response;

    if (_search == null) {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=wKadgpFiGSpORrJXEdxcV4CSXZ9BQvO1&limit=19&rating=g"); //melhores gifs
    } else {
      response = await http.get(
          //gifs pesquisados
          "https://api.giphy.com/v1/gifs/search?api_key=wKadgpFiGSpORrJXEdxcV4CSXZ9BQvO1&q=$_search&limit=19&offset=$_offset&rating=g&lang=pt");
    }

    return json.decode(response.body);

    @override
    void initState() {
      super.initState();

      _getGifs().then((map) {
        print(map);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/static/img/dev-logo-lg.gif"), //colocando uma imagem
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
                });
              }, //recebe o texto q ta no pesquise aqui
            ),
          ),
          Expanded(
              child: FutureBuilder(
            //carregando os dados
            future: _getGifs(),

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
                    return Container();
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
              image:  snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 300.0, //altura
              fit: BoxFit.cover,
            ),
            onTap: () {
              //trocando de tela
              Navigator.push(
                  context,
                  /*rota */
                  MaterialPageRoute(builder: (context) => GifPage(snapshot.data["data"][index]))
                );
            },
            onLongPress: (){
              Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);//ao precisar no gif ele compartilhar
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
                  _offset += 19; //pegar os proximos 19 itens
                });
              },
            ),
          );
        }
      },
    );
  }
}
