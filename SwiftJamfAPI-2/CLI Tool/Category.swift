//
//  Category.swift
//  jamf_list
//
//  Created by Armin Briegel on 2022-09-19.
//

import Foundation

struct Category: Codable {
  var id: String
  var name: String
  var priority: Int
}

struct CategoryResults: Codable {
  var totalCount: Int
  var results: [Category]
}
