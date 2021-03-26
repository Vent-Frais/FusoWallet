# Swift SCALE Codec

![🐧 linux: ready](https://img.shields.io/badge/%F0%9F%90%A7%20linux-ready-red.svg)
[![GitHub license](https://img.shields.io/badge/license-Apache%202.0-lightgrey.svg)](LICENSE)
[![Build Status](https://github.com/tesseract-one/swift-scale-codec/workflows/CI/badge.svg?branch=main)](https://github.com/tesseract-one/swift-scale-codec/actions?query=workflow%3ACI+branch%3Amain)
[![GitHub release](https://img.shields.io/github/release/tesseract-one/swift-scale-codec.svg)](https://github.com/tesseract-one/swift-scale-codec/releases)
[![SPM compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![CocoaPods version](https://img.shields.io/cocoapods/v/ScaleCodec.svg)](https://cocoapods.org/pods/ScaleCodec)
![Platform OS X | iOS | tvOS | watchOS | Linux](https://img.shields.io/badge/platform-Linux%20%7C%20OS%20X%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS-orange.svg)

Swift implementation of the SCALE (Simple Concatenated Aggregate Little-Endian) data format
for types used in the Parity Substrate framework.

SCALE is a light-weight format which allows encoding (and decoding) which makes it highly
suitable for resource-constrained execution environments like blockchain runtimes and low-power,
low-memory devices.

It is important to note that the encoding context (knowledge of how the types and data structures look)
needs to be known separately at both encoding and decoding ends.
The encoded data does not include this contextual information.

To get a better understanding of how the encoding is done for different types,
take a look at the
[low-level data formats overview page at the Substrate docs site](https://substrate.dev/docs/en/knowledgebase/advanced/codec).

## Installation

ScaleCodec deploys to macOS 10.10, iOS 9, watchOS 2, tvOS 9 and Linux. It has been tested on the latest OS releases only however, as the module uses very few platform-provided APIs, there should be very few issues with earlier versions.

ScaleCodec uses no APIs specific to Apple platforms, so it should be easy to port it to other operating systems.

Setup instructions:

- **Swift Package Manager:**
  Add this to the dependency section of your `Package.swift` manifest:

    ```Swift
    .package(url: "https://github.com/tesseract-one/swift-scale-codec.git", from: "0.2.0")
    ```

- **CocoaPods:** Put this in your `Podfile`:

    ```Ruby
    pod 'ScaleCodec', '~> 0.2'
    ```

## Usage Examples

Following are some examples to demonstrate usage of the codec.

### Simple Types

Codec supports `String`, `Data`, `Bool`, `Int[8-64]` and `UInt[8-64]` types.

```Swift
import ScaleCodec

let data = Data([0xff, 0xff, 0xff, 0xff])

let encoded = try SCALE.default.encode(UInt32.max)
assert(encoded == data)

let uint32 = try SCALE.default.decode(UInt32.self, from: data)
assert(uint32 == UInt32.max)
```

#### Compact encoding

`UInt[8-64]`, `SUInt[128-512]` and  `BigUInt` types can be encoded with compact encoding. This allows `BigUInt` to store values up to `2^536-1`.

ScaleCodec has special wrapper type `SCompact` which encodes and decodes values in this format and two helper methods.

Example:

```Swift
import ScaleCodec

let data = Data([0x07, 0x00, 0x00, 0x00, 0x00, 0x01])

let encoded = try SCALE.default.encode(UInt64(1 << 32), .compact)
assert(encoded == data))

let compact = try SCALE.default.decode(UInt64.self, .compact, from: data)
assert(compact == UInt64(1 << 32))

// without helper methods
// let encoded = try SCALE.default.encode(SCompact(UInt64(1 << 32)))
// let compact = try SCALE.default.decode(SCompact<UInt64>.self, from: data).value
```

#### Int[128-512] and UInt[128-512]

`Int[128-512]` and `UInt[128-512]` types implemented as `BigInt` and `BigUInt` Swift types. For proper encoding ScaleCodec has `SInt[128-512]` and `SUInt[128-512]` wrappers. Decoder and encoder has extension methods for simpler usage.

```Swift
import ScaleCodec

let data = Data([
    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
])

let encoded = try SCALE.default.encode(BigUInt(2).pow(128) - 1, .b128)
assert(encoded == data))

let compact = try SCALE.default.decode(BigUInt.self, .b128, from: data)
assert(compact == BigUInt(2).pow(128) - 1)

// without helper methods
// let encoded = try SCALE.default.encode(SUInt256(BigUInt(2).pow(128) - 1))
// let compact = try SCALE.default.decode(SUInt256.self, from: data).int
```

#### Data fixed encoding

`Data` type can be encoded with fixed encoding. In this mode data length will not be stored so length should be provided manually.

```Swift
import ScaleCodec

let data = Data([0x07, 0x00, 0x00, 0x00, 0x00, 0x01]

let encoded = try SCALE.default.encoder().encode(data, .fixed(6)).output
assert(encoded == data))

let decoded = try SCALE.default.decoder(data: encoded).decode(Data.self, .fixed(6))
assert(decoded == encoded == data)
```

### Container types

ScaleCodec can encode and decode standard containers. Supported containers: `Optional`, `Result`, `Array`, `Set`, `Dictionary`. Containers can be nested in each other. Container element should be encodable.

```Swift
import ScaleCodec

let array: [UInt32] = [1, 2, 3, 4, 5]

let data = try SCALE.default.encode(array)

let decoded: [UInt32] = try SCALE.default.decode(from: data)

assert(array == decoded)
```

#### Fixed Arrays

`Array` can be encoded in fixed encoding the same way as `Data`. Length should be provided manually.

```Swift
import ScaleCodec

let array: [UInt32] = [1, 2, 3, 4, 5]

let data = try SCALE.default.encode(array, .fixed(5))

let decoded: [UInt32] = try SCALE.default.decode(.fixed(5), from: data)

assert(array == decoded)
```


### Tuples

Tuple encoding and decoding supported through `STuple*` set of wrappers. ScaleCodec provides `STuple()` helper which can create approptiate `STuple*` instance for a tuple. `STuple*` wrappers can be nested to support bigger tuples. ScaleCodec also has set of helper methods for tuples support. 

```Swift
import ScaleCodec

let tuple = (UInt32.max, "Hello")

let encoded = try SCALE.default.encode(tuple)

let decoded: (UInt32, String) = try SCALE.default.decode(from: encoded)

assert(tuple == decoded)

// without helper methods
// let encoded = try SCALE.default.encode(STuple(tuple)) // or directly STuple2(tuple)
// let decoded = try SCALE.default.decode(STuple2<UInt32, String>.self, from: encoded).tuple
```

### Enums

#### Simple enums

Simple enums without associated values can be encoded automatically if enum supports `CaseIterable` protocol. Swift has autoimplementation feature for `CaseIterable` protocol for simple enums.

```Swift
import ScaleCodec

enum Test: CaseIterable, ScaleCodable {
  case A
  case B
}

let data = try SCALE.default.encode(Test.A)

let decoded: Test = try SCALE.default.decode(from: data)

assert(decoded == Test.A)
```

#### Complex enums

Encoding and decoding for complex enums with associated values should be implemented manually. Two protocols need to be implemented: `ScaleEncodable` and `ScaleDecodable` (`ScaleCodable` can be used as common alias).

```Swift
import ScaleCodec

enum Test: ScaleCodable {
  case A(String?)
  case B(UInt32, String) // UInt32 will use Compact encoding.
  
  init(from decoder: ScaleDecoder) throws {
    let opt = try decoder.decode(.enumCaseId)
    switch opt {
    case 0: self = try .A(decoder.decode())
    case 1: self = try .B(decoder.decode(.compact), decoder.decode())
    default: throw decoder.enumCaseError(for: opt)
    }
  }
  
  func encode(in encoder: ScaleEncoder) throws {
    switch self {
    case .A(let str): try encoder.encode(0, .enumCaseId).encode(str)
    case .B(let int, let str): try encoder.encode(1, .enumCaseId).encode(int, .compact).encode(str)
    }
  }
}

let val = Test.B(100, "World!")

let data = try SCALE.default.encode(val)

let decoded: Test = try SCALE.default.decode(from: data)

assert(decoded == val)
```

### Classes and Structures

`ScaleEncodable` and `ScaleDecodable` should be implemented for classes and structures. `ScaleEncoder` and  `ScaleDecoder` have helpers methods for standard containers and types.

```Swift
import ScaleCodec

struct Test: ScaleCodable, Equatable {
  let var1: String?
  let var2: BigUInt // will use Compact encoding.
  let var3: [UInt32] // UInt32 will use Compact encoding.
  
  init(_ v1: String?, _ v2: BigUInt, _ v3: [UInt32]) {
    var1 = v1; var2 = v2; var3 = v3
  }
  
  init(from decoder: ScaleDecoder) throws {
    var1 = try decoder.decode()
    var2 = try decoder.decode(.compact)
    var3 = try decoder.decode(Array<SCompact<UInt32>>.self).map { $0.value }
  }
  
  func encode(in encoder: ScaleEncoder) throws {
    try encoder
      .encode(var1)
      .encode(var2, .compact)
      .encode(var3.map { SCompact($0) })
  }
}

let val = Test(nil, 123456789, [1, 2, 3, 4, 5])

let data = try SCALE.default.encode(val)

let decoded: Test = try SCALE.default.decode(from: data)

assert(decoded == val)
```

#### Fixed classes and structures

Classes and structures can be created from fixed encoded `Array` and `Data` object. For convenience ScaleCodec has two sets of protocols: (`ScaleFixedEncodable`, `ScaleFixedDecodable`) and (`ScaleFixedDataEncodable`, `ScaleFixedDataDecodable`).

Example:

```Swift
import ScaleCodec

struct StringArray4: Equatable, ScaleFixed {
    typealias Element = String // Fixed Array element type
    
    static var fixedElementCount: Int = 4 // amount of elements in Fixed Array
    
    var array: [String]
    
    init(_ array: [String]) {
        self.array = array
    }
    
    init(decoding values: [String]) throws { // decoding from Fixed Array
        self.init(values)
    }
    
    func encode() throws -> [String] { // encoding to Fixed Array
        return self.array
    }
}

private struct Data4: Equatable, ScaleFixedData {
    var data: Data
    
    static var fixedBytesCount: Int = 4 // amount of bytes in Fixed Data
    
    init(_ data: Data) {
        self.data = data
    }
    
    init(decoding data: Data) throws { // decoding from Fixed Data
        self.init(data)
    }
    
    func encode() throws -> Data { // encoding to Fixed Data
        return self.data
    }
}

let string4 = StringArray4(["1", "2", "3", "4"])

let dataS4 = try SCALE.default.encode(string4)

let decoded: StringArray4 = try SCALE.default.decode(from: dataS4)

assert(decoded == string4)

let data4 = Data4(Data([1, 2, 3, 4]))

let dataE4 = try SCALE.default.encode(data4)

let decoded: Data4 = try SCALE.default.decode(from: dataE4)

assert(decoded == data4)

```

## License

ScaleCodec can be used, distributed and modified under [the Apache 2.0 license](LICENSE).
