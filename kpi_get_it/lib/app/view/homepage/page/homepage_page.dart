import 'package:flutter/material.dart';
import 'package:kpi_get_it/app/get_it/notifiers/artists_notifier.dart';
import 'package:kpi_get_it/app/models/artist_model.dart';
import 'package:kpi_get_it/app/view/homepage/widgets/homepage_app_bar.dart';
import 'package:kpi_get_it/app/view/homepage/widgets/homepage_artist_card.dart';
import 'package:kpi_get_it/app/view/homepage/widgets/homepage_headline.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:kpi_get_it/routing/routes.dart';

class Home extends StatefulWidget with GetItStatefulWidgetMixin {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> with GetItStateMixin {
  @override
  void initState() {
    getX((ArtistNotifier x) => x.fetchArtistInInit(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(title: 'Artist App', context: context),
      body: _buildListBody(context),
    );
  }
}

Widget _buildListBody(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(top: 30),
        child: homePageHeadline(
          title: 'Welcome to Artist App',
          subtitle: 'Get It Mixin',
          context: context,
        ),
      ),
      const SizedBox(height: 25),
      BuildArtistList(),
    ],
  );
}


// here I needed to leave stateless widget because methods of GetItMixin,
// I can only access inside of a build function
class BuildArtistList extends StatelessWidget with GetItMixin {
  @override
  Widget build(BuildContext context) {
    final List<ArtistModel> artists =
        watchOnly((ArtistNotifier x) => x.artists);
    final ArtistNotifier notifier = getX((ArtistNotifier x) => x);
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: artists.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Builder(builder: (BuildContext context) {
            final ArtistModel singleArtist = artists[index];
            return GestureDetector(
              onTap: () {
                   notifier.setAlbumUrl(singleArtist.aAlbum);
                   notifier.setArtistModel(singleArtist);
                   Navigator.of(context).pushNamed(ArtistDetails);
              },
              child: artistCard(
                image: singleArtist.aImage,
                name: singleArtist.aName,
                description: singleArtist.aDescription,
                context: context,
              ),
            );
          });
        });
  }
}
