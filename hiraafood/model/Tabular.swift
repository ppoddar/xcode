/*
 * Tabular data protocol.
 * Associated types are Model and Element
 *
 */
protocol Tabular {
    associatedtype Element  //item
    
    init()
    // number of elements/rows
    var numberOfElements:Int {get}
    var isEmpty:Bool {get}
    // get total, if any
    var total:Double {get}
    // model element at given index
    subscript (idx:Int)    -> Element? {get}
    // model element at given key
    subscript (key:String) -> Element? {get}
    // adds an element
    func addElement(_ e:Element)
    
}
