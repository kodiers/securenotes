//
//  NoteCell.swift
//  securenotes
//
//  Created by Viktor Yamchinov on 02.06.2020.
//  Copyright © 2020 Viktor Yamchinov. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var lockImageView: UIImageView!

    func configureCell(note: Note) {
        if note.lockStatus == .locked {
            messageLbl.text = "This note is locked. Unlock to read."
            lockImageView.isHidden = false
        } else {
            messageLbl.text = note.message
            lockImageView.isHidden = true
        }
    }
}
