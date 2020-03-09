//
//  MyContacts.swift
//  MyContacts
//
//  Created by Filipe Botti on 08/03/20.
//  Copyright © 2020 Facebook. All rights reserved.
//
import Contacts

@objc(MyContacts)
class MyContacts: NSObject {
    
    @objc
    func helloWorld(_ callback: RCTResponseSenderBlock
    ) {
        callback(["Hello world!"])        
    }
}
