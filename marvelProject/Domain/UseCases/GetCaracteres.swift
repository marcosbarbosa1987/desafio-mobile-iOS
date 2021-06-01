//
//  GetCaracteres.swift
//  Domain
//
//  Created by Marcos Barbosa on 31/05/21.
//

import Foundation

public protocol GetCaracteres {
    func requestCaracteres(completion: @escaping(Result<MavelObject?, DomainError>) -> Void)
}
