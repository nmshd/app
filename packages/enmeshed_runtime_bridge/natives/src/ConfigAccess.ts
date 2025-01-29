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
    private configPath: string
  ) {}

  private config: any = {};

  public async init(): Promise<Result<void>> {
    const configExistsResult = await this.fileAccess.existsFile(this.configPath);
    if (configExistsResult.isError) {
      return Result.fail(new ApplicationError("CONFIG_INIT", "Unable to check if runtime config exists!"));
    }

    if (!configExistsResult.value) {
      this.logger.info("No config found!");
      return Result.ok(undefined);
    }

    const configResult = await this.fileAccess.readFileAsText(this.configPath);
    if (configResult.isError) {
      return Result.fail(new ApplicationError("CONFIG_INIT", "Unable to read runtime config file!"));
    } else if (!configResult.value) {
      return Result.fail(new ApplicationError("CONFIG_INIT", "Unable to read runtime config file!"));
    }

    try {
      const config = JSON.parse(configResult.value);
      this.config = _.defaultsDeep(this.config, config);

      await this.save();
    } catch (err) {
      return Result.fail(new ApplicationError("CONFIG_INIT", "Unable to parse runtime config data!"));
    }

    return Result.ok(undefined);
  }

  public async save(): Promise<Result<void>> {
    const configAsString = stringifySafe(this.config);
    const result = await this.fileAccess.writeFile(this.configPath, configAsString);
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
