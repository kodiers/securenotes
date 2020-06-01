//
//  Note.swift
//  securenotes
//
//  Created by Viktor Yamchinov on 02.06.2020.
//  Copyright © 2020 Viktor Yamchinov. All rights reserved.
//

import Foundation

class Note {
    
    public private(set) var message: String
    public var lockStatus: LockStatus
    
    init(message: String, lockStatus: LockStatus) {
        self.message = message
        self.lockStatus = lockStatus
    }
}
