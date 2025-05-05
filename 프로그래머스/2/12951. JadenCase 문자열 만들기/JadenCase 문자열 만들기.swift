func solution(_ s: String) -> String {
    var result = ""
    var makeUpper = true

    for char in s {
        if char == " " {
            result += " "
            makeUpper = true
        } else {
            result += makeUpper ? char.uppercased() : char.lowercased()
            makeUpper = false
        }
    }

    return result
}
