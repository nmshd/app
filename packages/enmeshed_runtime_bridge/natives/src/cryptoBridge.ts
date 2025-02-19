import * as types from "@nmshd/rs-crypto-types";

class TsDartBridgeError extends Error {

    constructor(message: string) {
        super(message);
    }
}

function base64toUint8Array(string: string): Uint8Array {
    const decoded = atob(string)
    const uint8Array = new Uint8Array(decoded.length);
    
    // Fill the Uint8Array with the byte values of the binary string
    for (let i = 0; i < decoded.length; i++) {
        uint8Array[i] = decoded.charCodeAt(i);
    }
    
    return uint8Array;
}

async function bufferToBase64(buffer: Uint8Array): Promise<string> {
    let array = buffer;
    if(buffer.constructor != Uint8Array) {
        array = new Uint8Array(buffer);
    }

    // use a FileReader to generate a base64 data URI:
    const base64url: string = await new Promise(r => {
      const reader = new FileReader()
      reader.onload = () => r(reader.result as string)
      reader.readAsDataURL(new Blob([array.buffer]))
    });
    // remove the `data:...;base64,` part from the start
    return base64url.slice(base64url.indexOf(',') + 1);
}



type HandlerArgs = {
    object_type: string,
    method: string,
    args: any[],
}

let handlerName = "handleCryptoEvent" 

async function callHandler(handlerName: string, callArgs: HandlerArgs): Promise<any> {
    const res = await window.flutter_inappwebview.callHandler(handlerName, JSON.stringify(callArgs))
    const parsed = JSON.parse(res)
    if (parsed.status == "ok") {
        return parsed.data
    } else {
        throw new TsDartBridgeError(parsed.message)
    }
}

async function createProvider(config: types.ProviderConfig , implConfig: types.ProviderImplConfig): Promise<Provider> {
    let callArgs = {
        object_type: "bare",
        method: "create_provider",
        args: [config, implConfig]
    }
    let handle_id = await callHandler(handlerName, callArgs);
    let handle = newProvider();
    handle._id = handle_id;
    return handle;
}

async function createProviderFromName(name: string, implConfig: types.ProviderImplConfig): Promise<Provider> {
    let callArgs = {
        object_type: "bare",
        method: "create_provider_from_name",
        args: [name, implConfig]
    }
    let handle_id = await callHandler(handlerName, callArgs);
    let handle = newProvider();
    handle._id = handle_id;
    return handle;
}

async function getAllProviders(): Promise<string[]> {
    let callArgs = {
        object_type: "bare",
        method: "get_all_providers",
        args: []
    }
    return callHandler(handlerName, callArgs);
}

async function getProviderCapabilities(impl_config: types.ProviderImplConfig): Promise<[string, types.ProviderConfig][]> {
    let callArgs = {
        object_type: "bare",
        method: "get_provider_capabilities",
        args: [impl_config]
    }
    return callHandler(handlerName, callArgs);
}

interface Provider {
    _id: string;
    createKey(keySpec: types.KeySpec): Promise<types.KeyHandle>;
    createKeyPair(keySpec: types.KeyPairSpec): Promise<types.KeyPairHandle>;
    loadKey(id: string): Promise<types.KeyHandle>;
    loadKeyPair(id: string): Promise<types.KeyPairHandle>;
    importKey(spec: types.KeySpec, data: Uint8Array): Promise<types.KeyHandle>;
    importKeyPair(spec: types.KeyPairSpec, publicData: Uint8Array, privateData: Uint8Array): Promise<types.KeyPairHandle>;
    importPublicKey(spec: types.KeyPairSpec, publicData: Uint8Array): Promise<types.KeyPairHandle>;
    startEphemeralDhExchange(): Promise<types.DHExchange>;
    getAllKeys(): Promise<string[]>;
    providerName(): Promise<string>;
    getCapabilities(): Promise<types.ProviderConfig>;
}

function newProvider(): Provider {
    return {
    _id: "",

        createKey: async function(keySpec: types.KeySpec): Promise<types.KeyHandle> {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "create_key",
            args: [keySpec]
        }
        let handle_id = await callHandler(handlerName, callArgs);
        let handle = newKeyHandle(handle_id);
        return handle;
    },

    createKeyPair: async function(keySpec: types.KeyPairSpec): Promise<types.KeyPairHandle> {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "create_key_pair",
            args: [keySpec]
        }
        let handle_id = await callHandler(handlerName, callArgs);
        let handle = newKeyPairHandle(handle_id);
        return handle;
    },

    loadKey: async function(id: string): Promise<types.KeyHandle> {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "load_key",
            args: [id]
        }
        let handle_id = await callHandler(handlerName, callArgs);
        let handle = newKeyHandle(handle_id);
        return handle;
    },

    loadKeyPair: async function(id: string): Promise<types.KeyPairHandle> {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "load_key_pair",
            args: [id]
        }
        let handle_id = await callHandler(handlerName, callArgs);
        let handle = newKeyPairHandle(handle_id);
        return handle;
    },

    importKey: async function(spec: types.KeySpec, data: Uint8Array): Promise<types.KeyHandle> {
        let encoded_data = bufferToBase64(data)
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "import_key",
            args: [spec, encoded_data]
        }
        let handle_id = await callHandler(handlerName, callArgs);
        let handle = newKeyHandle(handle_id);
        return handle;
    },

    importKeyPair: async function(spec: types.KeyPairSpec, publicData: Uint8Array, privateData: Uint8Array): Promise<types.KeyPairHandle> {
        let e_public = bufferToBase64(publicData)
        let e_private = bufferToBase64(privateData)
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "import_key_pair",
            args: [spec, e_public, e_private]
        }
        let handle_id = await callHandler(handlerName, callArgs);
        let handle = newKeyPairHandle(handle_id);
        return handle;
    },

    importPublicKey: async function(spec: types.KeyPairSpec, publicData: Uint8Array): Promise<types.KeyPairHandle> {
        let e_public = bufferToBase64(publicData)
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "import_public_key",
            args: [spec, e_public]
        }
        let handle_id = await callHandler(handlerName, callArgs);
        let handle = newKeyPairHandle(handle_id);
        return handle;
    },

    startEphemeralDhExchange: async function(): Promise<types.DHExchange> {
        return new DHExchange();
    },

    getAllKeys: function(): Promise<string[]> {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "get_all_keys",
            args: []
        }
        return callHandler(handlerName, callArgs);
    },

    providerName: async function(): Promise<string> {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "provider_name",
            args: []
        }
        return callHandler(handlerName, callArgs);
    },

    getCapabilities: async function(): Promise<types.ProviderConfig> {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "get_capabilities",
            args: []
        }
        return callHandler(handlerName, callArgs);
    }
}
}

interface KeyHandle {
    _id: string;
    id(): Promise<string>;
    encryptData(data: Uint8Array): Promise<[Uint8Array, Uint8Array]>;
    decryptData(data: Uint8Array, iv: Uint8Array): Promise<Uint8Array>;
    hmac(data: Uint8Array): Promise<Uint8Array>;
    verifyHmac(data: Uint8Array, hmac: Uint8Array): Promise<boolean>;
    delete(): Promise<void>;
    extractKey(): Promise<Uint8Array>;
    spec(): Promise<types.KeySpec>;
}

function newKeyHandle(_id: string): KeyHandle {
    return {
    _id,

    id: function(): Promise<string> {
        return Promise.resolve(this._id);
    },

    encryptData: async function(data: Uint8Array): Promise<[Uint8Array, Uint8Array]> {
        let e_data = bufferToBase64(data)
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "encrypt_data",
            args: [e_data]
        }
        const [outData, iv] = await callHandler(handlerName, callArgs);
        const d_outData = base64toUint8Array(outData)
        const d_iv = base64toUint8Array(iv)
        return [d_outData, d_iv]
    },

    decryptData: async function(data: Uint8Array, iv: Uint8Array): Promise<Uint8Array> {
        const e_data = bufferToBase64(data)
        const e_iv = bufferToBase64(iv)
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "decrypt_data",
            args: [e_data, e_iv]
        }
        const outData = await callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    },

    hmac: async function(data: Uint8Array): Promise<Uint8Array> {
        const e_data = bufferToBase64(data);
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "hmac",
            args: [e_data]
        }
        const outData = await callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    },

    verifyHmac: async function(data: Uint8Array, hmac: Uint8Array): Promise<boolean> {
        const e_data = bufferToBase64(data)
        const e_hmac = bufferToBase64(hmac)
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "verify_hmac",
            args: [e_data, e_hmac]
        }
        return callHandler(handlerName, callArgs)
    },

    delete: async function(): Promise<void> {
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "delete",
            args: []
        }
        callHandler(handlerName, callArgs);
    },

    extractKey: async function(): Promise<Uint8Array> {
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "extract_key",
            args: []
        }
        const outData = await callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    },

    spec: async function(): Promise<types.KeySpec> {
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "spec",
            args: []
        }
        return callHandler(handlerName, callArgs)
    }
}
}

interface KeyPairHandle {
    _id: string;
    id(): Promise<string>;
    encryptData(data: Uint8Array): Promise<Uint8Array>;
    decryptData(data: Uint8Array): Promise<Uint8Array>;
    signData(data: Uint8Array): Promise<Uint8Array>;
    verifySignature(data: Uint8Array, signature: Uint8Array): Promise<boolean>;
    delete(): Promise<void>;
    getPublicKey(): Promise<Uint8Array>;
    extractKey(): Promise<Uint8Array>;
    spec(): Promise<types.KeyPairSpec>;
}

function newKeyPairHandle(_id: string): KeyPairHandle {
    return {
    _id,

    id(): Promise<string> {
        return Promise.resolve(this._id);
    },

    encryptData: async function(data: Uint8Array): Promise<Uint8Array> {
        const e_data = bufferToBase64(data)
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "encrypt_data",
            args: [e_data]
        }
        const outData = await callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    },

    decryptData: async function(data: Uint8Array): Promise<Uint8Array> {
        const e_data = bufferToBase64(data)
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "decrypt_data",
            args: [e_data]
        }
        const outData = await callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    },

    signData: async function(data: Uint8Array): Promise<Uint8Array> {
        const e_data = await bufferToBase64(data)
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "sign_data",
            args: [e_data]
        }
        const outData = await callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    },

    verifySignature: async function(data: Uint8Array, signature: Uint8Array) {
        const e_data = await bufferToBase64(data)
        const e_sign = await bufferToBase64(signature)
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "verify_signature",
            args: [e_data, e_sign]
        }
        return callHandler(handlerName, callArgs);
    },

    delete: async function(): Promise<void> {
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "delete",
            args: []
        }
        callHandler(handlerName, callArgs);
    },

    getPublicKey: async function(): Promise<Uint8Array> {
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "extract_public_key",
            args: []
        }
        const outData = await callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    },

    extractKey: async function(): Promise<Uint8Array> {
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "extract_key",
            args: []
        }
        const outData = await callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    },

    spec: async function(): Promise<types.KeyPairSpec> {
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "spec",
            args: []
        }
        return callHandler(handlerName, callArgs)
    }
}
}

export class DHExchange {
    async getPublicKey(): Promise<Uint8Array> {
        let callArgs = {
            object_type: "dh_exchange",
            method: "get_public_key",
            args: []
        }
        const outData = await callHandler(handlerName, callArgs);
        return base64toUint8Array(outData)
    }

    async addExternal(publicKey: Uint8Array): Promise<Uint8Array> {
        const e_data = bufferToBase64(publicKey)
        let callArgs = {
            object_type: "dh_exchange",
            method: "add_external_key",
            args: [e_data]
        }
        const outData = await callHandler(handlerName, callArgs);
        return base64toUint8Array(outData)
    }

    async addExternalFinal(publicKey: Uint8Array): Promise<KeyHandle> {
        const e_data = bufferToBase64(publicKey)
        let callArgs = {
            object_type: "dh_exchange",
            method: "add_external_final",
            args: [e_data]
        }
        const handle_id = await callHandler(handlerName, callArgs)
        const handle = newKeyHandle(handle_id)
        return handle 
    }
}

type CryptoInit = {
    createProvider: types.CreateProviderFunc,
    createProviderFromName: types.CreateProviderFromNameFunc,
    getAllProviders: types.GetAllProvidersFunc,
    getProviderCapabilities: types.GetProviderCapabilitiesFunc,
    provider: typeof newProvider,
    keyHandle: typeof newKeyHandle,
    keyPairHandle: typeof newKeyPairHandle,
}

const cryptoInit: CryptoInit = {
    createProvider: createProvider,
    createProviderFromName: createProviderFromName,
    getAllProviders: getAllProviders,
    getProviderCapabilities: getProviderCapabilities,
    provider: newProvider,
    keyHandle: newKeyHandle,
    keyPairHandle: newKeyPairHandle,
};

(window as any).cryptoInit = cryptoInit;
