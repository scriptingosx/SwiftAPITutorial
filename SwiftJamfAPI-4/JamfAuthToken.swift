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
  
  
  /** Get an authentication Token from the server */
  static func get(server: String, username: String, password: String) async throws -> JamfAuthToken {
    
    // MARK: Prepare Request
    // encode user name and password
    let base64 = "\(username):\(password)"
      .data(using: String.Encoding.utf8)!
      .base64EncodedString()
    
    // assemble the URL for the Jamf API
    guard var components = URLComponents(string: server) else {
      throw JamfAPIError.badURL
    }
    components.path="/api/v1/auth/token"
    guard let url = components.url else {
      throw JamfAPIError.badURL
    }
    
    // MARK: Send Request and get Data
    
    // create the request
    var authRequest = URLRequest(url: url)
    authRequest.httpMethod = "POST"
    authRequest.addValue("Basic " + base64, forHTTPHeaderField: "Authorization")
    
    // send request and get data
    guard let (data, response) = try? await URLSession.shared.data(for: authRequest)
    else {
      throw JamfAPIError.requestFailed
    }
    
    // MARK: Handle Errors
    
    // check the response code
    let authStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
    if authStatusCode != 200 {
      throw JamfAPIError.http(authStatusCode)
    }
    
    // print(String(data: data, encoding: .utf8) ?? "no data")
    
    // MARK: Parse JSON returned
    let decoder = JSONDecoder()
    
    guard let auth = try? decoder.decode(JamfAuthToken.self, from: data)
    else {
      throw JamfAPIError.decode
    }
    
    return auth
  }
}
