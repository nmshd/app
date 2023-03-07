import { ILogger } from "@js-soft/logging-abstractions";
import {
  INativeConfigAccess,
  INativeFileAccess,
  NativeErrorCodes,
} from "@js-soft/native-abstractions";
import { ApplicationError, Result } from "@js-soft/ts-utils";

export class ConfigAccess implements INativeConfigAccess {
  private config: any = {
    name: "Enmeshed",
    applicationId: "eu.enmeshed.app",
    type: "webapp",
    transport: {
      baseUrl: "https://bird.enmeshed.eu",
      logLevel: "warn",
      datawalletEnabled: true,
      platformClientId: "dev",
      platformClientSecret: "SY3nxukl6Xn8kGDk52EwBKXZMR9OR5",
    },
    firebase: {
      config: {
        apiKey: "AIzaSyBv0FRrupywUCQmvKKh4pFt4ZMn6u3VYDI",
        authDomain: "enmeshed.firebaseapp.com",
        projectId: "enmeshed",
        storageBucket: "enmeshed.appspot.com",
        messagingSenderId: "41802216214",
        appId: "1:41802216214:web:dbfa2b14f9d84f4cbd1637",
      },
      vapidKey:
        "BKb8ZrRPZgHXiA4gs62vUxpeT1aaxaH-UE62bEU4cQxmEaVbJCz045yAJpSZBsuMwW-nHr991lKSi5pp1p5Fppw",
    },
    localforage: {
      driver: "asyncStorage",
      name: "Enmeshed",
      version: 1.0,
      size: 4980736,
      storeName: "filesystem",
      description: "filesystem",
    },
    pushToken: null,
    theme: null,
  };

  // eslint-disable-next-line @typescript-eslint/require-await
  public async initDefaultConfig(_path: string): Promise<Result<void>> {
    return Result.fail(
      new ApplicationError(
        NativeErrorCodes.NOT_IMPLEMENTED_ERROR,
        "Not implemented"
      )
    );
  }

  // eslint-disable-next-line @typescript-eslint/require-await
  public async initRuntimeConfig(
    _path: string,
    _logger: ILogger,
    _fileAccess: INativeFileAccess
  ): Promise<Result<void>> {
    return Result.fail(
      new ApplicationError(
        NativeErrorCodes.NOT_IMPLEMENTED_ERROR,
        "Not implemented"
      )
    );
  }

  // eslint-disable-next-line @typescript-eslint/require-await
  public async save(): Promise<Result<void>> {
    return Result.ok(undefined);
  }

  public get(key: string): Result<any> {
    if (typeof key !== "string") {
      return Result.fail(
        new ApplicationError(
          NativeErrorCodes.CONFIG_NOT_FOUND,
          "Provided key is not a string."
        )
      );
    }

    return Result.ok(this.config[key]);
  }

  public set(key: string, value: any): Result<void> {
    this.config[key] = value;
    return Result.ok(undefined);
  }

  public remove(key: string): Result<void> {
    if (typeof key !== "string") {
      return Result.fail(
        new ApplicationError(
          NativeErrorCodes.CONFIG_NOT_FOUND,
          "Provided key is not a string."
        )
      );
    }

    delete this.config[key];
    return Result.ok(undefined);
  }
}
