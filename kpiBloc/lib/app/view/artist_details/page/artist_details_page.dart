import 'package:flutter/material.dart';
import 'package:kpiBloc/app/bloc/albums_bloc.dart';
import 'package:kpiBloc/app/models/artist_albums_model.dart';
import 'package:kpiBloc/app/models/artist_model.dart';
import 'package:kpiBloc/app/view/artist_details/widgets/artist_details_app_bar.dart';
import 'package:kpiBloc/app/view/artist_details/widgets/artist_details_headline.dart';
import 'package:kpiBloc/app/view/homepage/widgets/homepage_artist_card.dart';
import 'package:kpiBloc/common_widgets/loader.dart';

class ArtistDetails extends StatefulWidget {
  const ArtistDetails({
    this.albumUrl,
    this.artistModel,
  });

  final String albumUrl;
  final ArtistModel artistModel;

  @override
  _ArtistDetailsChildState createState() => _ArtistDetailsChildState();
}

class _ArtistDetailsChildState extends State<ArtistDetails> {
  final AlbumBloc _albumBloc = AlbumBloc();

  @override
  void initState() {
    super.initState();
    Future<void>(() {
      loaderDialog(context: context);
    });
    _albumBloc
        .fetchAllAlbums(widget.albumUrl)
        .then((_) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailsAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            artistDetailsHeadline(
              image: widget.artistModel.aImage,
              name: widget.artistModel.aName,
              albumNumber: 0,
              context: context,
            ),
            StreamBuilder<dynamic>(
                stream: _albumBloc.allAlbums,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return buildList(snapshot.data as List<ArtistAlbumModel>);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                  return const SizedBox();
                }),
          ],
        ),
      ),
    );
  }
}

Widget buildList(List<ArtistAlbumModel> data) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: data.length ?? 0,
    itemBuilder: (BuildContext context, int index) {
      final ArtistAlbumModel singleAlbum = data[index];
      return artistCard(
        image: singleAlbum.albumImage,
        name: singleAlbum.albumName,
        description: singleAlbum.albumSongsNumber.toString(),
        context: context,
        type: CardType.album,
      );
    },
  );
}
