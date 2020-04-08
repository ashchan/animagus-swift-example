import Foundation

func buildAst(_ t: Ast_Value.TypeEnum, builder: (inout Ast_Value) -> Void) -> Ast_Value {
    var value = Ast_Value()
    value.t = t
    builder(&value)
    return value
}

/*
The following foundation extensions are from [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift).
Copyright (C) 2014-2017 Marcin Krzyżanowski marcin@krzyzanowskim.com This software is provided 'as-is', without any express or implied warranty.
In no event will the authors be held liable for any damages arising from the use of this software.
Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation is required.
Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
This notice may not be removed or altered from any source or binary distribution.
Redistributions of any form whatsoever must retain the following acknowledgment: 'This product includes software developed by the "Marcin Krzyzanowski" (http://krzyzanowskim.com/).'
*/

public extension Array {
    init(reserveCapacity: Int) {
      self = Array<Element>()
      self.reserveCapacity(reserveCapacity)
    }
}

public extension Array where Element == UInt8 {
  init(hex: String) {
    self.init(reserveCapacity: hex.unicodeScalars.lazy.underestimatedCount)
    var buffer: UInt8?
    var skip = hex.hasPrefix("0x") ? 2 : 0
    for char in hex.unicodeScalars.lazy {
      guard skip == 0 else {
        skip -= 1
        continue
      }
      guard char.value >= 48 && char.value <= 102 else {
        removeAll()
        return
      }
      let v: UInt8
      let c: UInt8 = UInt8(char.value)
      switch c {
        case let c where c <= 57:
          v = c - 48
        case let c where c >= 65 && c <= 70:
          v = c - 55
        case let c where c >= 97:
          v = c - 87
        default:
          removeAll()
          return
      }
      if let b = buffer {
        append(b << 4 | v)
        buffer = nil
      } else {
        buffer = v
      }
    }
    if let b = buffer {
      append(b)
    }
  }

  func toHexString() -> String {
    `lazy`.reduce(into: "") {
      var s = String($1, radix: 16)
      if s.count == 1 {
        s = "0" + s
      }
      $0 += s
    }
  }
}

public extension Data {
    init(hex: String) {
      self.init(Array<UInt8>(hex: hex))
    }

    var bytes: Array<UInt8> {
      Array(self)
    }

    func toHexString() -> String {
      self.bytes.toHexString()
    }
}
