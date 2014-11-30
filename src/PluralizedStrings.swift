//
//  PluralizedStrings.swift
//  PluralizedStrings
//
//  Created by M. David Minnigerode on 11/28/14.
//  Copyright (c) 2014 M. David Minnigerode. All rights reserved.
//

/**

Adodpted an Swifted from SLLocalization by @Pavel Ivanshkov of Smartlings.

Uses the unicode standards for CLDR to allow the lookup of correctly localized plural forms of l10n strings.

Modify your .strings file so that each key for a plural form of a string has the CLDR category appended to it.

Examples are best...

en:  We have one apple or N apples.

"apples" = "%@ apples";
"apples##{one}" = "One apple";
"apples##{other}" = "%@ apples";

ru: You have multiple forms depending on the number of N.

"apples" = "%@ яблока";
"apples##{one}" = "%@ яблоко";
"apples##{few}" = "%@ яблока";
"apples##{many}" = "%@ яблок";
"apples##{other}" = "%@ яблока";

If we are in the en_US locale:
PluralizedStrings.pluralize("apples", numberValue: 1) ->  One apple
PluralizedStrings.pluralize("apples", numberValue: 0) ->  %@ apples

If we are in Russian locale:
PluralizedStrings.pluralize("apples", numberValue: 0) ->  %@ яблок
PluralizedStrings.pluralize("apples", numberValue: 1) ->  %@ яблоко
PluralizedStrings.pluralize("apples", numberValue: 22) ->  %@ яблока
PluralizedStrings.pluralize("apples", numberValue: 111) ->  %@ яблок



NOTE!: To test this you'll need to add

-AppleLanguages "(Russian)"

Edit Scheme -> Test -> Arguments Passed on Launch

Be sure an uncheck the 'use run action's..." (or put it in your run action section).



*/

import Foundation

// So we know if there was anything under a particulr key
let PS_MAGIC_VALUE = NSUUID().UUIDString

public class PluralizedStrings{
    
    /**
    
    */
    public class func pluralize<T>(key:String, numberValue:T, locale:NSLocale = NSLocale.currentLocale()) -> String{
        // get the CLDR enhanced form of the key
        let kPlusCategory = self.keyWithCategoryForLocale(key, n: numberValue, locale:locale )
        
        // If it's the same as the orig key then we just do a lookup as normal
        if kPlusCategory == key {
            return NSLocalizedString(key, comment: "")
        }
        
        // Lookup by the CLDR enhanced key.  If it's not there we get the magic value back
        let pluralValue:String! = NSLocalizedString(kPlusCategory, value: PS_MAGIC_VALUE, comment: "")
        if pluralValue == PS_MAGIC_VALUE {
            // we don't have anything that matches the category... so use the default one.
            return NSLocalizedString(key, comment: "")
        }
        
        // Not the magic value so this is what we wanted..
        return pluralValue
    }
    
    
    
    /**
    Compose  a new key with the catagory appended.
    
    Form is:  <key>##{PluralCategory}
    
    Category may be nil (that is the language has no definition for the given n) in which case the original key will be returned.
    
    */
    public class func keyWithCategoryForLocale<T>(key:String, n:T, locale:NSLocale) -> String{
        if n is Int {
            if let cat = PluralForms.pluraCategory(locale, n:n as Int) {
                return key + "##{" + cat.rawValue + "}"
            }
        }
        if n is Float {
            if let cat = PluralForms.pluraCategory(locale, f: n as Float) {
                return key + "##{" + cat.rawValue + "}"
            }
        }
        // TODO: Log it...
        return key;
    }
    
    
    
    
}


