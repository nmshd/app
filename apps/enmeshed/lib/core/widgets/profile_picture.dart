import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/utils.dart';

class AutoLoadingProfilePicture extends StatelessWidget {
  final String accountId;
  final String profileName;
  final double radius;

  final Color circleAvatarColor;

  const AutoLoadingProfilePicture({
    required this.accountId,
    required this.profileName,
    required this.circleAvatarColor,
    super.key,
    this.radius = 28.0,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadProfilePicture(accountReference: accountId),
      builder: (context, snapshot) => ProfilePicture(
        profileName: profileName,
        image: snapshot.data is File ? FileImage(snapshot.data!) : null,
        radius: radius,
        circleAvatarColor: circleAvatarColor,
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  final String profileName;
  final ImageProvider? image;
  final double radius;

  final Color circleAvatarColor;

  const ProfilePicture({
    required this.profileName,
    required this.circleAvatarColor,
    super.key,
    this.image,
    this.radius = 28.0,
  });

  @override
  Widget build(BuildContext context) {
    if (image != null) return CircleAvatar(radius: radius, backgroundImage: image);

    return _AlternativeProfilePicture(
      profileName: profileName,
      radius: radius,
      circleAvatarColor: circleAvatarColor,
    );
  }
}

class _AlternativeProfilePicture extends StatelessWidget {
  final String profileName;
  final Color circleAvatarColor;
  final double radius;

  const _AlternativeProfilePicture({
    required this.profileName,
    required this.circleAvatarColor,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: circleAvatarColor,
      child: Text(
        _profileNameLetters(profileName).trim(),
        style: TextStyle(fontSize: radius * 0.8, fontWeight: FontWeight.bold),
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
