//
//  JamfList.swift
//  jamf_list
//
//  Created by Armin Briegel on 2022-09-05.
//

import Foundation

@main
struct JamfList {
  static func main() async {
    let server = "https://jamf.example.com"
    let username = "api_user"
    
    // TODO: get this from Keychain
    let password = "secret_password"
    
    // MARK: Get Jamf Auth Token
    
    // MARK: Prepare Request
    // encode user name and password
    let base64 = "\(username):\(password)"
        .data(using: String.Encoding.utf8)!
        .base64EncodedString()
    
    // assemble the URL for the Jamf API
    guard var components = URLComponents(string: server) else {
        exit(1)
    }
    components.path="/api/v1/auth/token"
    guard let url = components.url else {
        exit(1)
    }
    
    // MARK: Send Request and get Data
    
    // create the request
    var authRequest = URLRequest(url: url)
    authRequest.httpMethod = "POST"
    authRequest.addValue("Basic " + base64, forHTTPHeaderField: "Authorization")

    // send request and get data
    guard let (data, response) = try? await URLSession.shared.data(for: authRequest)
    else {
      exit(1)
    }

    // MARK: Handle Errors
    
    // check the response code
    let authStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
    if authStatusCode != 200 {
        exit(1)
    }

    // print(String(data: data, encoding: .utf8) ?? "<no data>")

    
    // MARK: Parse JSON returned
    let decoder = JSONDecoder()
                
    guard let auth = try? decoder.decode(JamfAuthToken.self, from: data)
    else {
        exit(1)
    }
        
    // print("Token: \(auth.token)")
    // print("Expires: \(auth.expires)")

    // MARK: Get Categories
   
   // MARK: Prepare Request
   // assemble the URL for the Jamf API
   guard var components = URLComponents(string: server)
   else {
       exit(1)
   }
   components.path="/api/v1/categories"
   guard let url = components.url
   else {
       exit(1)
   }
   
   // MARK: Send Request and get Data
   // create the request
   var request = URLRequest(url: url)
   request.httpMethod = "GET"
   request.addValue("Bearer " + auth.token, forHTTPHeaderField: "Authorization")
   
   // send request and get data
   guard let (data, response) = try? await URLSession.shared.data(for: request)
   else {
     exit(1)
   }
   
   // MARK: Handle Error
   // check the response code
   let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
   if statusCode != 200 {
       // error getting token
       exit(1)
   }
   
   print(String(data: data, encoding: .utf8) ?? "<no data>")

  }
}
