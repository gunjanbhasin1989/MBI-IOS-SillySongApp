//
//  ViewControllerExtension.swift
//  Silly Song
//
//  Created by Gunjan Bhasin on 1/31/18.
//  Copyright © 2018 mindbody. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    //
    // Prepare/Setup Methods
    //
    
    func prepareControls(
        _ enabled: Bool) {
        
        lblAppTitle.isHidden = !enabled
        nameField.isHidden = !enabled
    }
    
    func prepareTextViewControl(
        _ textView: UITextView) {
        
        lyricParagraphStyle = NSMutableParagraphStyle()
        lyricParagraphStyle.lineBreakMode = .byWordWrapping;
        lyricParagraphStyle.alignment = .center;
        
        
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 1, height: 1)
        shadow.shadowBlurRadius = 1

        lyricsView.delegate = self
        lyricTextViewAttributedText = NSMutableAttributedString(string: lyricsView.text)
        lyricsView.attributedText = lyricTextViewAttributedText
    }

    //
    // Lyric Methods
    //
    
    /*
     * small helper method for cleanUp any of my app input views
     */
    func resetInputFields() {
        
        nameField.text = ""
        lyricsView.text = ""
    }
    
    /*
     * takes the name entered in the nameField generates the personalized lyrics, and displays the lyrics in lyricsView.
     */
    func displayLyrics(
        _ lyricsTemplate: String,
        _ fullName: String) -> String {
        
        if let shortName = getShortName(fullName) {
            
            let lyrics: String = lyricsTemplate
                .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
                .replacingOccurrences(of: "<FULL_NAME>", with: fullName.capitalizingFirstLetter())
            
            return lyrics
        }
        
        return ""
    }
    
    /*
     * check for shortable name, return position of first vowel or false if position is 0 || no occurance found
     */
    func isNameShortable (
        _ name: String,
        
        completionHandlerForNameShortable: @escaping (
        _ success: Bool?,
        _ vowelPosition: Int?)
        
        -> Void) {
        
        if name.isEmpty { completionHandlerForNameShortable(false, 0) }
        
        let _nameLength = name.lengthOfBytes(using: .utf8)
        var _lastPos = _nameLength
        
        for _vowel in vowels {
            // convert vowel to real character
            let vowel = Character(_vowel)
            // determine index position of that char inside name
            if let _index = name.characters.index(of: vowel) {
                // evaluate real position inside that name
                let pos = name.characters.distance(from: name.startIndex, to: _index)
                
                if pos < _lastPos { _lastPos = pos }
                
                if debugMode { print("found a valid vowel (\(vowel)) at position: [\(pos)]") }
            }
        }
        
        if _lastPos != _nameLength {
            // validate true if position of that vowel > 0 (so names starting with a vowel will be ignored)
            completionHandlerForNameShortable(_lastPos > 0, _lastPos)
            
            return
        }
        
        completionHandlerForNameShortable(false, 0)
    }
    
    /*
     * get the shorten version of given name using pre-validator function isNameShortable
     */
    func getShortName(
        _ name: String) -> String? {
        
        if name.isEmpty { return nil }
        
        var _name = name.lowercased()
        
        isNameShortable(_name) {
            
            (success, position) in
            
            if success == true { _name = _name.substring(from: position!) }
        }
        
        return _name
    }
    
    //
    // Delegate Methods
    //
    /*
     * reset input fields on any input start
     */
    func textFieldDidBeginEditing(
        _ textField: UITextField) {
        
        resetInputFields()
    }
    
    /*
     * also reset input fields on any reset txtView icon click
     */
    func textFieldShouldClear(
        _ textField: UITextField) -> Bool {
        
        resetInputFields()
        
        return true
    }
    
    /*
     * handle logic on exit name textView input and generate lyrics
     */
    func textFieldShouldReturn(
        _ textField: UITextField) -> Bool {
        
        view.endEditing(true)
        
        if textField.text == nil || textField.text!.isEmpty {
            lyricsView.text = ""
        } else {
            lyricsView.text = displayLyrics(lyricTemplate, textField.text!)
            prepareTextViewControl(lyricsView)
            nameField.resignFirstResponder()
            nameField.text = ""
        }
        
        return false
    }
}
