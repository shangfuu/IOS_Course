//
//  ViewController.swift
//  Multitasking
//
//  Created by mac07 on 2020/5/13.
//  Copyright © 2020 NTUST. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    enum CQType {
        case CONCURRENT
        case INACTIVE
        case CON_INA
        case DEFAULT
    }
    var inactiveQueue: DispatchQueue!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Serial */
//        QosQueue()
//                syncQueue()
//                asyncQueue()
//                AsyncQosQueue()
//                SyncQosQueue()
        
        /* Concurrent */
        concurrentQueue()
        if let queue = inactiveQueue{
            queue.activate()
        }
    }
    
    func concurrentQueue() {
        print("====Concurrent Queue====")
        let type = CQType.INACTIVE
        var queue: DispatchQueue
        
        if type == CQType.CONCURRENT{
            print("--Concurrent--")
            queue = DispatchQueue(label: "q1", qos: .utility, attributes: .concurrent)
            
        } else if type == CQType.INACTIVE {
            print("--Init Inactive--")
            queue = DispatchQueue(label: "q1", qos: .utility, attributes: .initiallyInactive)
            inactiveQueue = queue
            
        } else if type == CQType.CON_INA {
            print("--Concurrent & Init Inactive--")
            queue = DispatchQueue(label: "q1", qos: .utility, attributes: [.concurrent, .initiallyInactive])
            inactiveQueue = queue
        } else {
            print("--Default Serial--")
            // Not setting attributes default Serial
            queue = DispatchQueue(label: "q1", qos: .utility)
        }
        
        queue.async {
            for i in 0...10 {
                print("♻️",i)
            }
        }
        queue.async {
            for i in 100...110 {
                print("🚭",i)
            }
        }
        queue.async {
            for i in 1000...1010 {
                print("☑️",i)
            }
        }
    }
    
    func QosQueue(){
        print("====QosQueue====")
        let queue1 = DispatchQueue(label: "q1", qos: DispatchQoS.unspecified)
        let queue2 = DispatchQueue(label: "q2", qos: DispatchQoS.userInitiated)
        
        queue1.async {
            for i in 0...10{
                print("⛑", i)
            }
            
            for i in 50...60 {
                print("🧤", i)
            }
        }
        queue2.async {
            for i in 20...30{
                print("Ⓜ️", i)
            }
            
            for i in 70...80 {
                print("🔰", i)
            }
        }
        for i in 30...40 {
            print("〽️",i)
        }
    }
    
    func syncQueue() {
        print("====SyncQueue====")
        let queue = DispatchQueue(label: "SQ")
        queue.sync {
            for i in 0...10{
                print("⛑", i)
            }
            
            for i in 50...60 {
                print("🧤", i)
            }
        }
        
        for i in 100...110 {
            print("🎓", i)
        }
    }
    
    func asyncQueue(){
        print("====AsyncQueue====")
        let queue = DispatchQueue(label: "SQ")
        queue.async {
            for i in 0...10{
                print("⛑", i)
            }
            
            for i in 50...60 {
                print("🧤", i)
            }
        }
        
        for i in 100...110 {
            print("🎓", i)
        }
    }
    
    func SyncQosQueue(){
        print("====QosQueue====")
        let queue1 = DispatchQueue(label: "q1", qos: DispatchQoS.userInitiated)
        let queue2 = DispatchQueue(label: "q2", qos: DispatchQoS.userInitiated)
        
        queue1.sync {
            for i in 0...10{
                print("⛑", i)
            }
            
            for i in 50...60 {
                print("🧤", i)
            }
        }
        
        queue2.sync {
            for i in 20...30{
                print("Ⓜ️", i)
            }
            
            for i in 70...80 {
                print("🔰", i)
            }
        }
    }
    
    func AsyncQosQueue() {
        print("====AsyncQosQueue====")
        let queue1 = DispatchQueue(label: "q1", qos: DispatchQoS.userInitiated)
        let queue2 = DispatchQueue(label: "q2", qos: DispatchQoS.userInitiated)
        
        queue1.async {
            for i in 0...10{
                print("⛑", i)
            }
            
            for i in 50...60 {
                print("🧤", i)
            }
        }
        
        queue2.async {
            for i in 20...30{
                print("Ⓜ️", i)
            }
            
            for i in 70...80 {
                print("🔰", i)
            }
        }
    }
    
    
}

