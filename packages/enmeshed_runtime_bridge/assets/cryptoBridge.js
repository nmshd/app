"use strict";(()=>{var A=Object.defineProperty;var l=(a,e)=>A(a,"name",{value:e,configurable:!0});var P=class P extends Error{constructor(e){super(e)}};l(P,"TsDartBridgeError");var g=P;function c(a){let e=atob(a),t=new Uint8Array(e.length);for(let r=0;r<e.length;r++)t[r]=e.charCodeAt(r);return t}l(c,"base64toUint8Array");async function y(a){let e=a;a.constructor!=Uint8Array&&(e=new Uint8Array(a));let t=await new Promise(r=>{let i=new FileReader;i.onload=()=>r(i.result),i.readAsDataURL(new Blob([e.buffer]))});return t.slice(t.indexOf(",")+1)}l(y,"bufferToBase64");var n="handleCryptoEvent";async function s(a,e){let t=await window.flutter_inappwebview.callHandler(a,JSON.stringify(e)),r=JSON.parse(t);if(r.status=="ok")return r.data;throw new g(r.message)}l(s,"callHandler");async function b(a,e){let r=await s(n,{object_type:"bare",method:"create_provider",args:[a,e]}),i=h();return i._id=r,i}l(b,"createProvider");async function v(a,e){let r=await s(n,{object_type:"bare",method:"create_provider_from_name",args:[a,e]}),i=h();return i._id=r,i}l(v,"createProviderFromName");async function K(){return s(n,{object_type:"bare",method:"get_all_providers",args:[]})}l(K,"getAllProviders");async function U(a){return s(n,{object_type:"bare",method:"get_provider_capabilities",args:[a]})}l(U,"getProviderCapabilities");function h(){return{_id:"",createKey:async function(a){let e={object_type:"provider",object_id:this._id,method:"create_key",args:[a]},t=await s(n,e);return p(t)},createKeyPair:async function(a){let e={object_type:"provider",object_id:this._id,method:"create_key_pair",args:[a]},t=await s(n,e);return m(t)},loadKey:async function(a){let e={object_type:"provider",object_id:this._id,method:"load_key",args:[a]},t=await s(n,e);return p(t)},loadKeyPair:async function(a){let e={object_type:"provider",object_id:this._id,method:"load_key_pair",args:[a]},t=await s(n,e);return m(t)},importKey:async function(a,e){let t=y(e),r={object_type:"provider",object_id:this._id,method:"import_key",args:[a,t]},i=await s(n,r);return p(i)},importKeyPair:async function(a,e,t){let r=y(e),i=y(t),o={object_type:"provider",object_id:this._id,method:"import_key_pair",args:[a,r,i]},d=await s(n,o);return m(d)},importPublicKey:async function(a,e){let t=y(e),r={object_type:"provider",object_id:this._id,method:"import_public_key",args:[a,t]},i=await s(n,r);return m(i)},startEphemeralDhExchange:async function(){let a={object_type:"provider",object_id:this._id,method:"start_ephemeral_dh_exchange",args:[]},e=await s(n,a);return u(e)},getAllKeys:function(){let a={object_type:"provider",object_id:this._id,method:"get_all_keys",args:[]};return s(n,a)},providerName:async function(){let a={object_type:"provider",object_id:this._id,method:"provider_name",args:[]};return s(n,a)},getCapabilities:async function(){let a={object_type:"provider",object_id:this._id,method:"get_capabilities",args:[]};return s(n,a)},deriveKeyFromPassword:async function(a,e,t,r){let i=y(e),o={object_type:"provider",object_id:this._id,method:"derive_key_from_password",args:[a,t,r]},d=await s(n,o);return p(d)},deriveKeyFromBase:async function(a,e,t,r){let i=y(a),o={object_type:"provider",object_id:this._id,method:"derive_key_from_base",args:[i,e,t,r]},d=await s(n,o);return p(d)},getRandom:async function(a){let e={object_type:"provider",object_id:this._id,method:"get_random",args:[a]},t=await s(n,e);return c(t)},hash:async function(a,e){let t=y(a),r={object_type:"provider",object_id:this._id,method:"hash",args:[t,e]},i=await s(n,r);return c(i)}}}l(h,"newProvider");function p(a){return{_id:a,id:function(){return Promise.resolve(this._id)},encryptData:async function(e){let t=y(e),r={object_type:"key",object_id:this._id,method:"encrypt_data",args:[t]},[i,o]=await s(n,r),d=c(i),_=c(o);return[d,_]},decryptData:async function(e,t){let r=y(e),i=y(t),o={object_type:"key",object_id:this._id,method:"decrypt_data",args:[r,i]},d=await s(n,o);return c(d)},hmac:async function(e){let t=y(e),r={object_type:"key",object_id:this._id,method:"hmac",args:[t]},i=await s(n,r);return c(i)},verifyHmac:async function(e,t){let r=y(e),i=y(t),o={object_type:"key",object_id:this._id,method:"verify_hmac",args:[r,i]};return s(n,o)},delete:async function(){let e={object_type:"key",object_id:this._id,method:"delete",args:[]};s(n,e)},extractKey:async function(){let e={object_type:"key",object_id:this._id,method:"extract_key",args:[]},t=await s(n,e);return c(t)},spec:async function(){let e={object_type:"key",object_id:this._id,method:"spec",args:[]};return s(n,e)}}}l(p,"newKeyHandle");function m(a){return{_id:a,id(){return Promise.resolve(this._id)},encryptData:async function(e){let t=y(e),r={object_type:"key_pair",object_id:this._id,method:"encrypt_data",args:[t]},i=await s(n,r);return c(i)},decryptData:async function(e){let t=y(e),r={object_type:"key_pair",object_id:this._id,method:"decrypt_data",args:[t]},i=await s(n,r);return c(i)},signData:async function(e){let t=await y(e),r={object_type:"key_pair",object_id:this._id,method:"sign_data",args:[t]},i=await s(n,r);return c(i)},verifySignature:async function(e,t){let r=await y(e),i=await y(t),o={object_type:"key_pair",object_id:this._id,method:"verify_signature",args:[r,i]};return s(n,o)},delete:async function(){let e={object_type:"key_pair",object_id:this._id,method:"delete",args:[]};s(n,e)},getPublicKey:async function(){let e={object_type:"key_pair",object_id:this._id,method:"extract_public_key",args:[]},t=await s(n,e);return c(t)},extractKey:async function(){let e={object_type:"key_pair",object_id:this._id,method:"extract_key",args:[]},t=await s(n,e);return c(t)},spec:async function(){let e={object_type:"key_pair",object_id:this._id,method:"spec",args:[]};return s(n,e)}}}l(m,"newKeyPairHandle");function u(a){return{_id:a,id:async function(){return this._id},getPublicKey:async function(){let e={object_type:"dh_exchange",object_id:this._id,method:"get_public_key",args:[]},t=await s(n,e);return c(t)},deriveClientSessionKeys:async function(e){let t=y(e),r={object_type:"dh_exchange",object_id:this._id,method:"derive_client_session_keys",args:[t]},[i,o]=await s(n,r),d=c(i),_=c(o);return[d,_]},deriveServerSessionKeys:async function(e){let t=y(e),r={object_type:"dh_exchange",object_id:this._id,method:"derive_server_session_keys",args:[t]},[i,o]=await s(n,r),d=c(i),_=c(o);return[d,_]},deriveClientKeyHandles:async function(e){let t=y(e),r={object_type:"dh_exchange",object_id:this._id,method:"derive_client_key_handles",args:[t]},[i,o]=await s(n,r),d=p(i),_=p(o);return[d,_]},deriveServerKeyHandles:async function(e){let t=y(e),r={object_type:"dh_exchange",object_id:this._id,method:"derive_server_key_handles",args:[t]},[i,o]=await s(n,r),d=p(i),_=p(o);return[d,_]}}}l(u,"newDhKeyExchange");var f={createProvider:b,createProviderFromName:v,getAllProviders:K,getProviderCapabilities:U,provider:h,keyHandle:p,keyPairHandle:m,dhKeyExchange:u};window.cryptoInit=f;})();
