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
    let username = "api_"
    
    // TODO: get this from Keychain
    let password = "secret_password"
    
    // errors thrown in the do block will be processed in the catch block
    do {
      // get authentication token
      let auth = try await JamfAuthToken.get(server: server, username: username, password: password)
      
      // get categories
      let categories = try await Category.getAll(server: server, auth: auth)
      
      for category in categories {
        print(category.id,
              category.name,
              category.priority)
      }
      
      // catch the errors
    } catch JamfAPIError.badURL {
      print("could not create API URL")
      exit(11)
    } catch JamfAPIError.requestFailed {
      print("API request failed")
      exit(12)
    } catch JamfAPIError.http(let statusCode) {
      print("HTTP error: \(statusCode)")
      exit(13)
    } catch JamfAPIError.decode {
      print("could not decode JSON")
      exit(14)
    } catch {
      print("other error: \(error)")
      exit(99)
    }
  }
}
