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

protocol MD5Generator {
    func generate(with timestamp: Int64?)
}

class RemoteGetCaracteres {
   
    let httpGetCaracter: HttpGetCaracter!
    let md5Generator: MD5Generator!
    let baseUrl: URL!
    var timestamp: Int64?
    
    init(url: URL, httpGetCaracter: HttpGetCaracter, md5Generator: MD5Generator) {
        self.baseUrl = url
        self.httpGetCaracter = httpGetCaracter
        self.md5Generator = md5Generator
        timestamp = Date().currentTimeMillis()
    }
    
    func createTimestamp() {
        md5Generator.generate(with: timestamp)
    }
    
    func requestCaracteres() {
        httpGetCaracter.get(url: baseUrl)
    }
}

class DataTests: XCTestCase {
    
    func test_if_get_should_call_correct_url() {
        let url = URL(string: "http://any-url.com")!
        let (sut, httpGetCaracterSpy, _) = makeSut(url: url)
        sut.requestCaracteres()
        XCTAssertEqual(httpGetCaracterSpy.url, [url])
    }
    
    func test_if_get_timestamp() {
        let (sut, _, md5GeneratorSpy) = makeSut()
        md5GeneratorSpy.generate(with: sut.timestamp)
        XCTAssertNotNil(md5GeneratorSpy.timestamp)
    }
}

extension DataTests {
    
    func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (RemoteGetCaracteres, HttpGetCaracterSpy, MD5GeneratorSpy) {
        let httpGetCaracterSpy = HttpGetCaracterSpy()
        let md5GeneratorSpy = MD5GeneratorSpy()
        let sut = RemoteGetCaracteres(url: url, httpGetCaracter: httpGetCaracterSpy, md5Generator: md5GeneratorSpy)
        return (sut, httpGetCaracterSpy, md5GeneratorSpy)
    }
}

class HttpGetCaracterSpy: HttpGetCaracter {
    
    var url: [URL] = []
    
    func get(url: URL) {
        self.url.append(url)
    }
}

class MD5GeneratorSpy: MD5Generator {
    
    var timestamp: Int64?
    
    func generate(with timestamp: Int64?) {
        self.timestamp = timestamp
    }
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
