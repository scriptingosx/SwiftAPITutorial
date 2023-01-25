//
//  Computer-Sample.swift
//  JamfList
//
//  Created by Armin Briegel on 2022-12-06.
//

import Foundation

// provide sample data items for previews
extension Computer {
  static var samples = [
    Computer.sampleMacBookPro,
    Computer.sampleMacBookAir,
    Computer.sampleMacmini,
    Computer.sampleIMac,
    Computer.sampleMacStudio,
    Computer.sampleMacProGen1,
    Computer.sampleMacProGen2,
    Computer.sampleMacProGen3
  ]
  
  static var sampleMacBookPro: Computer {
    let general = General(
      name: "MacBook Pro",
      lastEnrolledDate: Date.init(timeIntervalSinceNow: -86400.0),
      userApprovedMdm: true
    )
    let hardware = Hardware(
      model: "MacBook Pro",
      modelIdentifier: "MacBookPro1,1",
      serialNumber: "SAMPLE111111",
      appleSilicon: false
    )
    let operatingSystem = OperatingSystem(
      name: "macOS",
      version: "13.0",
      build: "22A100"
    )
    
    let sample = Computer(
      id: "999991",
      general: general,
      hardware: hardware,
      operatingSystem: operatingSystem
    )
    
    return sample
  }
  
  static var sampleMacBookAir: Computer {
    let general = General(
      name: "MacBook Air",
      lastEnrolledDate: Date.init(timeIntervalSinceNow: -172800.0),
      userApprovedMdm: true
    )
    let hardware = Hardware(
      model: "MacBook Air",
      modelIdentifier: "MacBookAir1,1",
      serialNumber: "SAMPLE222222",
      appleSilicon: true
    )
    let operatingSystem = OperatingSystem(
      name: "macOS",
      version: "13.1",
      build: "22C65"
    )
    
    let sample = Computer(
      id: "999992",
      general: general,
      hardware: hardware,
      operatingSystem: operatingSystem
    )
    
    return sample
  }
  
  static var sampleMacmini: Computer {
    let general = General(
      name: "Mac mini",
      lastEnrolledDate: Date.init(timeIntervalSinceNow: -(86400.0 * 4)),
      userApprovedMdm: true
    )
    let hardware = Hardware(
      model: "Mac mini",
      modelIdentifier: "Macmini1,1",
      serialNumber: "SAMPLE333333",
      appleSilicon: false
    )
    let operatingSystem = OperatingSystem(
      name: "macOS",
      version: "12.6.1",
      build: "21G200"
    )
    
    let sample = Computer(
      id: "999993",
      general: general,
      hardware: hardware,
      operatingSystem: operatingSystem
    )
    
    return sample
  }
  
  static var sampleIMac: Computer {
    let general = General(
      name: "iMac",
      lastEnrolledDate: Date.init(timeIntervalSinceNow: -(86400.0 * 8)),
      userApprovedMdm: true
    )
    let hardware = Hardware(
      model: "iMac",
      modelIdentifier: "iMac10,1",
      serialNumber: "SAMPLE444444",
      appleSilicon: false
    )
    let operatingSystem = OperatingSystem(
      name: "macOS",
      version: "12.5",
      build: "21F200"
    )
    
    let sample = Computer(
      id: "999994",
      general: general,
      hardware: hardware,
      operatingSystem: operatingSystem
    )
    
    return sample
  }
  
  static var sampleMacStudio: Computer {
    let general = General(
      name: "Mac Studio",
      lastEnrolledDate: Date.init(timeIntervalSinceNow: -(86400.0 * 12)),
      userApprovedMdm: true
    )
    let hardware = Hardware(
      model: "Mac Studio",
      modelIdentifier: "Mac13,1",
      serialNumber: "SAMPLE555555",
      appleSilicon: false
    )
    let operatingSystem = OperatingSystem(
      name: "macOS",
      version: "13.1",
      build: "22B200"
    )
    
    let sample = Computer(
      id: "999995",
      general: general,
      hardware: hardware,
      operatingSystem: operatingSystem
    )
    
    return sample
  }
  
  static var sampleMacProGen1: Computer {
    let general = General(
      name: "Mac Pro (2010)",
      lastEnrolledDate: Date.init(timeIntervalSinceNow: -(86400.0 * 12)),
      userApprovedMdm: true
    )
    let hardware = Hardware(
      model: "Mac Pro (2010)",
      modelIdentifier: "MacPro4,1",
      serialNumber: "SAMPLE666666",
      appleSilicon: false
    )
    let operatingSystem = OperatingSystem(
      name: "macOS",
      version: "11.7",
      build: "20F200"
    )
    
    let sample = Computer(
      id: "999996",
      general: general,
      hardware: hardware,
      operatingSystem: operatingSystem
    )
    
    return sample
  }
  
  static var sampleMacProGen2: Computer {
    let general = General(
      name: "Mac Pro (2013)",
      lastEnrolledDate: Date.init(timeIntervalSinceNow: -(86400.0 * 16)),
      userApprovedMdm: true
    )
    let hardware = Hardware(
      model: "Mac Pro (2013)",
      modelIdentifier: "MacPro6,1",
      serialNumber: "SAMPLE7777777",
      appleSilicon: false
    )
    let operatingSystem = OperatingSystem(
      name: "macOS",
      version: "11.7",
      build: "20F200"
    )
    
    let sample = Computer(
      id: "999997",
      general: general,
      hardware: hardware,
      operatingSystem: operatingSystem
    )
    
    return sample
  }
  
  static var sampleMacProGen3: Computer {
    let general = General(
      name: "Mac Pro (2019)",
      lastEnrolledDate: Date.init(timeIntervalSinceNow: -(86400.0 * 32)),
      userApprovedMdm: true
    )
    let hardware = Hardware(
      model: "Mac Pro (2019)",
      modelIdentifier: "MacPro7,1",
      serialNumber: "SAMPLE888888",
      appleSilicon: false
    )
    let operatingSystem = OperatingSystem(
      name: "macOS",
      version: "11.7",
      build: "20F200"
    )
    
    let sample = Computer(
      id: "999998",
      general: general,
      hardware: hardware,
      operatingSystem: operatingSystem
    )
    
    return sample
  }
}
