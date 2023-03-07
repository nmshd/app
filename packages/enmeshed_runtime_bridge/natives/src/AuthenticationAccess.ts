import { ILogger } from "@js-soft/logging-abstractions";
import {
  INativeAuthenticationAccess,
  INativeAuthenticationOptions,
} from "@js-soft/native-abstractions";
import { Result } from "@js-soft/ts-utils";

export class AuthenticationAccess implements INativeAuthenticationAccess {
  public constructor(private readonly logger: ILogger) {}

  // eslint-disable-next-line @typescript-eslint/require-await
  public async authenticate(
    _options?: INativeAuthenticationOptions
  ): Promise<Result<boolean>> {
    return Result.ok(true);
  }
}
