//
//  ViewController.swift
//  BluetoothLE
//
//  Created by Denis Efremov on 2020-01-10.
//  Copyright © 2020 Denis Efremov. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate {
    
    var centralManager: CBCentralManager!
    var myPeripheral: CBPeripheral?

    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager.init(delegate: self, queue: nil)
    }

    // MARK: - CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
            print("Scanning...")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.name?.contains("Hocus Pocus") == true {
            print(peripheral.name ?? "no name")
            centralManager.stopScan()
            print(advertisementData)
            central.connect(peripheral, options: nil)
            myPeripheral = peripheral
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected \(peripheral.name ?? "no name")")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
}

