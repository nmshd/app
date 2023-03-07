import { ILogger } from "@js-soft/logging-abstractions";
import {
  INativeConfigAccess,
  INativeEventBus,
  INativeLaunchOptions,
} from "@js-soft/native-abstractions";
import { Result } from "@js-soft/ts-utils";

export class LaunchOptions implements INativeLaunchOptions {
  public constructor(
    private readonly logger: ILogger,
    private readonly eventBus: INativeEventBus,
    private readonly config: INativeConfigAccess
  ) {}

  public init(): Promise<Result<void>> {
    return Promise.resolve(Result.ok(undefined));
  }
}
