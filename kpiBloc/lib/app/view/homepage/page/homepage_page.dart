import 'package:flutter/material.dart';
import 'package:kpiBloc/app/bloc/artist_bloc.dart';
import 'package:kpiBloc/app/models/artist_model.dart';
import 'package:kpiBloc/app/utils/navigation_animation.dart';
import 'package:kpiBloc/app/view/artist_details/page/artist_details_page.dart';
import 'package:kpiBloc/app/view/homepage/widgets/homepage_app_bar.dart';
import 'package:kpiBloc/app/view/homepage/widgets/homepage_artist_card.dart';
import 'package:kpiBloc/app/view/homepage/widgets/homepage_headline.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ArtistBloc _artistBloc = ArtistBloc();

  @override
  void initState() {
    _artistBloc.fetchAllArtistsInInit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(
        title: 'Artist App',
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: homePageHeadline(
                title: 'Welcome to Artist App',
                subtitle: 'Flutter State Management with BLOC',
                context: context,
              ),
            ),
            const SizedBox(height: 25),
            StreamBuilder<dynamic>(
              stream: _artistBloc.allArtists,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return buildList(snapshot.data as List<ArtistModel>);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(List<ArtistModel> data) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final ArtistModel singleArtist = data[index];
        return GestureDetector(
          onTap: () => Navigator.of(context).push<dynamic>(
            SlideAnimationTween(
              widget: ArtistDetails(
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
      },
    );
  }
}
