//
//  NoteVC.swift
//  securenotes
//
//  Created by Viktor Yamchinov on 01.06.2020.
//  Copyright © 2020 Viktor Yamchinov. All rights reserved.
//

import UIKit
import LocalAuthentication

class NoteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NoteCell else {
            return UITableViewCell()
        }
        cell.configureCell(note: notesArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if notesArray[indexPath.row].lockStatus == .locked {
            authenticateBiometrics { (autheticated) in
                if autheticated {
                    let lockStatus = notesArray[indexPath.row].lockStatus
                    notesArray[indexPath.row].lockStatus = lockStatusFlipper(lockStatus)
                    DispatchQueue.main.async {
                        self.pushNoteFor(indexPath: indexPath)
                    }
                }
            }
        } else {
            pushNoteFor(indexPath: indexPath)
        }
        
    }
    
    func pushNoteFor(indexPath: IndexPath) {
        guard let noteDetailVc = storyboard?.instantiateViewController(identifier: "noteDetailVC") as? NoteDetailVC else { return }
        noteDetailVc.note = notesArray[indexPath.row]
        noteDetailVc.index = indexPath.row
        navigationController?.pushViewController(noteDetailVc, animated: true)
    }
    
    func authenticateBiometrics(completion: @escaping (Bool) -> Void) {
        let myContext = LAContext()
        let myLocalizedReasonString = "Our app uses TouchID or FaceID to secure notes."
        var authError: NSError?
        
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { (success, evaluateError) in
                    if success {
                        completion(true)
                    } else {
                        guard let evaluateErrorStr = evaluateError?.localizedDescription else { return }
                        self.showAlert(withMessage: evaluateErrorStr)
                        completion(false)
                    }
                }
            } else {
                guard let authErrorStr = authError?.localizedDescription else { return }
                showAlert(withMessage: authErrorStr)
                completion(false)
            }
        } else {
            completion(false)
        }
        
    }
    
    func showAlert(withMessage message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }

}

