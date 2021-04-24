import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kpiRedux/app/models/artist_albums_model.dart';
import 'package:kpiRedux/app/models/artist_model.dart';
import 'package:kpiRedux/app/redux/actions/artist_actions.dart';
import 'package:kpiRedux/app/redux/app_state/app_state.dart';
import 'package:kpiRedux/app/redux/app_state/artist_state.dart';
import 'package:kpiRedux/app/view/artist_details/widgets/artist_details_app_bar.dart';
import 'package:kpiRedux/app/view/artist_details/widgets/artist_details_headline.dart';
import 'package:kpiRedux/app/view/homepage/widgets/homepage_artist_card.dart';
import 'package:redux/redux.dart';

class ArtistDetailPage extends StatelessWidget {
  const ArtistDetailPage({
    this.albumUrl,
    this.artistModel,
  });

  final String albumUrl;
  final ArtistModel artistModel;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AlbumDetailsProps>(
        converter: (Store<AppState> store) => mapStateToProps(store),
        builder: (BuildContext context, AlbumDetailsProps props) {
          return ArtistDetailsChild(
            props: props,
            artistModel: artistModel,
            albumUrl: albumUrl,
          );
        });
  }
}

class ArtistDetailsChild extends StatefulWidget {
  const ArtistDetailsChild({
    this.props,
    this.albumUrl,
    this.artistModel,
  });

  final AlbumDetailsProps props;
  final String albumUrl;
  final ArtistModel artistModel;

  @override
  _ArtistDetailsChildState createState() => _ArtistDetailsChildState();
}

class _ArtistDetailsChildState extends State<ArtistDetailsChild> {
  @override
  void initState() {
    super.initState();
    widget.props.getArtists(widget.albumUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailsAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 10),
            artistDetailsHeadline(
              image: widget.artistModel.aImage,
              name: widget.artistModel.aName,
              albumNumber: widget.props.albumResponse.data != null
                  ? widget.props.albumResponse.data.length
                  : 0,
              context: context,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.props.albumResponse.data != null
                  ? widget.props.albumResponse.data.length
                  : 0,
              itemBuilder: (BuildContext context, int index) {
                final ArtistAlbumModel album =
                    widget.props.albumResponse.data[index];
                return artistCard(
                  image: album.albumImage,
                  name: album.albumName,
                  description: album.albumPublished.toString(),
                  context: context,
                  type: CardType.album,
                  numberOfSongs: album.albumSongsNumber,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AlbumDetailsProps {
  AlbumDetailsProps({
    this.albumResponse,
    this.getArtists,
  });

  final Function getArtists;
  final ListArtistAlbumsState albumResponse;
}

AlbumDetailsProps mapStateToProps(Store<AppState> store) {
  return AlbumDetailsProps(
    albumResponse: store.state.artistState.albums,
    getArtists: (String link) =>
        store.dispatch(getArtistAlbumRequest(albumUrl: link)),
  );
}
