
import CoreCorbusier

public final class JaneContext {
    
    var statements: [CRBStatement] = []
    
    public func run(in context: inout CRBContext) throws {
        let compound = CRBStatement.ordered(statements)
        var execution = CRBExecution(context: context)
        try execution.execute(statement: compound)
        context = execution.context
    }
    
    public func add(_ statement: CRBStatement) {
        self.statements.append(statement)
    }
    
}

public func jane(in context: CRBContext, _ build: (JaneContext) -> ()) throws {
    let janeContext = JaneContext()
    build(janeContext)
    var contextCopy = context
    try janeContext.run(in: &contextCopy)
    dump(contextCopy)
}

extension JaneContext {
    
    public func jlet(_ name: String) -> JaneLet {
        let new = JaneLet(name: name)
        new.context = self
        return new
    }
    
}

public class JaneCommand {
    
    var context: JaneContext?
    
    func pass<OtherCommand : JaneCommand>(_ create: () -> OtherCommand) -> OtherCommand {
        let new = create()
        new.context = self.context
        return new
    }

}

public protocol JaneExpression {
    
    func expression() -> CRBExpression
    
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
