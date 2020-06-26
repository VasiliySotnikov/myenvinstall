options = {UpdatePacletSites -> True, KeepExistingVersion -> False};

PacletInstall["https://github.com/WolframResearch/GitLink/releases/download/v0.1.1/GitLink-2018.07.20.01.paclet", UpdatePacletSites -> True]
PacletInstall["AST", options]
PacletInstall["Lint", options]

Remove[options];
