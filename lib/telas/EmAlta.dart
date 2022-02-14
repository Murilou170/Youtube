import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class EmAlta extends StatefulWidget {

  String pesquisa;

  EmAlta( this.pesquisa );

  @override
  _EmAlta createState() => _EmAlta();
}

class _EmAlta extends State<EmAlta> {

  _listarVideos(String pesquisa){

    Api api = Api();
    return api.pesquisar( pesquisa );

  }

  @override
  void initState(){
    super.initState();
  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {


    return FutureBuilder<List<Video>>(
      future: _listarVideos( widget.pesquisa ),
      builder: (contex, snapshot){
        switch( snapshot.connectionState ){
          case ConnectionState.none :
          case ConnectionState.waiting :
            return Center(
              child: CircularProgressIndicator(),
            );

          case ConnectionState.active :
          case ConnectionState.done :
            if( snapshot.hasData ){

              return ListView.separated(
                  itemBuilder: (context, index){

                    var videos = snapshot.data;
                    Video video = videos![ index ];

                    return GestureDetector(
                      onTap: (){
                        FlutterYoutube.playYoutubeVideoById(
                            apiKey: CHAVE_YOUTUBE_API,
                            videoId: video.id,
                            autoPlay: true,
                            fullScreen: true
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage( video.imagem ),
                                )
                            ),
                          ),
                          ListTile(
                            title: Text( video.titulo ),
                            subtitle: Text( video.canal ),
                          )
                        ],
                      ),
                    );

                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                  itemCount: snapshot.data!.length
              );

            }else{
              return Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }

        }
      },
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
