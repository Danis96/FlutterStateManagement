import 'package:flutter/material.dart';
import 'package:kpi_get_it/app/get_it/notifiers/artists_notifier.dart';
import 'package:kpi_get_it/app/models/artist_model.dart';
import 'package:kpi_get_it/app/utils/navigation_animation.dart';
import 'package:kpi_get_it/app/view/artist_details/page/artist_details_page.dart';
import 'package:kpi_get_it/app/view/homepage/widgets/homepage_app_bar.dart';
import 'package:kpi_get_it/app/view/homepage/widgets/homepage_artist_card.dart';
import 'package:kpi_get_it/app/view/homepage/widgets/homepage_headline.dart';
import 'package:kpi_get_it/common_widgets/loader.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

class Home extends StatefulWidget with GetItStatefulWidgetMixin {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> with GetItStateMixin {
  @override
  void initState() {
    Future<void>(() {
      loaderDialog(context: context);
    });
    getX((ArtistNotifier x) =>
        x.getArtists().then((_) => Navigator.of(context).pop()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final List<ArtistModel> artists = watchOnly((ArtistNotifier x) => x.artists);

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
                subtitle: 'Get It Mixin',
                context: context,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: artists.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Builder(builder: (BuildContext context) {
                    final ArtistModel singleArtist = artists[index];
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
