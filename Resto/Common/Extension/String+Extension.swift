//
//  String+Extension.swift
//  Resto
//
//  Created by David Gomez on 12/11/2022.
//
import UIKit

extension String {
    var toImageData: Data? {
        NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0)) as? Data
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
