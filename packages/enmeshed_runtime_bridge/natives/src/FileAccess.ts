import {
  INativeDirectory,
  INativeFile,
  INativeFileAccess,
  INativeFileMetadata,
  NativeFileStorage,
} from "@js-soft/native-abstractions";
import { ApplicationError, Result } from "@js-soft/ts-utils";

export class FileAccess implements INativeFileAccess {
  public constructor() {}

  // eslint-disable-next-line @typescript-eslint/require-await
  public async init(): Promise<Result<void, ApplicationError>> {
    return Result.ok(undefined);
  }

  public infoFile(
    path: string,
    storage?: NativeFileStorage | undefined
  ): Promise<Result<INativeFileMetadata, ApplicationError>> {
    throw new Error("Method not implemented.");
  }

  public async readFileAsText(
    path: string,
    storage?: NativeFileStorage | undefined
  ): Promise<Result<string, ApplicationError>> {
    const result: { ok: true; content: string } | { ok: false; error: string } =
      await window.flutter_inappwebview.callHandler(
        "readFile",
        path,
        storage ?? NativeFileStorage.Data
      );

    if (!result.ok) {
      return Result.fail(
        new ApplicationError("err.filesystem.read", result.error)
      );
    }

    return Result.ok(result.content);
  }

  public readFileAsBinary(
    path: string,
    storage?: NativeFileStorage | undefined
  ): Promise<Result<Uint8Array, ApplicationError>> {
    throw new Error("Method not implemented.");
  }

  public async writeFile(
    path: string,
    data: string | Uint8Array,
    storage?: NativeFileStorage | undefined,
    append?: boolean | undefined
  ): Promise<Result<void, ApplicationError>> {
    const result: { ok: true } | { ok: false; error: string } =
      await window.flutter_inappwebview.callHandler(
        "writeFile",
        path,
        storage ?? NativeFileStorage.Data,
        data,
        append ?? false
      );

    if (!result.ok) {
      return Result.fail(
        new ApplicationError("err.filesystem.write", result.error)
      );
    }

    return Result.ok(undefined);
  }

  public async deleteFile(
    path: string,
    storage?: NativeFileStorage | undefined
  ): Promise<Result<void, ApplicationError>> {
    const result: { ok: true } | { ok: false; error: string } =
      await window.flutter_inappwebview.callHandler(
        "deleteFile",
        path,
        storage ?? NativeFileStorage.Data
      );

    if (!result.ok) {
      return Result.fail(
        new ApplicationError("err.filesystem.delete", result.error)
      );
    }

    return Result.ok(undefined);
  }

  public existsFile(
    path: string,
    storage?: NativeFileStorage | undefined
  ): Promise<Result<boolean, ApplicationError>> {
    throw new Error("Method not implemented.");
  }

  public infoDirectory(
    path: string,
    storage?: NativeFileStorage | undefined
  ): Promise<Result<INativeDirectory, ApplicationError>> {
    throw new Error("Method not implemented.");
  }

  public createDirectory(
    path: string,
    storage?: NativeFileStorage | undefined
  ): Promise<Result<void, ApplicationError>> {
    throw new Error("Method not implemented.");
  }

  public deleteDirectory(
    path: string,
    storage?: NativeFileStorage | undefined
  ): Promise<Result<void, ApplicationError>> {
    throw new Error("Method not implemented.");
  }

  public existsDirectory(
    path: string,
    storage?: NativeFileStorage | undefined
  ): Promise<Result<boolean, ApplicationError>> {
    throw new Error("Method not implemented.");
  }

  public select(): Promise<Result<INativeFile, ApplicationError>> {
    throw new Error("Method not implemented.");
  }

  public openFile(
    path: string,
    storage?: NativeFileStorage | undefined
  ): Promise<Result<void, ApplicationError>> {
    throw new Error("Method not implemented.");
  }

  public openFileContent(
    content: Uint8Array,
    metadata: INativeFileMetadata
  ): Promise<Result<void, ApplicationError>> {
    throw new Error("Method not implemented.");
  }
}
