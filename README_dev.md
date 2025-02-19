# Development Guide

## Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (we are using the `stable` channel)
- [melos](https://melos.invertase.dev/getting-started)

  TLDR: `dart pub global activate melos`

  Make sure to [add the system cache bin directory to your path](https://dart.dev/tools/pub/cmd/pub-global#running-a-script-from-your-path) (`$HOME/.pub-cache/bin` for mac and linux and `%LOCALAPPDATA%\Pub\Cache\bin` for most Windows versions).

## Getting Started

Run `melos bootstrap` to [install and link dependencies](https://melos.invertase.dev/commands/bootstrap) in all packages and apps.

## Melos scripts

For an overview of all available melos scripts, run `melos run` or `melos run --help`.

## Update the Runtime

Basically, the whole enmeshed Runtime is written in the file `packages/enmeshed_runtime_bridge/assets/index.js`.
Its respective version is specified in `packages/enmeshed_runtime_bridge/natives/package.json`.
In order to update it, you must adjust the version there, navigate to `packages/enmeshed_runtime_bridge/natives` and run `npm i`.
Afterwards, run `npm run build` in the same location, which will update the `index.js` file.

Now, to make the changes accessible for the App, all adjustments that are exposed, e.g. DTOs, DVOs, use cases and events, need to be adjusted in their respective places.
To do so, step through every Runtime change that was performed from the previous version to your newly updated one and check if it needs to be transferred to the App.
Usually, only changes to the Content- and Runtime-library are relevant for the App, but if you aren't sure, simply use the search function and check if the respective data object occurs anywhere besides the `index.js` file in the App-repository.
Don't forget to test every function you add to a facade.

Sometimes, a part of adding a new or adjusting an existing data object can be automated.
An example is adding a property to a DVO.
For this to work, `@JsonSerializable(includeIfNull: false)` must be written above the class declaration.
Then, run `dart run build_runner build` from the respective package.
This will create a file with the same name, but `.g.dart` as ending.
It is advisable to format the files of the package thereafter, e.g. by running `dart format .`.

## Moving patches to other apps

- open a terminal and go to `apps/enmeshed`
- run `git format-patch --relative -1 HEAD`, this will create a patch file in the current directory called `0001-<...>.patch`
- move the patch file to the target app
- run `git apply 0001-<...>.patch` in the target app directory
- when the patch cannot be applied because of conflicts you can exclude the files that cause the conflicts by using --exclude

  this can look as follows: `git apply 0001-<...>.patch --exclude=pubspec.lock --exclude=pubspec.yaml`

  common files that cause conflicts are:

  - `ios/Podfile`
  - `ios/Podfile.lock`
  - `pubspec.lock`
  - `pubspec.yaml`
  - `lib/l10n/app_de.arb`
  - `lib/l10n/app_en.arb`
