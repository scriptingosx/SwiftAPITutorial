//
//  JamfAPIError.swift
//  jamf_list
//
//  Created by Armin Briegel on 2022-09-19.
//

import Foundation

enum JamfAPIError: Error {
  case requestFailed
  case http(Int)
  case authentication
  case decode
  case encode
  case badURL
  case noCredentials
}
