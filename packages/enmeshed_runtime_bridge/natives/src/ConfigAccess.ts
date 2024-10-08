import { ILogger } from "@js-soft/logging-abstractions";
import { ApplicationError, Result } from "@js-soft/ts-utils";
import { INativeConfigAccess } from "@nmshd/app-runtime";
import stringifySafe from "json-stringify-safe";
import _ from "lodash";
import { FileAccess } from "./FileAccess";

export class ConfigAccess implements INativeConfigAccess {
  public constructor(
    private fileAccess: FileAccess,
    private logger: ILogger,
    private runtimeConfigPath: string
  ) {}

  private config: any = {};

  public async initDefaultConfig(): Promise<Result<void>> {
    const result: any = await window.flutter_inappwebview.callHandler("getDefaultConfig");
    this.config = _.defaultsDeep(this.config, result);

    return Result.ok(undefined);
  }

  public async initRuntimeConfig(): Promise<Result<void>> {
    const runtimeConfigExistsResult = await this.fileAccess.existsFile(this.runtimeConfigPath);
    if (runtimeConfigExistsResult.isError) {
      return Result.fail(new ApplicationError("CONFIG_INIT", "Unable to check if runtime config exists!"));
    }

    if (!runtimeConfigExistsResult.value) {
      this.logger.info("No runtime config found!");
      return Result.ok(undefined);
    }

    const runtimeConfigResult = await this.fileAccess.readFileAsText(this.runtimeConfigPath);
    if (runtimeConfigResult.isError) {
      return Result.fail(new ApplicationError("CONFIG_INIT", "Unable to read runtime config file!"));
    } else if (!runtimeConfigResult.value) {
      return Result.fail(new ApplicationError("CONFIG_INIT", "Unable to read runtime config file!"));
    }

    try {
      const runtimeConfig = JSON.parse(runtimeConfigResult.value);
      this.config = _.defaultsDeep(this.config, runtimeConfig);
    } catch (err) {
      return Result.fail(new ApplicationError("CONFIG_INIT", "Unable to parse runtime config data!"));
    }

    return Result.ok(undefined);
  }

  public async save(): Promise<Result<void>> {
    const configAsString = stringifySafe(this.config);
    const result = await this.fileAccess.writeFile(this.runtimeConfigPath, configAsString);
    if (result.isError) {
      return Result.fail(new ApplicationError("CONFIG_SAVE", "Unable to save runtime config!"));
    }

    return Result.ok(undefined);
  }

  public get(key: string): Result<any> {
    return Result.ok(this.config[key]);
  }

  public set(key: string, value: any): Result<void> {
    this.config[key] = value;
    this.save();
    return Result.ok(undefined);
  }

  public remove(key: string): Result<void> {
    delete this.config[key];
    this.save();
    return Result.ok(undefined);
  }
}
