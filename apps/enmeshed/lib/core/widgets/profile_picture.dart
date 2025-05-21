import 'dart:io';

import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class AutoLoadingProfilePicture extends StatelessWidget {
  final String accountId;
  final String profileName;
  final double radius;
  final bool decorative;
  final VoidCallback? onPressed;

  const AutoLoadingProfilePicture({
    required this.accountId,
    required this.profileName,
    this.decorative = false,
    this.radius = 28.0,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadProfilePicture(accountReference: accountId),
      builder: (context, snapshot) => ProfilePicture(
        profileName: profileName,
        image: snapshot.data is File ? FileImage(snapshot.data!) : null,
        radius: radius,
        decorative: decorative,
        onPressed: onPressed,
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  final String profileName;
  final ImageProvider? image;
  final double radius;
  final bool decorative;
  final VoidCallback? onPressed;

  const ProfilePicture({required this.profileName, this.decorative = false, super.key, this.image, this.radius = 28.0, this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      if (onPressed == null) return CircleAvatar(radius: radius, backgroundImage: image);

      return Material(
        clipBehavior: Clip.hardEdge,
        shape: const CircleBorder(),
        child: Ink.image(
          image: image!,
          width: radius * 2,
          height: radius * 2,
          child: InkWell(onTap: onPressed),
        ),
      );
    }

    final circleAvatarColor = decorative ? context.customColors.decorativeContainer : Theme.of(context).colorScheme.primaryContainer;
    final textColor = decorative ? context.customColors.onDecorativeContainer : Theme.of(context).colorScheme.onPrimaryContainer;

    return _AlternativeProfilePicture(
      profileName: profileName,
      radius: radius,
      circleAvatarColor: circleAvatarColor,
      textColor: textColor,
      onPressed: onPressed,
    );
  }
}

class _AlternativeProfilePicture extends StatelessWidget {
  final String profileName;
  final Color circleAvatarColor;
  final Color textColor;
  final double radius;
  final VoidCallback? onPressed;

  const _AlternativeProfilePicture({
    required this.profileName,
    required this.circleAvatarColor,
    required this.textColor,
    required this.radius,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (onPressed != null) {
      return Material(
        color: circleAvatarColor,
        shape: const CircleBorder(),
        child: InkWell(
          borderRadius: BorderRadius.circular(90),
          onTap: onPressed,
          child: SizedBox(
            width: radius * 2,
            height: radius * 2,
            child: Center(
              child: Text(
                _profileNameLetters(profileName).trim(),
                style: TextStyle(fontSize: radius * 0.8, fontWeight: FontWeight.bold, color: textColor),
              ),
            ),
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: circleAvatarColor,
      child: Text(
        _profileNameLetters(profileName).trim(),
        style: TextStyle(fontSize: radius * 0.8, fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }

  String _profileNameLetters(String profileName) {
    if (profileName.length <= 2) return profileName;

    final splitted = profileName.split(RegExp('[ -]+')).where((e) => e.isNotEmpty).toList();
    if (splitted.length > 1) {
      return splitted[0].substring(0, 1) + splitted[1].substring(0, 1);
    }

    return profileName.substring(0, 2);
  }
}
