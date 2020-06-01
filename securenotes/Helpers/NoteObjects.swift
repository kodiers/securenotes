//
//  NoteObjects.swift
//  securenotes
//
//  Created by Viktor Yamchinov on 02.06.2020.
//  Copyright © 2020 Viktor Yamchinov. All rights reserved.
//

import Foundation

var note1 = Note(message: "Devslopes is really amazing platform", lockStatus: .locked)
var note2 = Note(message: "I'm learning abot TouchID and FaceID", lockStatus: .unlocked)
var note3 = Note(message: "Some other text like: lorem ipsum and so-on.", lockStatus: .locked)

var notesArray: [Note] = [note1, note2, note3]
