//
//  DetailView.swift
//  JamfList
//
//  Created by Armin Briegel on 2022-12-15.
//

import SwiftUI

struct DetailView: View {
  var computer: Computer
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(computer.general.name)
        .font(.title)
      Divider()
      Text(computer.general.lastEnrolledDate.description)
      Text(computer.hardware.serialNumber)
      Text(computer.hardware.appleSilicon
           ? "Apple silicon" : "Intel")
      Text("macOS \(computer.operatingSystem.version)")
      Spacer()
    }
    .padding()
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(computer: Computer.sampleMacBookAir)
  }
}
