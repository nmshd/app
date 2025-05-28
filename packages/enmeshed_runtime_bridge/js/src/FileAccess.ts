import { ApplicationError, Result } from "@js-soft/ts-utils";

export enum FileStorage {
  Temp = "temp",
  Home = "home",
  Data = "data",
  App = "app"
}

export class FileAccess {
  public async readFileAsText(
    path: string,
    storage?: FileStorage | undefined
  ): Promise<Result<string, ApplicationError>> {
    const result: { ok: true; content: string } | { ok: false; error: string } =
      await window.flutter_inappwebview.callHandler("readFile", path, storage ?? FileStorage.Data);

    if (!result.ok) {
      return Result.fail(new ApplicationError("err.filesystem.read", result.error));
    }

    return Result.ok(result.content);
  }

  public async readFileAsBinary(path: string, storage: FileStorage = FileStorage.Data): Promise<Result<Uint8Array>> {
    const result: { ok: true; content: number[] } | { ok: false; error: string } =
      await window.flutter_inappwebview.callHandler("readFileAsBinary", path, storage);

    if (!result.ok) {
      return Result.fail(new ApplicationError("err.filesystem.read", result.error));
    }

    return Result.ok(new Uint8Array(result.content));
  }

  public async writeFile(
    path: string,
    data: string | Uint8Array,
    storage?: FileStorage | undefined,
    append?: boolean | undefined
  ): Promise<Result<void, ApplicationError>> {
    const result: { ok: true } | { ok: false; error: string } = await window.flutter_inappwebview.callHandler(
      "writeFile",
      path,
      storage ?? FileStorage.Data,
      data,
      append ?? false
    );

    if (!result.ok) {
      return Result.fail(new ApplicationError("err.filesystem.write", result.error));
    }

    return Result.ok(undefined);
  }

  public async deleteFile(path: string, storage?: FileStorage | undefined): Promise<Result<void, ApplicationError>> {
    const result: { ok: true } | { ok: false; error: string } = await window.flutter_inappwebview.callHandler(
      "deleteFile",
      path,
      storage ?? FileStorage.Data
    );

    if (!result.ok) {
      return Result.fail(new ApplicationError("err.filesystem.delete", result.error));
    }

    return Result.ok(undefined);
  }

  public async existsFile(path: string, storage?: FileStorage): Promise<Result<boolean>> {
    const result: boolean = await window.flutter_inappwebview.callHandler(
      "existsFile",
      path,
      storage ?? FileStorage.Data
    );

    return Result.ok(result);
  }
}
