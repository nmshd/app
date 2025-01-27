import 'dart:io';
import 'dart:ui' as ui;

import 'package:croppy/croppy.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';

class ChangeProfilePicture extends StatefulWidget {
  final String profileName;

  final VoidCallback onProfilePictureDeleted;
  final void Function(Uint8List) onProfilePictureChanged;
  final void Function({required bool loading}) setProfilePictureLoading;

  final File? initialProfilePicture;

  const ChangeProfilePicture({
    required this.profileName,
    required this.onProfilePictureDeleted,
    required this.onProfilePictureChanged,
    required this.setProfilePictureLoading,
    super.key,
    this.initialProfilePicture,
  });

  @override
  State<ChangeProfilePicture> createState() => _ChangeProfilePictureState();
}

class _ChangeProfilePictureState extends State<ChangeProfilePicture> {
  ImageProvider? _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    _image = widget.initialProfilePicture != null ? FileImage(widget.initialProfilePicture!) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Column(
        children: [
          if (!_loading)
            ProfilePicture(
              radius: 60,
              image: _image,
              profileName: widget.profileName,
              decorative: true,
            ),
          if (_loading) const CircleAvatar(radius: 60, child: CircularProgressIndicator()),
          Gaps.h16,
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  label: Text(_image == null ? context.l10n.profile_addPhoto : context.l10n.profile_editPhoto),
                  icon: const Icon(Icons.camera_alt_outlined, size: 16),
                  onPressed: _loading ? null : _editImage,
                ),
              ),
              if (_image != null)
                Expanded(
                  child: FilledButton.tonalIcon(
                    label: Text(context.l10n.profile_deletePhoto),
                    onPressed: _loading ? null : _deleteImage,
                    icon: const Icon(Icons.delete_outline, size: 16),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _deleteImage() {
    widget.onProfilePictureDeleted();
    setState(() => _image = null);
  }

  Future<void> _editImage() async {
    setState(() => _loading = true);
    widget.setProfilePictureLoading(loading: true);

    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      if (!mounted) return;

      final result = await showMaterialImageCropper(
        context,
        imageProvider: FileImage(File(pickedImage.path)),
        allowedAspectRatios: [const CropAspectRatio(width: 1, height: 1)],
        cropPathFn: ellipseCropShapeFn,
      );
      if (result == null) return;

      final uiImage = result.uiImage;
      final byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return;

      final baseSizeImage = img.decodeImage(byteData.buffer.asUint8List())!;
      const size = 512;
      final resizedImage = img.copyResize(baseSizeImage, height: size, width: size);
      final bytes = img.encodePng(resizedImage);

      widget.onProfilePictureChanged(bytes);
      if (mounted) setState(() => _image = MemoryImage(bytes));
    } on PlatformException catch (e) {
      GetIt.I.get<Logger>().e('Picking image failed caused by: $e');
      if (mounted) {
        await showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
              content: Text(context.l10n.error_image),
            );
          },
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
      widget.setProfilePictureLoading(loading: false);
    }
  }
}
