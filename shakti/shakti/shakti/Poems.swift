import Foundation
/*
 * All poems to be displayed.
 * The poems are organized in array.
 * Each array elemnt is an of array of 2 poems
 * The 0-th poem is original language
 * The 1-th poem is translated language
 *
 * Each pair is identified by a key (is necesary)
 * A order is an array of these ids
 */

import UIKit
class Poems:NSObject,UITableViewDataSource {
    
    private var keyOrder:[String]
    private var poems:[[Poem]]
    var size:Int { get {return poems.count}}
    
    static let instance:Poems = Poems()
    
    private override init() {
        keyOrder = [
            "melody",
            "key",
            "oboni",
            "footpath",
            "postmen",
            "anarchist",
            "jorasandha",
            "may-go"]
        
        poems = [
            [Poem(id:"melody", title:"আনন্দ-ভৈরবী",       path:"/anondo-voirobi.html",   audio:"melodies-of-joy.mp3"),
             Poem(id:"melody", title:"Melodies of Joy", path:"/melodies-of-joy.html")],
            
            [Poem(id:"key", title:"চাবি",     path:"/chabi.html"),
             Poem(id:"key", title:"The key", path: "/key.html")],
                     
            [Poem(id:"oboni", title:"অবনী বাড়ি আছো ?",      path:"/oboni-bari-acho.html"),
             Poem(id:"oboni", title:"Oboni, are you home?", path:"/oboni-are-you-home.html")],
                      
            [Poem(id:"footpath", title:"ফুটপাত বদল হয় মধ্যরাত",     path:"/footpath-badal-hoi-madhyarate.html"),
             Poem(id:"footpath", title:"Not happy hour",         path: "/not-happy-hour.html")],
            
            [Poem(id:"postman", title:"হেমন্তের অরণ্যে পোস্টম্যান",         path:"/hemanter-oronye-ami-postman.html"),
             Poem(id:"postman", title:"Postmen in Forest of Fall", path: "/postmen-in-forest-of-fall.html")],
                      
            [Poem(id:"ananchist", title:"স্বেছ্বাচারী",    path:"/sechhachari.html"),
             Poem(id:"ananchist", title:"Anarchist", path: "/anarchist.html")],
                      
            [Poem(id:"jorasandha", title:"জরাসন্ধ",        path:"/jorasandha.html"),
             Poem(id:"jorasandha", title:"Take Me Back", path: "/take-me-back.html")],
                      
            [Poem(id:"may-go", title:"যেতে পারি, কিন্তু কেন যাবো ?",  path:"/jete-pari-kintu-keno-jabo.html"),
             Poem(id:"may-go", title:"May Go, but Why?",       path: "/may-go-but-why.html")],
            
        ]
        
        
    }
    /*
     * get index of poem given its id
     */
    func indexOf(id:String) -> Int {
        let idx:Int? = keyOrder.firstIndex(of: id)
        guard let r = idx else {
            print("no index for id \(id). Key order \(keyOrder)")
            return -1
        }
        return r
    }
    /*
     * get a coople of Poem as an array.
     * 0-th one is Bengali, second one in English
     */
    subscript (idx:Int) -> [Poem] { get{
        return poems[idx]
    }}
    
    // ---------------------------------------
    //       DataSource protocol
    // ---------------------------------------
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return poems.count
   }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: TOCViewController.cellIdentifer) as? IndexEntry
        if cell == nil {
            print("creating new table cell")
            cell = IndexEntry(style:UITableViewCell.CellStyle.value1, reuseIdentifier: TOCViewController.cellIdentifer)
        }
        let pairs:[Poem] = poems[indexPath.row]
        cell!.titles = [pairs[0].title, pairs[1].title]
        
        return cell!
    }
}
