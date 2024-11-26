> git format-patch --relative -1 HEAD

> git apply --directory apps/enmeshed 0001-....patch --exclude=apps/enmeshed/lib/l10n/app_de.arb --exclude=apps/enmeshed/lib/l10n/app_en.arb --exclude=apps/enmeshed/pubspec.yaml

--exclude=apps/enmeshed/ios/Podfile --exclude=apps/enmeshed/ios/Podfile.lock --exclude=apps/enmeshed/pubspec.lock --exclude=apps/enmeshed/pubspec.yaml
