import { INativeDatabaseFactory } from "@js-soft/native-abstractions";
import loki from "lokijs";
import { FileAccess } from "./FileAccess";

export class DatabaseFactory implements INativeDatabaseFactory {
  public constructor(private fileAccess: FileAccess) {}

  public create(
    name: string,
    options?: Partial<LokiConstructorOptions> & Partial<LokiConfigOptions> & Partial<ThrottledSaveDrainOptions>
  ): Loki {
    return new loki(name, {
      adapter: new NativeDBPersitenceAdapter(this.fileAccess),
      autosave: true,
      autoload: true,
      autosaveInterval: 1000,
      ...options
    });
  }
}

export class NativeDBPersitenceAdapter implements LokiPersistenceAdapter {
  public constructor(private readonly fileAccess: FileAccess) {}

  public loadDatabase(dbname: string, callback: (value: any) => void): void {
    this.fileAccess.readFileAsText(dbname).then((res) => {
      if (res.isSuccess) {
        callback(res.value);
      } else {
        callback(new Error(res.error.message));
      }
    });
  }

  public deleteDatabase(dbname: string, callback: (err?: Error | null, data?: any) => void): void {
    this.fileAccess.deleteFile(dbname).then((res) => {
      if (res.isSuccess) {
        callback();
      } else {
        callback(new Error(res.error.message));
      }
    });
  }

  public saveDatabase(dbname: string, dbstring: any, callback: (err?: Error | null) => void): void {
    this.fileAccess.writeFile(dbname, dbstring).then((res) => {
      if (res.isSuccess) {
        callback();
      } else {
        callback(new Error(res.error.message));
      }
    });
  }
}
