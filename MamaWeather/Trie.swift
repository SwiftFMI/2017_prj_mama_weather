//
//  Trie.swift
//  MamaWeather
//
//  Created by Boyan Vushkov on 5.02.18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import Foundation

class TrieNode<T: Hashable & Codable, D: Codable> : Codable {
    let value: T?
    var associatedData: D?
    var children: [T: TrieNode] = [:]
    var isTerminating = false
    
    init(value: T? = nil, data: D? = nil) {
        self.value = value
        self.associatedData = data
    }

    func add(child: T) {
        guard children[child] == nil else { return }
        children[child] = TrieNode(value: child)
    }
}

class Trie<D: Codable> : Codable {
    typealias Node = TrieNode<String, D>
    let root: Node
    
    init() {
        root = Node()
    }
    
    func insert(word: String, associatedData: D) {
        guard !word.isEmpty else { return }
        
        var currentNode = root
        
        for character in Array(word) {
            let char = String(character)
            if let child = currentNode.children[char] {
                currentNode = child
            } else {
                currentNode.add(child: char)
                currentNode = currentNode.children[char]!
            }
        }
        currentNode.isTerminating = true
        currentNode.associatedData = associatedData
    }
    
    func contains(word: String) -> Bool {
        guard !word.isEmpty else { return false }
        
        var currentNode = root
        
        for character in Array(word) {
            let char = String(character)
            guard let child = currentNode.children[char] else {
                return false
            }
            currentNode = child
        }
        
        return currentNode.isTerminating
    }
    
    func wordsIn(subtrie root: Node, prefix: String) -> [String] {
        var words = [String]()
        var previousLetters = prefix
        if let value = root.value {
            previousLetters.append(value)
        }
        if root.isTerminating {
            words.append(previousLetters)
        }
        
        for child in root.children.values {
            let childWords = wordsIn(subtrie: child, prefix: previousLetters)
            words += childWords
        }
        
        return words
    }
    
    func findLastNode(of word: String) -> Node? {
        var currentNode = root
        for character in Array(word) {
            let char = String(character)
            guard let childNode = currentNode.children[char] else {
                return nil
            }
            currentNode = childNode
        }
        return currentNode
    }
    
    func data(`for` word: String) -> D? {
        return findLastNode(of: word)?.associatedData
    }
    
    func starting(with prefix: String) -> [String] {
        var words = [String]()
        if let lastNode = findLastNode(of: prefix) {
            if lastNode.isTerminating {
                words.append(prefix)
            }
            
            for child in lastNode.children.values {
                let childWords = wordsIn(subtrie: child, prefix: prefix)
                words += childWords
            }
        }
        
        return words
    }
}
