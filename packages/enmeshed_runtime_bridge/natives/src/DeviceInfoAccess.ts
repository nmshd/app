import { Result } from "@js-soft/ts-utils";
import { INativeDeviceInfo, INativeDeviceInfoAccess } from "@nmshd/app-runtime";

export class DeviceInfoAccess implements INativeDeviceInfoAccess {
  private _deviceInfo: INativeDeviceInfo;
  public get deviceInfo(): INativeDeviceInfo {
    return this._deviceInfo;
  }

  public async init(): Promise<Result<INativeDeviceInfo>> {
    const deviceInfo = await window.flutter_inappwebview.callHandler("getDeviceInfo");

    this._deviceInfo = {
      model: "",
      platform: "",
      uuid: "",
      manufacturer: "",
      isVirtual: false,
      languageCode: "",
      version: "",
      pushService: "none",
      ...deviceInfo
    };

    return Result.ok(this._deviceInfo);
  }
}
