//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftNIO open source project
//
// Copyright (c) 2026 Apple Inc. and the SwiftNIO project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftNIO project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

public import NIOCore

@available(anyAppleOS 27, *)
extension ChannelOptions.Types {
    /// Get the smoothed round trip of a QUIC connection's active path (RFC 9002, Section 5.3), read afresh from the
    /// connection's estimator, `nil` while it has no path or once it has closed. Before the first sample the estimator
    /// holds the initial round trip, 333 ms; a completed handshake has taken at least one.
    /// Available on connection channels.
    public struct QUICSmoothedRoundTripChannelOption: ChannelOption, Sendable {
        public typealias Value = Duration?
    }
}

@available(anyAppleOS 27, *)
extension ChannelOption where Self == ChannelOptions.Types.QUICSmoothedRoundTripChannelOption {
    /// Get the smoothed round trip of a QUIC connection's active path, `nil` while it has none.
    public static var quicSmoothedRoundTrip: Self { .init() }
}
