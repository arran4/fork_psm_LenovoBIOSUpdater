@{
    IncludeRules = @(
        'PSAvoidUsingWriteHost'
        'PSUseShouldProcessForStateChangingFunctions'
        'PSAvoidOverwritingBuiltInCmdlets'
        'PSAvoidTrailingWhitespace'
        'PSUseDeclaredVarsMoreThanAssignments'
        'PSUseConsistentIndentation'
        'PSUseConsistentWhitespace'
    )
    Rules = @{
        PSUseConsistentIndentation = @{ IndentationSize = 4 }
        PSUseConsistentWhitespace = @{ }
    }
}

