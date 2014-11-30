//
//  PluralForm.swift
//  PluralizedStrings
//
//  Created by M. David Minnigerode on 11/28/14.
//  Copyright (c) 2014 M. David Minnigerode. All rights reserved.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this work except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//  original impl was by Pavel Ivashkov.. Converted to swift by David Minnigerode.
//
//  pluralform.c
//  Smartling.i18n
//
//  Originally created by Pavel Ivashkov on 2012-02-24.
//
// All the range checking is from:
// http://unicode.org/cldr/trac/browser/tags/release-21/common/supplemental/plurals.xml

import Foundation

enum PluralCategory:String{
    case zero = "zero"
    case one = "one"
    case two = "two"
    case few = "few"
    case many = "many"
    case other = "other"

}

class PluralForms {
    
    private class func langFromLocale(locale:NSLocale?)->String!{
        return locale?.objectForKey(NSLocaleLanguageCode) as String
    }
    
    class func pluraCategory(locale:NSLocale?, f:Float) -> PluralCategory? {
        NSLocalizedString("xx", tableName: nil, bundle: NSBundle.mainBundle(), value: "val", comment: "comment")
        switch PluralForms.langFromLocale(locale) {
        case "shi":
            if f >= 0 || f <= 1 { return .one }
        case "lag":
            if (((f >= 0 && f <= 2)) && (f != 0) && (f != 2)){ // n within 0..2 and n is not 0 and n is not 2
                return .one;
            }
        case "ff", "fr", "kab":
            if (((f >= 0 && f <= 2)) && (f != 2)) { // n within 0..2 and n is not 2
                return .one;
            }
        default: return .other
        }
        return .other
    }
    
    
    
    class func pluraCategory(locale:NSLocale?, n:Int!) -> PluralCategory?{
        
        switch PluralForms.langFromLocale(locale) {
            // set1
        case "lt": // lt
            if (((n % 10) == 1) && (((n % 100) < 11 || (n % 100) > 19))) {// n mod 10 is 1 and n mod 100 not in 11..19
                return .one;
            }
            if ((((n % 10) >= 2 && (n % 10) <= 9)) && (((n % 100) < 11 || (n % 100) > 19))){ // n mod 10 in 2..9 and n mod 100 not in 11..19
                return .few;
            }
            
            // set2
        case "lv": // lv
            if (n == 0){ // n is 0
                return .zero;
            }
            if (((n % 10) == 1) && ((n % 100) != 11)) {// n mod 10 is 1 and n mod 100 is not 11
                return .one;
            }
            
        case "cy":
            switch n {
            case 2: return .two
            case 3: return .few
            case 0: return .zero
            case 1: return .one
            case 6: return .many
            default: return .other
            }
            
        case "be","bs","hr","ru","sh","sr","uk":
            if (((n % 10) == 1) && ((n % 100) != 11)){ // n mod 10 is 1 and n mod 100 is not 11
                return .one;
            }
            if ((((n % 10) >= 2 && (n % 10) <= 4)) && (((n % 100) < 12 || (n % 100) > 14))){ // n mod 10 in 2..4 and n mod 100 not in 12..14
                return .few;
            }
            if (((n % 10) == 0) || (((n % 10) >= 5 && (n % 10) <= 9)) || (((n % 100) >= 11 && (n % 100) <= 14))){ // n mod 10 is 0 or n mod 10 in 5..9 or n mod 100 in 11..14
                return .many;
            }
        case "ksh": // ksh
            switch n {
            case 0: return .zero
            case 1: return .one
            default: return .other
            }
            
            
        case "shi": // shi
            if ((n >= 2 && n <= 10)){ // n in 2..10
                return .few;
            }
            if ((n >= 0 && n <= 1)){ // n within 0..1
                return .one;
            }
        case "he": // he
            if (n == 2){ // n is 2
                return .two;
            }
            if (n == 1){ // n is 1
                return .one;
            }
            
            if ((n != 0) && ((n % 10) == 0)){ // n is not 0 AND n mod 10 is 0
                return .many
            }
        case "cs","sk":
            if (n == 1) {// n is 1
                return .one;
            }
            if ((n >= 2 && n <= 4)) {// n in 2..4
                return .few;
            }
        case "br": // br
            if ((n != 0) && ((n % 1000000) == 0)){ // n is not 0 and n mod 1000000 is 0
                return .many;
            }
            if (((n % 10) == 1) && (((n % 100) != 11) && ((n % 100) != 71) && ((n % 100) != 91))) {// n mod 10 is 1 and n mod 100 not in 11,71,91
                return .one;
            }
            if (((n % 10) == 2) && (((n % 100) != 12) && ((n % 100) != 72) && ((n % 100) != 92))) {// n mod 10 is 2 and n mod 100 not in 12,72,92
                return .two;
            }
            if ((((n % 10) >= 3 && (n % 10) <= 4) || ((n % 10) == 9)) && (((n % 100) < 10 || (n % 100) > 19) && ((n % 100) < 70 || (n % 100) > 79) && ((n % 100) < 90 || (n % 100) > 99))){ // n mod 10 in 3..4,9 and n mod 100 not in 10..19,70..79,90..99
                return .few;
            }
        case "sl": // sl
            if ((n % 100) == 2){ // n mod 100 is 2
                return .two;
            }
            if ((n % 100) == 1){ // n mod 100 is 1
                return .one;
            }
            if (((n % 100) >= 3 && (n % 100) <= 4)){ // n mod 100 in 3..4
                return .few;
            }
            
        case "lag": // lag
            if (n == 0) {// n is 0
                return .zero;
            }
            if (((n >= 0 && n <= 2)) && (n != 0) && (n != 2)) {// n within 0..2 and n is not 0 and n is not 2
                return .one;
            }
            
        case "pl": // pl
            if (n == 1){ // n is 1
                return .one;
            }
            if ((((n % 10) >= 2 && (n % 10) <= 4)) && (((n % 100) < 12 || (n % 100) > 14))) {// n mod 10 in 2..4 and n mod 100 not in 12..14
                return .few;
            }
            if (((n != 1) && (((n % 10) >= 0 && (n % 10) <= 1))) || (((n % 10) >= 5 && (n % 10) <= 9)) || (((n % 100) >= 12 && (n % 100) <= 14))) {// n is not 1 and n mod 10 in 0..1 or n mod 10 in 5..9 or n mod 100 in 12..14
                return .many;
            }
            
            
            // set13
        case "gd": // gd
            if ((n == 2) || (n == 12)) {// n in 2,12
                return .two;
            }
            if ((n == 1) || (n == 11)) {// n in 1,11
                return .one;
            }
            if ((n >= 3 && n <= 10) || (n >= 13 && n <= 19)) { // n in 3..10,13..19
                return .few;
            }
            
            
            // set14
        case "gv": // gv
            if ((((n % 10) >= 1 && (n % 10) <= 2)) || ((n % 20) == 0)) {// n mod 10 in 1..2 or n mod 20 is 0
                return .one;
            }
            
            
            // set15
        case "mk": // mk
            if (((n % 10) == 1) && (n != 11)) {// n mod 10 is 1 and n is not 11
                return .one;
            }
            
            
            // set16
        case "mt": // mt
            if (n == 1) { // n is 1
                return .one;
            }
            if (((n % 100) >= 11 && (n % 100) <= 19)){ // n mod 100 in 11..19
                return .many;
            }
            if ((n == 0) || (((n % 100) >= 2 && (n % 100) <= 10))) {// n is 0 or n mod 100 in 2..10
                return .few;
            }
            
            
            // set17
        case "mo","ro": // mo
            if (n == 1){ // n is 1
                return .one;
            }
            if ((n == 0) || ((n != 1) && (((n % 100) >= 1 && (n % 100) <= 19)))) {// n is 0 OR n is not 1 AND n mod 100 in 1..19
                return .few;
            }
            
            
            // set18
        case "ga": // ga
            if (n == 2) {// n is 2
                return .two;
            }
            if (n == 1){ // n is 1
                return .one;
            }
            if ((n >= 3 && n <= 6)){ // n in 3..6
                return .few;
            }
            if ((n >= 7 && n <= 10)){ // n in 7..10
                return .many;
            }
            
            
            // set19
        case "ff","fr","kab": // ff
            
            if (((n >= 0 && n <= 2)) && (n != 2)) {// n within 0..2 and n is not 2
                return .one;
            }
            
            
            // set20
        case "iu","kw","se","naq","sma","smi","smj","smn","sms":
            if (n == 2) {// n is 2
                return .two;
            }
            if (n == 1){ // n is 1
                return .one;
            }
            
            
            // set21
        case "ak","am","bh","hi","ln","mg","ti","tl","wa","fil","guw","nso":
            if ((n >= 0 && n <= 1)) {// n in 0..1
                return .one;
            }
            
            
            // set22
        case "tzm": // tzm
            if (((n >= 0 && n <= 1)) || ((n >= 11 && n <= 99))) { // n in 0..1 or n in 11..99
                return .one;
            }
            
            
            // set23
        case "af","bg","bn","ca","da","de","dv","ee","el","en","eo","es","et","eu","fi","fo","fy","gl","gu","ha","is","it","kk","kl","ks","ku","ky","lb","lg","ml","mn","mr","nb","nd","ne","nl","nn","no","nr","ny","om","or","os","pa","ps","pt","rm","sn","so","sq","ss","st","sv","sw","ta","te","tk","tn","ts","ur","ve","vo","xh","zu","asa","ast","bem","bez","brx","cgg","chr","ckb","fur","gsw","haw","jgo","jmc","kaj","kcg","kkj","ksb","mas","mgo","nah","nnh","nyn","pap","rof","rwk","saq","seh","ssy","syr","teo","tig","vun","wae","xog":
            if (n == 1) {// n is 1
                return .one;
            }
            
            
            // set24
        case "ar": // ar
            if (n == 2){ // n is 2
                return .two;
            }
            if (n == 1) {// n is 1
                
                return .one;
            }
            if (n == 0) {// n is 0
                return .zero;
            }
            if (((n % 100) >= 3 && (n % 100) <= 10)) { // n mod 100 in 3..10
                return .few;
            }
            if (((n % 100) >= 11 && (n % 100) <= 99)) {// n mod 100 in 11..99
                return .many;
            }
        default:
            return .other
            
        }
        
        return .other
    }
}