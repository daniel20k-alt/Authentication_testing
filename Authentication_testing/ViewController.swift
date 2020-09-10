//
//  ViewController.swift
//  Authentication_testing
//
//  Created by DDDD on 10/09/2020.
//  Copyright © 2020 MeerkatWorks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var hiddenTextEditor: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        //when the keyboard shows or hides we should be notified
        
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @IBAction func authenticateTapped(_ sender: Any) {
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEnd = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEnd, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            hiddenTextEditor.contentInset = .zero
        } else {
            hiddenTextEditor.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        hiddenTextEditor.scrollIndicatorInsets = hiddenTextEditor.contentInset
        
        let selectedRange = hiddenTextEditor.selectedRange
        hiddenTextEditor.scrollRangeToVisible(selectedRange)
    }
}

