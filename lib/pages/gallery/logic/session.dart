import 'package:cast/cast.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

CastSession castSession;
List<PhotoViewGalleryPageOptions> slideShowImages = [];
List<String> galleryImages = [];
List<Widget> galleryWidgets = [];
List rawImageData = [];
