import { ILogger } from "@js-soft/logging-abstractions";
import { INativeDatabaseFactory, NativeErrorCodes } from "@js-soft/native-abstractions";
import { Document, deserialize } from "bson";
import loki from "lokijs";
import pako from "pako";
import { FileAccess } from "./FileAccess";

export class DatabaseFactory implements INativeDatabaseFactory {
  public constructor(
    private fileAccess: FileAccess,
    private readonly logger: ILogger
  ) {}

  public create(
    name: string,
    options?: Partial<LokiConstructorOptions> & Partial<LokiConfigOptions> & Partial<ThrottledSaveDrainOptions>
  ): Loki {
    return new loki(name, {
      adapter: new NativeDBPersitenceAdapter(this.fileAccess, this.logger),
      autosave: true,
      autoload: true,
      autosaveInterval: 1000,
      ...options
    });
  }
}

export class NativeDBPersitenceAdapter implements LokiPersistenceAdapter {
  public constructor(
    private readonly fileAccess: FileAccess,
    private readonly logger: ILogger
  ) {}

  public loadDatabase(dbname: string, callback: (value: any) => void): void {
    this.loadDatabaseAsync(dbname).then((res) => callback(res));
  }

  private async loadDatabaseAsync(dbname: string): Promise<any> {
    const metadataExists = await this.fileAccess.existsFile(`${dbname}_metadata`);
    if (metadataExists.isSuccess && metadataExists.value) {
      const migrator = new PakoBsonMigrator(this.fileAccess, this.logger);
      try {
        await migrator.migrate(dbname);
      } catch (err) {
        this.logger.error(err);
      }
    }

    const res = await this.fileAccess.readFileAsText(dbname);
    if (!res.isSuccess) return new Error(res.error.message);

    return res.value;
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

class PakoBsonMigrator {
  public constructor(
    private fileAccess: FileAccess,
    private readonly logger: ILogger
  ) {}

  public async migrate(dbname: string): Promise<void> {
    const metadataPath = `${dbname}_metadata`;
    const metadataPathResult = await this.fileAccess.existsFile(metadataPath);

    if (metadataPathResult.isError) {
      const error = `Error in loadDatabase: Unable to load database! Database files not found! Reason: ${metadataPathResult.error}`;
      this.logger.error(error);
      throw new Error(error);
    }

    const filesToBeDeleted: string[] = [metadataPath];

    const dbmeta = await this.loadDatabaseMetadata(metadataPath);
    const promiseArray: Promise<Document>[] = [];
    if (dbmeta?.collections) {
      for (const collection of dbmeta.collections) {
        const collectionPath = `${dbname}_${collection.name}`;
        filesToBeDeleted.push(collectionPath);
        promiseArray.push(this.loadCollectionData(collectionPath));
      }
      const collectionDataArray = await Promise.all(promiseArray);
      dbmeta.collections = collectionDataArray;
    }

    const result = await this.fileAccess.writeFile(dbname, JSON.stringify(dbmeta));
    if (result.isError) {
      const error = `Error in loadDatabase: Unable to load database! Database metadata not writable! Reason: ${result.error}`;
      this.logger.error(error);
      throw new Error(error);
    }

    for (const collection of filesToBeDeleted) {
      const deleteResult = await this.fileAccess.deleteFile(collection);
      if (deleteResult.isError) {
        const error = `Error in loadDatabase: Unable to load database! Database collection not deletable! Reason: ${deleteResult.error}`;
        this.logger.error(error);
        throw new Error(error);
      }
    }
  }

  private async loadDatabaseMetadata(metadataPath: string): Promise<any> {
    const result = await this.fileAccess.readFileAsText(metadataPath);
    if (result.isSuccess) {
      if (result.value) return JSON.parse(result.value);
      return {};
    } else if (result.error.code === NativeErrorCodes.FILESYSTEM_NOT_FOUND) {
      // Database does not exist
    } else {
      const error = `Unable to load database! Database metadata not readable! Reason: ${result.error}`;
      this.logger.error(error);
      throw new Error(error);
    }
  }

  private async loadCollectionData(collectionPath: string): Promise<any> {
    const collectionResult = await this.fileAccess.existsFile(collectionPath);
    if (collectionResult.isError) {
      throw new Error(`Unable to load database! Database collection file not found! Reason: ${collectionResult.error}`);
    }

    const result = await this.fileAccess.readFileAsBinary(collectionPath);
    if (result.isSuccess) {
      return deserialize(pako.inflate(result.value));
    }

    const error = `Unable to load database! Database collection file not readable! Reason: ${result.error}`;
    this.logger.error(error);
    throw new Error(error);
  }
}
