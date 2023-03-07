import { ILogger } from "@js-soft/logging-abstractions";
import { INativeScannerAccess } from "@js-soft/native-abstractions";
import { Result } from "@js-soft/ts-utils";

export class ScannerAccess implements INativeScannerAccess {
  public constructor(private readonly logger: ILogger) {}

  // eslint-disable-next-line @typescript-eslint/require-await
  public async scan(): Promise<Result<string>> {
    return Result.ok("");
  }
}
