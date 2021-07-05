Block[{options = {UpdatePacletSites -> True, KeepExistingVersion -> False}},

PacletInstall["https://github.com/WolframResearch/GitLink/releases/download/v0.1.1/GitLink-2018.07.20.01.paclet", options, ForceVersionInstall-> True];
PacletInstall["CodeParser", options];
PacletInstall["CodeInspector", options];
PacletInstall["ZeroMQLink", options];

];
