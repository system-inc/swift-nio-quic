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

/// The TLS exporter of a QUIC connection whose handshake completed (RFC 8446, Section 7.5; RFC 9001, Section 5).
public struct QUICTLSExporter: Sendable {
    let exportKeyingMaterialFunction: @Sendable (String, [UInt8], Int) -> [UInt8]?

    /// Derives `length` bytes of keying material bound to this connection. In TLS 1.3 an absent context and
    /// an empty one give the same bytes. `nil` if the bytes cannot be derived.
    public func exportKeyingMaterial(label: String, context: [UInt8] = [], length: Int) -> [UInt8]? {
        self.exportKeyingMaterialFunction(label, context, length)
    }
}

extension ChannelOptions.Types {
    /// Get the TLS exporter of a QUIC connection, `nil` until its handshake completes.
    /// Available on connection channels.
    public struct QUICTLSExporterChannelOption: ChannelOption, Sendable {
        public typealias Value = QUICTLSExporter?
    }
}

extension ChannelOption where Self == ChannelOptions.Types.QUICTLSExporterChannelOption {
    /// Get the TLS exporter of a QUIC connection, `nil` until its handshake completes.
    public static var quicTLSExporter: Self { .init() }
}
