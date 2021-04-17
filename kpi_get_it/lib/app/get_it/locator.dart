import 'package:get_it/get_it.dart';
import 'package:kpi_get_it/app/get_it/notifiers/artists_notifier.dart';

final GetIt locator = GetIt.instance;

void setup() {
  locator.registerSingleton(ArtistNotifier());
}