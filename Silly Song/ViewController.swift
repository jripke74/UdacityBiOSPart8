//
//  ViewController.swift
//  Silly Song
//
//  Created by Jeff Ripke on 1/27/16.
//  Copyright © 2016 JeffRipke. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        let shortName = shortNameFromName(fullName)
        var lyricsFullName: String
        var lyrics: String
        lyricsFullName = lyricsTemplate.stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName)
        lyrics = lyricsFullName.stringByReplacingOccurrencesOfString("<SHORT_NAME>", withString: shortName)
        return lyrics
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func shortNameFromName(fullName: String) -> String {
        let lowercaseName = fullName.lowercaseString
        let vowelSet = NSCharacterSet(charactersInString: "aeiou")
        if let firstVowelRange = fullName.rangeOfCharacterFromSet(vowelSet, options: .CaseInsensitiveSearch) {
            return lowercaseName.substringFromIndex(firstVowelRange.startIndex)
        }
        return lowercaseName
    }
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joinWithSeparator("\n")
    
    @IBAction func reset(sender: AnyObject) {
        nameField.text = ""
        lyricsView.text = ""
        nameField.returnKeyType = UIReturnKeyType.Done
    }
    
    @IBAction func displayLyrics(sender: AnyObject) {
        if let name = nameField.text?.capitalizedString {
            lyricsView.text = lyricsForName(bananaFanaTemplate, fullName: name)
        }
    }
}

