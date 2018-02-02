//
//  ViewController.swift
//  Silly Song
//
//  Created by Gunjan Bhasin on 1/16/18.
//  Copyright © 2018 mindbody. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    @IBOutlet weak var lblAppTitle: UILabel!
    
    let debugMode: Bool = true
    let vowels = ["a","e","i","o","u"]
    let lyricFontNames = ["HelveticaNeue-CondensedBlack", "Impact", "Futura-CondensedExtraBold"]
    let lyricFontNameFallback = "Arial"
    let lyricFontSize: CGFloat = 40.0
    let lyricTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")

    var lyricTextViewAttributes: [NSAttributedStringKey : Any]!
    var lyricParagraphStyle: NSMutableParagraphStyle!
    var lyricTextViewAttributedText: NSMutableAttributedString!
    var lyricFontNameUsed: String!

    //
    // UIView Methods (overrides)
    //
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        prepareControls( true )
    }

   override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        nameField.delegate = self
    }
}
