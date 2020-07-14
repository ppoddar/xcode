import Foundation

class Poem : CustomStringConvertible {
    var id:String
    var title:String
    var path:String
    var audio:String?
    private var content:String?
    init(id:String,
        title:String,path:String,audio:String?=nil) {
        self.id = id
        self.title  = title
        self.path   = path
        self.audio  = audio
    }
    
    func text() -> String {
        if (content == nil) {
            content = FileReader.read(fileName: path)
        }
        return content ?? ""
    }
    
    
    
    var description:String { "\(title) at \(path)"}
}
