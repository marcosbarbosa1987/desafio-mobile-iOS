//
//  DataTests.swift
//  DataTests
//
//  Created by Marcos Barbosa on 31/05/21.
//

import XCTest
import Domain

protocol HttpGetCaracter {
    func get(url: URL)
}

class RemoteGetCaracteres {
   
    let url: URL!
    let httpGetCaracter: HttpGetCaracter!
    
    init(url: URL, httpGetCaracter: HttpGetCaracter) {
        self.url = url
        self.httpGetCaracter = httpGetCaracter
    }
    
    func requestCaracteres() {
        httpGetCaracter.get(url: url)
    }
}

class DataTests: XCTestCase {
    
    func test_if_get_should_call_correct_url() {
        let url = URL(string: "http://any-url.com")!
        let (sut, httpGetcaracterSpy) = makeSut(url: url)
        sut.requestCaracteres()
        XCTAssertEqual(httpGetcaracterSpy.url, [url])
    }
}

extension DataTests {
    
    func makeSut(url: URL) -> (RemoteGetCaracteres, HttpGetCaracterSpy) {
        let httpGetCaracterSpy = HttpGetCaracterSpy()
        let sut = RemoteGetCaracteres(url: url, httpGetCaracter: httpGetCaracterSpy)
        return (sut, httpGetCaracterSpy)
    }
}

class HttpGetCaracterSpy: HttpGetCaracter {
    
    var url: [URL] = []
    
    func get(url: URL) {
        self.url.append(url)
    }
}
