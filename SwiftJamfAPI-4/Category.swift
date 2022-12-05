//
//  Category.swift
//  jamf_list
//
//  Created by Armin Briegel on 2022-09-19.
//

import Foundation

struct Category: JamfObject {
  var id: String
  var name: String
  var priority: Int
  
  static let getAllEndpoint = "/api/v1/categories"
}
