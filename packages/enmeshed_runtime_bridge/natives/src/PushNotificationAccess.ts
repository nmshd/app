import { ILogger } from "@js-soft/logging-abstractions";
import {
  IElectronConfig,
  INativeConfigAccess,
  INativeEventBus,
  INativePushNotificationAccess
} from "@js-soft/native-abstractions";
import { Result } from "@js-soft/ts-utils";

export class PersistentIDs {
  public constructor(public readonly config: INativeConfigAccess) {}

  private ids!: Record<string, number>;

  public async save(): Promise<void> {
    const config: IElectronConfig = this.config.get("react-native").value;
    this.config.set("react-native", { ...config, persistentIDs: this.ids });
    await this.config.save();
  }
  public load(): void {
    const config: IElectronConfig = this.config.get("react-native").value;
    this.ids = config.persistentIDs || {};
  }
  public getIDs(): string[] {
    return Object.keys(this.ids);
  }
  public addID(id: string): void {
    this.ids[id] = Date.now();
  }
  public removeID(id: string): void {
    delete this.ids[id];
  }
  public removeIDsSinceDays(days: number): void {
    const currentTime = Date.now();
    for (const id in this.ids) {
      const timeDifference = currentTime - this.ids[id];
      const dayDifference = timeDifference / (1000 * 60 * 60 * 24);
      if (dayDifference >= days) {
        this.removeID(id);
      }
    }
  }
}

export class PushNotificationAccess implements INativePushNotificationAccess {
  public constructor(
    private readonly logger: ILogger,
    private readonly config: INativeConfigAccess,
    private readonly eventBus: INativeEventBus
  ) {}

  // eslint-disable-next-line @typescript-eslint/require-await
  public async init(): Promise<Result<void>> {
    return Result.ok(undefined);
  }
}
