import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kpiRedux/app/models/artist_model.dart';
import 'package:kpiRedux/app/redux/actions/artist_actions.dart';
import 'package:kpiRedux/app/redux/app_state/app_state.dart';
import 'package:kpiRedux/app/redux/app_state/artist_state.dart';
import 'package:kpiRedux/app/utils/navigation_animation.dart';
import 'package:kpiRedux/app/view/artist_details/page/artist_details_page.dart';
import 'package:kpiRedux/app/view/homepage/widgets/homepage_app_bar.dart';
import 'package:kpiRedux/app/view/homepage/widgets/homepage_artist_card.dart';
import 'package:kpiRedux/app/view/homepage/widgets/homepage_headline.dart';
import 'package:redux/redux.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomepageProps>(
        converter: (Store<AppState> store) => mapStateToProps(store),
        builder: (BuildContext context, HomepageProps props) {
          return HomePage(props: props);
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    this.props,
  });

  final HomepageProps props;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.props.getArtists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(title: 'Artist App', context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: homePageHeadline(
                title: 'Welcome to Artist App',
                subtitle: 'State Management with REDUX',
                context: context,
              ),
            ),
            const SizedBox(height: 25),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.props.artistResponse.data != null
                  ? widget.props.artistResponse.data.length
                  : 0,
              itemBuilder: (BuildContext context, int index) {
                final ArtistModel singleArtist =
                    widget.props.artistResponse.data[index];
                return _buildList(context, singleArtist);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildList(BuildContext context, ArtistModel singleArtist) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push<dynamic>(
      SlideAnimationTween(
        widget: ArtistDetailPage(
          albumUrl: singleArtist.aAlbum,
          artistModel: singleArtist,
        ),
      ),
    ),
    child: artistCard(
      image: singleArtist.aImage,
      name: singleArtist.aName,
      description: singleArtist.aDescription,
      context: context,
    ),
  );
}

class HomepageProps {
  HomepageProps({
    this.artistResponse,
    this.getArtists,
  });

  final Function getArtists;
  final ListArtistState artistResponse;
}

HomepageProps mapStateToProps(Store<AppState> store) {
  return HomepageProps(
    artistResponse: store.state.artistState.list,
    getArtists: () => store.dispatch(getArtists()),
  );
}
