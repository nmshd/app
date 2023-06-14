import { NativeFileStorage } from "@js-soft/native-abstractions";
import { ApplicationError, Result } from "@js-soft/ts-utils";

export class FileAccess {
  public async readFileAsText(
    path: string,
    storage?: NativeFileStorage | undefined
  ): Promise<Result<string, ApplicationError>> {
    const result: { ok: true; content: string } | { ok: false; error: string } =
      await window.flutter_inappwebview.callHandler("readFile", path, storage ?? NativeFileStorage.Data);

    if (!result.ok) {
      return Result.fail(new ApplicationError("err.filesystem.read", result.error));
    }

    return Result.ok(result.content);
  }

  public async writeFile(
    path: string,
    data: string | Uint8Array,
    storage?: NativeFileStorage | undefined,
    append?: boolean | undefined
  ): Promise<Result<void, ApplicationError>> {
    const result: { ok: true } | { ok: false; error: string } = await window.flutter_inappwebview.callHandler(
      "writeFile",
      path,
      storage ?? NativeFileStorage.Data,
      data,
      append ?? false
    );

    if (!result.ok) {
      return Result.fail(new ApplicationError("err.filesystem.write", result.error));
    }

    return Result.ok(undefined);
  }

  public async deleteFile(
    path: string,
    storage?: NativeFileStorage | undefined
  ): Promise<Result<void, ApplicationError>> {
    const result: { ok: true } | { ok: false; error: string } = await window.flutter_inappwebview.callHandler(
      "deleteFile",
      path,
      storage ?? NativeFileStorage.Data
    );

    if (!result.ok) {
      return Result.fail(new ApplicationError("err.filesystem.delete", result.error));
    }

    return Result.ok(undefined);
  }

  public async existsFile(path: string, storage?: NativeFileStorage): Promise<Result<boolean>> {
    const result: boolean = await window.flutter_inappwebview.callHandler(
      "existsFile",
      path,
      storage ?? NativeFileStorage.Data
    );

    return Result.ok(result);
  }
}
