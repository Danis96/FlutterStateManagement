import 'package:flutter/material.dart';
import 'package:kpiProvider/app/models/artist_model.dart';
import 'package:kpiProvider/app/providers/artist_provider.dart';
import 'package:kpiProvider/app/view/homepage/widgets/homepage_app_bar.dart';
import 'package:kpiProvider/app/view/homepage/widgets/homepage_artist_card.dart';
import 'package:kpiProvider/app/view/homepage/widgets/homepage_headline.dart';
import 'package:kpiProvider/routing/routes.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ArtistProvider>(
      create: (BuildContext context) => ArtistProvider(),
      child: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ArtistProvider>().fetchArtistsInInit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(title: 'Artist App', context: context),
      body: _buildBodyList(context),
    );
  }
}

Widget _buildBodyList(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(top: 30),
        child: homePageHeadline(
          title: 'Welcome to Artist App',
          subtitle: 'PROVIDER',
          context: context,
        ),
      ),
      const SizedBox(height: 25),
      _buildArtistList(context),
    ],
  );
}

Widget _buildArtistList(BuildContext context) {
  final ArtistProvider provider =
      Provider.of<ArtistProvider>(context, listen: true);
  return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: provider.artists.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Builder(builder: (BuildContext context) {
          final ArtistModel singleArtist = provider.artists[index];
          return GestureDetector(
            onTap: () {
              provider.setAlbumUrl(singleArtist.aAlbum);
              provider.setArtistModel(singleArtist);
              Navigator.of(context)
                  .pushNamed(ArtistDetails, arguments: provider);
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
