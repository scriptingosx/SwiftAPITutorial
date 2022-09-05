//
//  JamfAuthToken.swift
//  jamf_list
//
//  Created by Armin Briegel on 2022-09-05.
//

import Foundation

struct JamfAuthToken: Codable {
  var token: String
  var expires: String
}
