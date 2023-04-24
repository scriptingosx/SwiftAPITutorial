//
//  ConnectSheet.swift
//  JamfList
//
//  Created by Armin Briegel on 2022-12-21.
//

import SwiftUI

struct ConnectSheet: View {
  @Binding var show: Bool
  @ObservedObject var controller: JamfController
  
  @State var saveInKeychain: Bool = false

  @AppStorage("server") var server = ""
  @AppStorage("username") var username = ""

  var body: some View {
    VStack {
      VStack {
        Form {
          TextField("Jamf Server URL", text: $server)
            .frame(width: 400)
          TextField("Username", text: $username)
          SecureField("Password", text: $controller.password)
          Toggle("Save in Keychain", isOn: $saveInKeychain)
        }
      }.padding()
      HStack {
        Spacer()
        Button("Cancel") {
          show = false
        }
        .keyboardShortcut(.escape)
        Button("Connect") {
          Task { await connect() }
        }
        .keyboardShortcut(.defaultAction)
      }.padding()
    }
  }
  
  func connect() async {
    // hide this sheet
    show = false
    
    if saveInKeychain {
      try? Keychain.save(password: controller.password, service: server, account: username)
    }
    
    await controller.load()
  }
}

struct ConnectSheet_Previews: PreviewProvider {
    static var previews: some View {
      ConnectSheet(show: .constant(true), controller: JamfController())
    }
}
