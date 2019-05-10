//
//  ViewController.swift
//  UIDeviceExample
//
//  Created by giftbot on 2019. 5. 4..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

/***************************************************
 UIDevice
 - 디바이스 이름 / 모델 / 화면 방향 등
 - OS 이름 / 버전
 - 인터페이스 형식 (phone, pad, tv 등)
 - 배터리 정보
 - 근접 센서 정보
 - 멀티태스킹 지원 여부
 ***************************************************/


final class ViewController: UIViewController {
  
  @IBOutlet private weak var label: UILabel!
  let device = UIDevice.current
  let notiCenter = NotificationCenter.default
  
  @IBAction private func systemVersion() {
    print("\n---------- [ System Version ] ----------\n")
    print("System Name :", device.systemName)   // iOS
    print((device.systemVersion as NSString).floatValue)    // 12.2
    
    let systemVersion = device.systemVersion
    print(systemVersion)    // 12.2
    
    let splitVersion = systemVersion.split(separator: ".").compactMap { Int($0) }
    print(splitVersion) // [12, 2]
    
    label.text = systemVersion
    
  }
  
  @IBAction private func architecture() {
    print("\n---------- [ Architecture ] ----------\n")
    
    // iPhone or Simulator 여부
    #if targetEnvironment(simulator)
        print("Simulator")
        label.text = "Simulator"
    #else
        print("Device")
        label.text = "Device"
    #endif
    
    // iOS 여부
    print("TARGET_OS_IOS :", TARGET_OS_IOS)
    
    // Simulator CPU 구분
    print("TARGET_OS_SIMULATOR :", TARGET_OS_SIMULATOR)
    print("TARGET_CPU_X86 :", TARGET_CPU_X86)
    print("TARGET_CPU_X86 :", TARGET_CPU_X86_64)
    
    // Endian 구분
    print("TARGET_RT_LITTLE_ENDIAN :", TARGET_RT_LITTLE_ENDIAN)
    print("TARGET_RT_BIG_ENDIAN :", TARGET_RT_BIG_ENDIAN)
    
    // ARM CPU 여부
    print("TARGET_CPU_ARM :", TARGET_CPU_ARM)
    print("TARGET_CPU_ARM64 :", TARGET_CPU_ARM64)
  }
  
  @IBAction private func deviceModel() {
    print("\n---------- [ Device Model ] ----------\n")
    
    print("name :", device.name)
    print("model :", device.model)
    print("localizedModel :", device.localizedModel)
    print("userInterfaceIdiom :", device.userInterfaceIdiom)
    print("orientation :", device.orientation)
    print("isMultitaskingSupported :", device.isMultitaskingSupported)  // 최신 기기에서는 항상 true
    
    // extension
    print("modelIdentifier :", device.identifier)
    print("modelName :", device.modelName)
    label.text = "\(device.identifier): \(device.modelName)"
    
    print("simulatorModeName :", device.simulatorModelName)
  }
  
  
  // MARK: - Battery
  
  @IBAction private func battery() {
    print("\n-------------------- [ Battery Info ] --------------------\n")
    
    print("batteryState :", device.batteryState)
    print("batteryLevel :", device.batteryLevel)
    print("isBatteryMonitoringEnabled :", device.isBatteryMonitoringEnabled)
    
    label.text = "\(device.batteryState) : \(device.batteryLevel)"
  }
  
  @IBAction private func batteryMonitoring(_ sender: UIButton) {
    print("\n---------- [ batteryMonitoring ] ----------\n")
    
    sender.isSelected.toggle()
    device.isBatteryMonitoringEnabled.toggle()
    
    if device.isBatteryMonitoringEnabled {
        notiCenter.addObserver(self,
                               selector: #selector(didChangeBatteryState(_:)),
                               name: UIDevice.batteryLevelDidChangeNotification,
                               object: nil)
    } else {
        notiCenter.removeObserver(self,
                                  name: UIDevice.batteryLevelDidChangeNotification,
                                  object: nil)
    }
  }
  
  @objc func didChangeBatteryState(_ noti: Notification) {
    
    guard let device = noti.object as? UIDevice else { return }
    print("batteryState :", device.batteryState)
    print("batteryLevel :", device.batteryLevel)
  }
  
  
  // MARK: - Proximity State
  
  @IBAction private func proximityMonitoring(_ sender: UIButton) {
    print("\n-------------------- [ Proximity Sensor ] --------------------\n")
    
    sender.isSelected.toggle()
    device.isProximityMonitoringEnabled.toggle()
    print("ProximityMonitoring :", device.isProximityMonitoringEnabled)
    
    if device.isProximityMonitoringEnabled {
        notiCenter.addObserver(self,
                               selector: #selector(didChangeProximityState(_:)),
                               name: UIDevice.proximityStateDidChangeNotification,
                               object: nil)
    } else {
        notiCenter.removeObserver(self,
                                  name: UIDevice.proximityStateDidChangeNotification,
                                  object: nil)
    }
  }
  
  @objc func didChangeProximityState(_ noti: Notification) {
    
    print(UIDevice.current.proximityState)
    label.text = "\(UIDevice.current.proximityState)"
  }
  
  
  // MARK: - Orientation Notification
  
  @IBAction private func beginOrientationNotification() {
    
    device.beginGeneratingDeviceOrientationNotifications()
    
    print(device.isGeneratingDeviceOrientationNotifications)
    label.text = "\(device.isGeneratingDeviceOrientationNotifications)"
    
    notiCenter.addObserver(self,
                           selector: #selector(orientationDidChange(_:)),
                           name: UIDevice.orientationDidChangeNotification,
                           object: nil)
  }
  
  @objc func orientationDidChange(_ noti: Notification) {
    print(" ------ Orientation didChange ------ ")
    if let device = noti.object as? UIDevice {
        print("Device Orientation :", device.orientation)
    }
    print("StatusBar Orientation :", UIApplication.shared.statusBarOrientation)
  }
  
  @IBAction private func endOrientationNotification() {
    
    while device.isGeneratingDeviceOrientationNotifications {
        device.endGeneratingDeviceOrientationNotifications()
        print("isGenNoti :", device.isGeneratingDeviceOrientationNotifications)
    }
    notiCenter.removeObserver(self,
                              name: UIDevice.orientationDidChangeNotification,
                              object: nil)
  }
}





