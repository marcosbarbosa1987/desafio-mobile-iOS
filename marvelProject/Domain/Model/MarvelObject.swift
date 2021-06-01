//
//  MarvelObject.swift
//  Domain
//
//  Created by Marcos Barbosa on 31/05/21.
//

import Foundation

public struct MavelObject: Model {
    public var code: Int
    public var status: String?
    public var copyright: String?
    public var attributionText: String?
    public var attributionHTML: String?
    public var etag: String?
    public var data: Data?
}
