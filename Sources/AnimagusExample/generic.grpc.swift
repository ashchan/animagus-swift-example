//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: generic.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import Foundation
import GRPC
import NIO
import NIOHTTP1
import SwiftProtobuf


/// Usage: instantiate Generic_GenericServiceClient, then call methods of this protocol to make API calls.
internal protocol Generic_GenericServiceClientProtocol {
  func call(_ request: Generic_GenericParams, callOptions: CallOptions?) -> UnaryCall<Generic_GenericParams, Ast_Value>
  func stream(_ request: Generic_GenericParams, callOptions: CallOptions?, handler: @escaping (Ast_Value) -> Void) -> ServerStreamingCall<Generic_GenericParams, Ast_Value>
}

internal final class Generic_GenericServiceClient: GRPCClient, Generic_GenericServiceClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions

  /// Creates a client for the generic.GenericService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  internal init(channel: GRPCChannel, defaultCallOptions: CallOptions = CallOptions()) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
  }

  /// Unary call to Call
  ///
  /// - Parameters:
  ///   - request: Request to send to Call.
  ///   - callOptions: Call options; `self.defaultCallOptions` is used if `nil`.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func call(_ request: Generic_GenericParams, callOptions: CallOptions? = nil) -> UnaryCall<Generic_GenericParams, Ast_Value> {
    return self.makeUnaryCall(path: "/generic.GenericService/Call",
                              request: request,
                              callOptions: callOptions ?? self.defaultCallOptions)
  }

  /// Server streaming call to Stream
  ///
  /// - Parameters:
  ///   - request: Request to send to Stream.
  ///   - callOptions: Call options; `self.defaultCallOptions` is used if `nil`.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ServerStreamingCall` with futures for the metadata and status.
  internal func stream(_ request: Generic_GenericParams, callOptions: CallOptions? = nil, handler: @escaping (Ast_Value) -> Void) -> ServerStreamingCall<Generic_GenericParams, Ast_Value> {
    return self.makeServerStreamingCall(path: "/generic.GenericService/Stream",
                                        request: request,
                                        callOptions: callOptions ?? self.defaultCallOptions,
                                        handler: handler)
  }

}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Generic_GenericServiceProvider: CallHandlerProvider {
  func call(request: Generic_GenericParams, context: StatusOnlyCallContext) -> EventLoopFuture<Ast_Value>
  func stream(request: Generic_GenericParams, context: StreamingResponseCallContext<Ast_Value>) -> EventLoopFuture<GRPCStatus>
}

extension Generic_GenericServiceProvider {
  internal var serviceName: String { return "generic.GenericService" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handleMethod(_ methodName: String, callHandlerContext: CallHandlerContext) -> GRPCCallHandler? {
    switch methodName {
    case "Call":
      return UnaryCallHandler(callHandlerContext: callHandlerContext) { context in
        return { request in
          self.call(request: request, context: context)
        }
      }

    case "Stream":
      return ServerStreamingCallHandler(callHandlerContext: callHandlerContext) { context in
        return { request in
          self.stream(request: request, context: context)
        }
      }

    default: return nil
    }
  }
}


// Provides conformance to `GRPCPayload` for request and response messages
extension Generic_GenericParams: GRPCProtobufPayload {}
extension Ast_Value: GRPCProtobufPayload {}
