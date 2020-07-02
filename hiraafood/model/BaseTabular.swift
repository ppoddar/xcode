/*
 * Base implementation of Tabular protocol
 * with generic element type.
 * Has stored property of a IndexedDictionary
 * of elemnets and an optional total.
 *
 * This class also decodes
 */

import Foundation
class BaseTabular<E:Codable & HasKeyProtcol> : Tabular {
    typealias Element = E
    var total:Double
    var _elements : IndexedDictionary<E>
    
    enum CodingKeys : String,CodingKey {
        case total, elements
    }

    var items:Dictionary<String,E> { get {
        return _elements.delegate
        }
    }
    /*
     * create with empty dictionary of elements
     * and no total
     */
    required init() {
        self.total = 0
        self._elements = IndexedDictionary<E>()
    }
    
    
    /*
     * number of elements is size of dictionary
     */
    var numberOfElements: Int {
        get {
            return self._elements.count
        }
    }
    var isEmpty: Bool {
        get {
            return _elements.count == 0
        }
    }
    /*
     * element at given index.
     * keys are ordered
     */
    subscript(idx: Int) -> E? {
        return _elements[idx]
    }
    /*
     * element with given key
     */
    subscript(key: String) -> E? {
        return _elements[key]
    }
    
    func addElement(_ e:Element) {
        _elements.addElement(e)
    }

    func decode(from decoder:Decoder) throws {
        NSLog("decoding AbstractTabular")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            let totalS = try container.decode(String.self, forKey: .total)
            self.total = Double(totalS)!
        }
        let dict:Dictionary<String,Data> = try container.decode(Dictionary.self, forKey: .elements)
        self._elements = IndexedDictionary<E>()
        for (_,value) in dict {
            do {
                let item = try JSONDecoder().decode(E.self, from:value)
                _elements.addElement(item)
            } catch {
                NSLog(String(describing: error))
            }
        }
    }
}
