//
//  Trie.swift
//  MamaWeather
//
//  Created by Boyan Vushkov on 5.02.18.
//  Copyright © 2018 Boyan Vushkov. All rights reserved.
//

import Foundation

class TrieNode<T: Hashable> {
    let value: T?
    var children: [T: TrieNode] = [:]
    var isTerminating = false
    
    init(value: T? = nil) {
        self.value = value
    }

    func add(child: T) {
        guard children[child] == nil else { return }
        children[child] = TrieNode(value: child)
    }
}

class Trie {
    typealias Node = TrieNode<Character>
    let root: Node
    
    init() {
        root = Node()
    }
    
    func insert(word: String) {
        guard !word.isEmpty else { return }
        
        var currentNode = root
        
        for character in Array(word) {
            if let child = currentNode.children[character] {
                currentNode = child
            } else {
                currentNode.add(child: character)
                currentNode = currentNode.children[character]!
            }
        }
        currentNode.isTerminating = true
    }
    
    func contains(word: String) -> Bool {
        guard !word.isEmpty else { return false }
        
        var currentNode = root
        
        for character in Array(word) {
            guard let child = currentNode.children[character] else {
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
            guard let childNode = currentNode.children[character] else {
                return nil
            }
            currentNode = childNode
        }
        return currentNode
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
