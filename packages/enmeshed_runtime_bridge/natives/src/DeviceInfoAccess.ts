import {
  INativeDeviceInfo,
  INativeDeviceInfoAccess,
  PushServices,
} from "@js-soft/native-abstractions";
import { Result } from "@js-soft/ts-utils";

export class DeviceInfoAccess implements INativeDeviceInfoAccess {
  public get deviceInfo(): INativeDeviceInfo {
    return this._deviceInfo;
  }
  private _deviceInfo: INativeDeviceInfo = {
    model: "",
    platform: "",
    uuid: "",
    manufacturer: "",
    isVirtual: false,
    languageCode: "",
    version: "",
    pushService: PushServices.fcm,
  };

  // eslint-disable-next-line @typescript-eslint/require-await
  public async init(): Promise<Result<INativeDeviceInfo>> {
    return Result.ok(this._deviceInfo);
  }
}
