//
//  ViewController.swift
//  Internet
//
//  Created by mac07 on 2020/5/20.
//  Copyright © 2020 NTUST. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {

    var tagName: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("======XML======")
        /* XML */
        var url = Bundle.main.url(forResource: "test", withExtension: "xml")
        let xml = XMLParser(contentsOf: url!)
        xml?.delegate = self
        xml?.parse()

        print("======JSON======")
        /* JSON */
        url = Bundle.main.url(forResource: "json", withExtension: "txt")
        // 讀取json字串
        if let data = try? Data(contentsOf: url!){
            // 解析json字串
            if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                // 利用迴圈印出解析後的結果
                for p in jsonObj as! [[String: AnyObject]]{
                    print("姓名: \(p["姓名"] as! String)")
                    print("年齡: \(p["年齡"] as! Int)")
                    
                    if let tels = p["電話"]{
                        print("公司電話: \(tels["公司"] as! String)")
                        print("住家電話: \(tels["住家"] as! String)")
                    }
                    print("--------------")
                }
            }
        }
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        tagName = nil

        switch elementName {
        case "student":
            for key in attributeDict.keys{
                let value = attributeDict[key]
                print("\(key): \(value!)")
            }
        default:
            tagName = elementName
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard tagName != nil else{
            return
        }
        print("\(tagName!): \(string)")
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        tagName = nil
    }

}

