import { ILogger } from "@js-soft/logging-abstractions";
import {
  INativeConfigAccess,
  INativeKeychainAccess,
  INativeKeychainEntry,
  NativeErrorCodes,
} from "@js-soft/native-abstractions";
import { ApplicationError, Result } from "@js-soft/ts-utils";

export class KeychainAccess implements INativeKeychainAccess {
  private readonly service: string;
  public constructor(
    private readonly logger: ILogger,
    private readonly config: INativeConfigAccess
  ) {
    this.service = this.config.get("name").value;
  }

  public init(): Promise<Result<void>> {
    return Promise.resolve(Result.ok(undefined));
  }

  public async get(key: string): Promise<Result<INativeKeychainEntry>> {
    return Result.fail(
      new ApplicationError(NativeErrorCodes.KEYCHAIN_UNKNOWN, `not implemented`)
    );
  }

  public async set(key: string, value: any): Promise<Result<void>> {
    return Result.fail(
      new ApplicationError(NativeErrorCodes.KEYCHAIN_UNKNOWN, `not implemented`)
    );
  }

  public async delete(_key: string): Promise<Result<void>> {
    return Result.fail(
      new ApplicationError(NativeErrorCodes.KEYCHAIN_UNKNOWN, `not implemented`)
    );
  }

  // eslint-disable-next-line @typescript-eslint/require-await
  public async list(): Promise<Result<INativeKeychainEntry[]>> {
    return Result.ok([]);
  }
}
