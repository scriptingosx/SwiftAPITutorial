//
//  Computer.swift
//  jamf_list
//
//  Created by Armin Briegel on 2022-09-19.
//

import Foundation

struct Computer: JamfObject {
  
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
  
  // MARK: JamfObject implementation
  static let getAllEndpoint = "/api/v1/computers-inventory"
  
  // override getAllURLComponents to add query items
  static func getAllURLComponents(server: String) throws -> URLComponents {
    guard var components = URLComponents(string: server)
    else {
      throw JamfAPIError.badURL
    }
    components.path = self.getAllEndpoint
    
    components.queryItems = [ URLQueryItem(name: "section", value: "GENERAL"),
                              URLQueryItem(name: "section", value: "HARDWARE"),
                              URLQueryItem(name: "section", value: "OPERATING_SYSTEM"),
                              URLQueryItem(name: "sort", value: "id:asc") ]
    return components
  }
}
