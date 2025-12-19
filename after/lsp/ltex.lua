return {
  settings = {
    ltex = {
      completionEnabled = true,
      language = "en",
      checkFrequency = "save",
      diagnosticSeverity = "information",
      sentenceCacheSize = 5000,
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en",
        languageModel = "~/.local/share/ngrams/",
      },
    },
  },
}
