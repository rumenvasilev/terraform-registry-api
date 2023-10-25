$version: "2"

namespace tf.registry.provider

use tf.registry.shapes#Arch
use tf.registry.shapes#Filename
use tf.registry.shapes#GPGKeyID
use tf.registry.shapes#OS
use tf.registry.shapes#Protocol
use tf.registry.shapes#SHASum
use tf.registry.shapes#SemVer

resource Provider {
    identifiers: {namespace: String, type: String, version: SemVer}
    read: GetProviderVersion
    list: ListProviderVersions
}

// https://registry.opentofu.org/v1/providers/hashicorp/aws/5.20.1/download/darwin/amd64
@suppress(["HttpUriConflict"])
@readonly
@http(method: "GET", uri: "/v1/providers/{namespace}/{type}/{version}/download/{os}/{arch}", code: 200)
operation GetProviderVersion {
    input: GetProviderVersionInput
    output: GetProviderVersionOutput
}

@input
structure GetProviderVersionInput {
    @required
    @httpLabel
    @length(min: 2)
    namespace: String = "hashicorp"

    @required
    @httpLabel
    type: String = "aws"

    @required
    @httpLabel
    version: SemVer = "5.20.1"

    @required
    @httpLabel
    os: String = "darwin"

    @required
    @httpLabel
    arch: String = "amd64"
}

@output
structure GetProviderVersionOutput {
    @required
    arch: Arch

    // https://github.com/opentofu/terraform-provider-aws/releases/download/v5.20.1/terraform-provider-aws_5.20.1_darwin_amd64.zip
    @required
    @jsonName("download_url")
    downloadUrl: String

    @required
    filename: Filename

    // darwin
    @required
    os: OS

    // 5.0
    @required
    protocols: Protocols

    // 8d356f2b0f67e9a048f0dafa463541cc0965021364cb689c3481195b304fdbab
    @required
    shasum: SHASum

    // https://github.com/opentofu/terraform-provider-aws/releases/download/v5.20.1/terraform-provider-aws_5.20.1_SHA256SUMS
    @required
    @jsonName("shasums_url")
    shasumsUrl: String

    // https://github.com/opentofu/terraform-provider-aws/releases/download/v5.20.1/terraform-provider-aws_5.20.1_SHA256SUMS.sig
    @required
    @jsonName("shasums_signature_url")
    shasumsSignatureUrl: String

    @jsonName("signing_keys")
    signkeys: SigningKeys
}

list Protocols {
    member: Protocol
}

structure SigningKeys {
    @required
    @jsonName("gpg_public_keys")
    gpgpublickeys: GPGPubKeys
}

@length(min: 0)
list GPGPubKeys {
    member: GPGPubKey
}

structure GPGPubKey {
    @jsonName("key_id")
    keyId: GPGKeyID

    @jsonName("ascii_armor")
    asciiArmor: String
}

// /v1/providers/hashicorp/type/versions
@suppress(["HttpUriConflict"])
@readonly
@http(method: "GET", uri: "/v1/providers/{namespace}/{type}/versions", code: 200)
operation ListProviderVersions {
    input: ListProviderVersionsInput
    output: ListProviderVersionsOutput
}

// ^/v1/providers/[^/]+/[^/]+/versions
@input
structure ListProviderVersionsInput {
    @required
    @httpLabel
    @length(min: 2)
    namespace: String = "hashicorp"

    @required
    @httpLabel
    @length(min: 2)
    type: String = "aws"
}

@output
structure ListProviderVersionsOutput {
    @required
    versions: ProviderVersionsList
}

list ProviderVersionsList {
    member: ProviderVersion
}

structure ProviderVersion {
    version: SemVer
    protocols: Protocols
    platforms: Platforms
}

list Platforms {
    member: Platform
}

structure Platform {
    os: OS
    arch: Arch
}
