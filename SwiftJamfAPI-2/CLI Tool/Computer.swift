//
//  Computer.swift
//  jamf_list
//
//  Created by Armin Briegel on 2022-09-19.
//

import Foundation

struct Computer: Codable {
    struct General: Codable {
        var name: String
        var assetTag: String?
        var lastEnrolledDate: Date
        var userApprovedMdm: Bool
    }
    
    struct Hardware: Codable {
        var model: String
        var modelIdentifier: String
        var serialNumber: String
        var appleSilicon: Bool
    }
    
    struct OperatingSystem: Codable {
        var name: String
        var version: String
        var build: String
    }
    
    var id: String
    var general: General
    var hardware: Hardware
    var operatingSystem: OperatingSystem
}

struct ComputerResults: Codable {
  var totalCount: Int
  var results: [Computer]
}
