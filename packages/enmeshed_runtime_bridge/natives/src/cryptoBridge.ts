import * as types from "../../../../../rust-crypto/ts-types/index";

class TsDartBridgeError extends Error {

    constructor(message: string) {
        super(message);
    }
}

function uint8ArrayToBase64(uint8Array: Uint8Array): string {
    let binaryString = String.fromCharCode.apply(null, uint8Array as any);
    return btoa(binaryString);
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


type HandlerArgs = {
    object_type: string,
    method: string,
    args: any[],
}

let handlerName = "crypto_handler"

async function callHandler(handlerName: string, callArgs: HandlerArgs): Promise<any> {
    const res = await window.flutter_inappwebview.callHandler(handlerName, JSON.stringify(callArgs))
    const parsed = JSON.parse(res)
    if (parsed.status == "ok") {
        return parsed.data
    } else {
        throw new TsDartBridgeError(parsed.message)
    }
}

export let createProvider: types.CreateProviderFunc = async (config, implConfig) => {
    let callArgs = {
        object_type: "bare",
        method: "create_provider",
        args: [config, implConfig]
    }
    let handle_id = await callHandler(handlerName, callArgs);
    let handle = new Provider();
    handle._id = handle_id;
    return handle;
}

export let createProviderFromName: types.CreateProviderFromNameFunc = (name, implConfig) => {
    let callArgs = {
        object_type: "bare",
        method: "create_provider_from_name",
        args: [name, implConfig]
    }
    let handle_id =  callHandler(handlerName, callArgs);
    let handle = new Provider();
    handle._id = handle_id;
    return handle;
}

export class Provider {
    _id: string;

    createKey (keySpec: types.KeySpec): types.KeyHandle {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "create_key",
            args: [keySpec]
        }
        let handle_id =  callHandler(handlerName, callArgs);
        let handle = new KeyHandle();
        handle._id = handle_id;
        return handle;
    }

    createKeyPair(keySpec: types.KeyPairSpec): types.KeyPairHandle {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "create_key_pair",
            args: [keySpec]
        }
        let handle_id =  callHandler(handlerName, callArgs);
        let handle = new KeyPairHandle();
        handle._id = handle_id;
        return handle;
    }

    loadKey(id: string): types.KeyHandle {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "load_key",
            args: [id]
        }
        let handle_id =  callHandler(handlerName, callArgs);
        let handle = new KeyHandle();
        handle._id = handle_id;
        return handle;
    }

    loadKeyPair(id: string): types.KeyPairHandle {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "load_key_pair",
            args: [id]
        }
        let handle_id =  callHandler(handlerName, callArgs);
        let handle = new KeyPairHandle();
        handle._id = handle_id;
        return handle;
    }

    importKey(spec: types.KeySpec, data: Uint8Array): types.KeyHandle {
        let encoded_data = uint8ArrayToBase64(data)
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "import_key",
            args: [spec, encoded_data]
        }
        let handle_id =  callHandler(handlerName, callArgs);
        let handle = new KeyHandle();
        handle._id = handle_id;
        return handle;
    }

    importKeyPair(spec: types.KeyPairSpec, publicData: Uint8Array, privateData: Uint8Array): types.KeyPairHandle {
        let e_public = uint8ArrayToBase64(publicData)
        let e_private = uint8ArrayToBase64(privateData)
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "import_key_pair",
            args: [spec, e_public, e_private]
        }
        let handle_id =  callHandler(handlerName, callArgs);
        let handle = new KeyPairHandle();
        handle._id = handle_id;
        return handle;
    }

    importPublicKey(spec: types.KeyPairSpec, publicData: Uint8Array): types.KeyPairHandle {
        let e_public = uint8ArrayToBase64(publicData)
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "import_public_key",
            args: [spec, e_public]
        }
        let handle_id =  callHandler(handlerName, callArgs);
        let handle = new KeyPairHandle();
        handle._id = handle_id;
        return handle;
    }

    startEphemeralDhExchange(): types.DHExchange {
        return new DHExchange();
    }

    getAllKeys(): string[] {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "get_all_keys",
            args: []
        }
        return callHandler(handlerName, callArgs);
    }

    providerName(): string {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "provider_name",
            args: []
        }
        return callHandler(handlerName, callArgs);
    }

    getCapabilities(): types.ProviderConfig {
        let callArgs = {
            object_type: "provider",
            object_id: this._id,
            method: "get_capabilities",
            args: []
        }
        return callHandler(handlerName, callArgs);
    }
}

export class KeyHandle {
    _id: string;

    id(): string {
        return this._id;
    }

    encryptData(data: Uint8Array): [Uint8Array, Uint8Array] {
        let e_data = uint8ArrayToBase64(data)
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "encrypt_data",
            args: [e_data]
        }
        const [outData, iv] = callHandler(handlerName, callArgs);
        const d_outData = base64toUint8Array(outData)
        const d_iv = base64toUint8Array(iv)
        return [d_outData, d_iv]
    }

    decryptData(data: Uint8Array, iv: Uint8Array): Uint8Array {
        const e_data = uint8ArrayToBase64(data)
        const e_iv = uint8ArrayToBase64(iv)
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "decrypt_data",
            args: [e_data, e_iv]
        }
        const outData = callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    }

    hmac(data: Uint8Array): Uint8Array {
        const e_data = uint8ArrayToBase64(data);
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "hmac",
            args: [e_data]
        }
        const outData = callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    }

    verifyHmac(data: Uint8Array, hmac: Uint8Array): boolean {
        const e_data = uint8ArrayToBase64(data)
        const e_hmac = uint8ArrayToBase64(hmac)
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "verify_hmac",
            args: [e_data, e_hmac]
        }
        return callHandler(handlerName, callArgs)
    }

    delete(): void {
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "delete",
            args: []
        }
        callHandler(handlerName, callArgs);
    }

    extractKey(): Uint8Array {
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "extract_key",
            args: []
        }
        const outData = callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    }

    spec(): types.KeySpec {
        let callArgs = {
            object_type: "key",
            object_id: this._id,
            method: "spec",
            args: []
        }
        return callHandler(handlerName, callArgs)
    }
}

export class KeyPairHandle {
    _id: string;

    id(): string {
        return this._id;
    }

    encryptData(data: Uint8Array): Uint8Array {
        const e_data = uint8ArrayToBase64(data)
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "encrypt_data",
            args: [e_data]
        }
        const outData = callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    }

    decryptData(data: Uint8Array): Uint8Array {
        const e_data = uint8ArrayToBase64(data)
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "decrypt_data",
            args: [e_data]
        }
        const outData = callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    }

    signData(data: Uint8Array): Uint8Array {
        const e_data = uint8ArrayToBase64(data)
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "sign",
            args: [e_data]
        }
        const outData = callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    }

    verifySignature(data: Uint8Array, signature: Uint8Array): boolean {
        const e_data = uint8ArrayToBase64(data)
        const e_sign = uint8ArrayToBase64(signature)
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "verify_signature",
            args: [data, signature]
        }
        return callHandler(handlerName, callArgs);
    }

    delete(): void {
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "delete",
            args: []
        }
        callHandler(handlerName, callArgs);
    }

    getPublicKey(): Uint8Array {
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "extract_public_key",
            args: []
        }
        const outData = callHandler(handlerName, callArgs)
        return base64toUint8Array(outData)
    }

    spec(): types.KeyPairSpec {
        let callArgs = {
            object_type: "key_pair",
            object_id: this._id,
            method: "spec",
            args: []
        }
        return callHandler(handlerName, callArgs)
    }
}

export class DHExchange {
    getPublicKey(): Uint8Array {
        let callArgs = {
            object_type: "dh_exchange",
            method: "get_public_key",
            args: []
        }
        const outData = callHandler(handlerName, callArgs);
        return base64toUint8Array(outData)
    }

    addExternal(publicKey: Uint8Array): Uint8Array {
        const e_data = uint8ArrayToBase64(publicKey)
        let callArgs = {
            object_type: "dh_exchange",
            method: "add_external_key",
            args: [e_data]
        }
        const outData = callHandler(handlerName, callArgs);
        return base64toUint8Array(outData)
    }

    addExternalFinal(publicKey: Uint8Array): KeyHandle {
        const e_data = uint8ArrayToBase64(publicKey)
        let callArgs = {
            object_type: "dh_exchange",
            method: "add_external_final",
            args: [e_data]
        }
        const handle_id = callHandler(handlerName, callArgs)
        const handle = new KeyHandle()
        handle._id = handle_id
        return handle 
    }
}