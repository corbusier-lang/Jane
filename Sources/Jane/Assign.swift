//
//  Assign.swift
//  Jane
//
//  Created by Олег on 05.02.2018.
//

import CoreCorbusier

public protocol JaneExpression {
    
    func expression() -> CRBExpression
    
}

extension JaneContext {
    
    public func jlet(_ name: String) -> JaneLet {
        let new = JaneLet(name: name)
        new.context = self
        return new
    }
    
}

public final class JaneLet : JaneCommand {
    
    let name: String
    init(name: String) {
        self.name = name
    }
    
    public func equals(_ i: JaneExpression) {
        let instanceExpression = i.expression()
        let statement = CRBStatement.assign(crbname(self.name), instanceExpression)
        context?.add(statement)
    }
    
}

public func i(_ name: String) -> JaneInstance {
    return JaneInstance(name: crbname(name))
}

public final class JaneInstance : JaneExpression {
    
    let name: CRBInstanceName
    let keyPath: CRBKeyPath
    
    internal init(name: CRBInstanceName, keyPath: CRBKeyPath = []) {
        self.name = name
        self.keyPath = keyPath
    }
    
    public func at(_ key: String) -> JaneInstance {
        var newKeyPath = keyPath
        newKeyPath.append(crbname(key))
        return JaneInstance(name: self.name, keyPath: newKeyPath)
    }
    
    public func expression() -> CRBExpression {
        return CRBExpression.subinstance(self.name, self.keyPath)
    }
    
}
