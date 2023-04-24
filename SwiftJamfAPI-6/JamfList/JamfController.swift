//
//  JamfController.swift
//  JamfList
//
//  Created by Armin Briegel on 2022-12-20.
//

import Foundation

class JamfController: ObservableObject {
  @Published var computers: [Computer] = []
  
  @Published var isLoading = false
  @Published var needsCredentials = false
  @Published var connected = false
  @Published var hasError = false
  
  var server: String { UserDefaults.standard.string(forKey: "server") ?? "" }
  var username: String { UserDefaults.standard.string(forKey: "username") ?? "" }
  var password = ""
  
  var auth: JamfAuthToken?
  
  @MainActor
  func load() async {
    isLoading = true
    defer {
      isLoading = false
    }
    
    if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
      // preview mode return sample data
      computers = Computer.samples
      return
    }
    
    // not in preview mode
    
    // attempt to get an auth token
    await connect()

    // only continue if connected
    guard connected, let auth = auth else { return }

    if let fetchedComputers = try? await Computer.getAll(server: server, auth: auth) {
      computers = fetchedComputers
    } else {
      hasError = true
    }
  }
  
  @MainActor
  func connect() async {
    // do we have all credentials?
    if server.isEmpty || username.isEmpty {
      needsCredentials = true
      connected = false
      return
    }
    
    if password.isEmpty {
      // try to get password from keychain
      guard let pwFromKeychain = try? Keychain.getPassword(service: server, account: username)
      else {
        needsCredentials = true
        connected = false
        return
      }
      password = pwFromKeychain
    }
    
    if auth == nil {
      // no token yet, get one
      auth = try? await JamfAuthToken.get(server: server, username: username, password: password)
      if auth == nil {
        // couldn't get a token, most likely the credentials are wrong
        hasError = true
        needsCredentials = true
        connected = false
        return
      }
    }
    
    // we have a token, all is good
    needsCredentials = false
    hasError = false
    connected = true
  }

}
