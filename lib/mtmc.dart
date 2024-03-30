library mtmc;

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:path_provider/path_provider.dart';

class MTMC extends TileProvider {
  @override
  ImageProvider getImage(TileCoordinates coords, TileLayer options) {
    return MapImageProvider(
      provider: MapTileProvider(),
      options: options,
      coords: coords,
    );
  }
}

class MapImageProvider extends ImageProvider<MapImageProvider> {
  final MapTileProvider provider;
  final TileLayer options;
  final TileCoordinates coords;

  MapImageProvider({
    required this.provider,
    required this.options,
    required this.coords,
  });

  @override
  ImageStreamCompleter load(MapImageProvider key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(decode),
      scale: 1.0,
    );
  }

  Future<Codec> _loadAsync(DecoderCallback decode) async {
    final Uint8List? bytes = await provider.getTileImage(coords, options);
    if (bytes != null) {
      return decode(bytes.buffer.asUint8List());
    } else {
      throw Exception('Failed to load tile image');
    }
  }

  @override
  Future<MapImageProvider> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture<MapImageProvider>(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MapImageProvider &&
          other.runtimeType == runtimeType &&
          other.coords == coords &&
          other.provider == provider &&
          other.options == options);

  @override
  int get hashCode => Object.hashAllUnordered([
        coords.hashCode,
        provider.hashCode,
        options.hashCode,
      ]);
}

class MapTileProvider {
  Future<Uint8List?> getTileImage(
      TileCoordinates coords, TileLayer options) async {
    final int zoom = coords.z.toInt();
    final int x = coords.x.toInt();
    final int y = coords.y.toInt();
    final String tileKey = "$zoom/$x/$y.png";
    final String cachePath = await _getCachePath(tileKey);
    final File cacheFile = File(cachePath);

    if (await cacheFile.exists()) {
      return await cacheFile.readAsBytes();
    } else {
      final Uint8List? bytes = await _fetchTileImage(coords, options);
      if (bytes != null) {
        await cacheFile.create(recursive: true);
        await cacheFile.writeAsBytes(bytes);
        return bytes;
      } else {
        return null;
      }
    }
  }

  Future<String> _getCachePath(String tileKey) async {
    final Directory cacheDirectory = await getTemporaryDirectory();
    return "${cacheDirectory.path}/tile_cache/$tileKey";
  }

  Future<Uint8List?> _fetchTileImage(
      TileCoordinates coords, TileLayer options) async {
    final Uri tileUri = Uri.parse(
      options.urlTemplate!
          .replaceAll('{z}', coords.z.toString())
          .replaceAll('{x}', coords.x.toString())
          .replaceAll('{y}', coords.y.toString()),
    );

    try {
      final HttpClient httpClient = HttpClient();
      final HttpClientRequest request = await httpClient.getUrl(tileUri);
      final HttpClientResponse response = await request.close();
      final Uint8List bytes =
          await consolidateHttpClientResponseBytes(response);
      return bytes;
    } catch (e) {
      return null;
    }
  }
}
