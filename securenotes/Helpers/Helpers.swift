//
//  Helpers.swift
//  securenotes
//
//  Created by Viktor Yamchinov on 03.06.2020.
//  Copyright © 2020 Viktor Yamchinov. All rights reserved.
//

import Foundation

func isNoteLocked(_ lockStatus: LockStatus) -> Bool {
    return lockStatus == .locked
}

func lockStatusFlipper(_ lockStatus: LockStatus) -> LockStatus {
    if lockStatus == .locked {
        return .unlocked
    }
    return .locked
}
