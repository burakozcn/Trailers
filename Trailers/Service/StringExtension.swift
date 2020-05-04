
extension StringProtocol {
  var urlWords: [SubSequence] {
    return split{ !$0.isLetter }
  }
}
