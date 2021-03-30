import 'package:flutter/material.dart';
import 'package:kpiProvider/app/models/artist_model.dart';
import 'package:kpiProvider/app/providers/artist_provider.dart';
import 'package:kpiProvider/app/utils/navigation_animation.dart';
import 'package:kpiProvider/app/view/artist_details/page/artist_details_page.dart';
import 'package:kpiProvider/app/view/homepage/widgets/homepage_app_bar.dart';
import 'package:kpiProvider/app/view/homepage/widgets/homepage_artist_card.dart';
import 'package:kpiProvider/app/view/homepage/widgets/homepage_headline.dart';
import 'package:kpiProvider/common_widgets/loader.dart';
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
    Future<void>(() {
      loaderDialog(context: context);
    });
    Provider.of<ArtistProvider>(context, listen: false)
        .getArtists()
        .then((_) => Navigator.of(context).pop());
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
                subtitle: 'PROVIDER',
                context: context,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: context.watch<ArtistProvider>().artists.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Builder(builder: (BuildContext context) {
                    final ArtistModel singleArtist =
                        context.select((ArtistProvider p) => p.artists[index]);
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
                  });
                }),
          ],
        ),
      ),
    );
  }
}
