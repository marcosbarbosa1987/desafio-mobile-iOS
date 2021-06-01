//
//  Model.swift
//  Domain
//
//  Created by Marcos Barbosa on 31/05/21.
//

import Foundation




public protocol Model: Codable, Equatable {}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
