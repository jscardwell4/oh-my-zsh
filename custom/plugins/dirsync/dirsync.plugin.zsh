# syntax: shell

dirsync() {

SWIFTSCRIPT=<<END
import Foundation

@infix func * (string:String, times:Int) -> String {

  if string.isEmpty || times <= 0 { return string }
  else {
    var result = ""
    for _ in 1..times { result += string }
    return result
  }

}

extension NSFileManager {

  func isDirectoryAtPath(path:String?) -> Bool {
    var isDir:ObjCBool = ObjCBool(0)
    return Bool(self.fileExistsAtPath(path, isDirectory: &isDir) && Bool(isDir))
  }

}

func arrayContainsElement<T: Equatable>(element:T, array:T[]) -> Bool {
  for e in array { if e == element { return true } }
  return false
}

func compressedArray<T: Equatable>(array:T[]) -> T[] {
  var result = T[]()
  for e in array { if !arrayContainsElement(e, result) { result += e } }
  return result
}

@infix func + <T:Equatable>(lhs: Array<T>, rhs: Array<T>) -> Array<T> {

  var result = Array<T>()

  for e in lhs { result += e }
  for e in rhs { result += e }

  return result

}

@infix func - <T:Equatable>(lhs: T[], rhs: T[]) -> T[] {

  var result = T[]()
  for e in (lhs + rhs) { if !arrayContainsElement(e, rhs) { result += e } }

  return result

}

@infix func / <T:Equatable>(lhs: T[], rhs: T[]) -> T[] {

  var result = T[]()
  for e in compressedArray(lhs+rhs) { if arrayContainsElement(e, lhs) && arrayContainsElement(e, rhs) { result += e } }

  return result

}

class FileComparison: Printable {

  enum FileType:String {
    case File             = "NSFileTypeRegular"
    case Directory        = "NSFileTypeDirectory"
    case SymbolicLink     = "NSFileTypeSymbolicLink"
    case Socket           = "NSFileTypeSocket"
    case CharacterSpecial = "NSFileTypeCharacterSpecial"
    case BlockSpecial     = "NSFileTypeBlockSpecial"
    case Unknown          = "NSFileTypeUnknown"
  }

  let fileManager = NSFileManager.defaultManager()
  var canCompare = false

  var directories:(String,String) = ("","") {
    didSet {
      if !validateDirectories(directories.0, directories.1) {
        self.directories = ("","")
        self.canCompare = false
      }
    }
  }

  var description:String {

    var description = "directory1: \(directories.0)\n"
    description    += "\tsubpaths:\n"
    let subpaths = self.subpaths
    for subpath in subpaths.0 { description += "\t\t\(subpath)\n" }
    description    += "directory2: \(directories.1)\n"
    description    += "\tsubpaths:\n"
    for subpath in subpaths.1 { description += "\t\t\(subpath)\n" }

    return description

  }

  init(directories:(String,String)) {

    if validateDirectories(directories.0, directories.1) {

      self.directories = directories
      self.canCompare = true

    }

  }

  // returns whether or not the supplied paths lead to valid directories
  func validateDirectories(directory1:String, _ directory2:String) -> Bool {

    if !self.fileManager.isDirectoryAtPath(directory1) {

      println("\(directory1) is not a valid directory")
      return false

    }

    if !self.fileManager.isDirectoryAtPath(directory2) {

      println("\(directory2) is not a valid directory")
      return false

    }

    return true

  }

  func processDirectories() {

    let fm = self.fileManager
    let (subpaths1,subpaths2) = self.subpaths

    for path in subpaths1/subpaths2 {
      let path1 = self.directories.0.stringByAppendingPathComponent(path)
      let path1Exists = fm.fileExistsAtPath(path1)
      let path2 = self.directories.1.stringByAppendingPathComponent(path)
      let path2Exists = fm.fileExistsAtPath(path2)

      if fm.contentsEqualAtPath(path1, andPath:path2) {
        println("contents equal at path '\(path)'")
      } else {
        let attrs1 = fm.attributesOfItemAtPath(path1, error: nil)
        let attrs2 = fm.attributesOfItemAtPath(path2, error: nil)
        let modified1 = attrs1[NSFileModificationDate] as? NSDate
        let modified2 = attrs2[NSFileModificationDate] as? NSDate
        if modified1?.laterDate(modified2) == modified1 {
          println("action -> replace '\(path2)' with '\(path1)'")
          let cmd = "cp -p '\(path1)' '\(path2)'" as NSString
          system(cmd.fileSystemRepresentation)
        } else {
          println("action -> replace '\(path1)' with '\(path2)'")
          let cmd = "cp -p '\(path2)' '\(path1)'" as NSString
          system(cmd.fileSystemRepresentation)
        }
      }
    }

    for path in subpaths1-subpaths2 {
      let path1 = self.directories.0.stringByAppendingPathComponent(path)
      let path2 = self.directories.1.stringByAppendingPathComponent(path)
      if fm.isDirectoryAtPath(path1) {
        println("action -> make directory at '\(path2)'")
        let cmd = "mkdir '\(path2)'" as NSString
        system(cmd.fileSystemRepresentation)
      } else {
        println("action -> copy file at '\(path1)' to '\(path2)'")
        let cmd = "cp -p '\(path1)' '\(path2)'" as NSString
        system(cmd.fileSystemRepresentation)
      }
    }

    for path in subpaths2-subpaths1 {
      let path1 = self.directories.0.stringByAppendingPathComponent(path)
      let path2 = self.directories.1.stringByAppendingPathComponent(path)
      if fm.isDirectoryAtPath(path2) {
        println("action -> make directory at '\(path1)'")
        let cmd = "mkdir '\(path1)'" as NSString
        system(cmd.fileSystemRepresentation)
      } else {
        println("action -> copy file at '\(path2)' to '\(path1)'")
        let cmd = "cp -p '\(path2)' '\(path1)'" as NSString
        system(cmd.fileSystemRepresentation)
      }
    }

  }

  func dumpDirectories() {

    func dumpDirectory(directory:String) {
      let de = self.fileManager.enumeratorAtPath(directory)
      while let pathname = de.nextObject() as? String {
        let tabs = "\t" * de.level
        println("\(tabs)\(pathname.lastPathComponent)")
      }
    }

    println()
    println("processing \(self.directories.0)…")
    dumpDirectory(self.directories.0)
    println()

    println("processing \(self.directories.1)…")
    dumpDirectory(self.directories.1)
    println()

  }


  @lazy var subpaths:(Array<String>,Array<String>) = {

    var subpaths1:Array<String>
    var subpaths2:Array<String>

    if self.canCompare {

      if let subpaths = self.fileManager.subpathsAtPath(self.directories.0) as? Array<String> {

        subpaths1 = subpaths

      } else {

        subpaths1 = Array<String>()

      }

      if let subpaths = self.fileManager.subpathsAtPath(self.directories.1) as? Array<String> {

        subpaths2 = subpaths

      } else {

        subpaths2 = Array<String>()

      }

    } else {

      subpaths1 = Array<String>()
      subpaths2 = Array<String>()

    }

    return (subpaths1,subpaths2)

    }()

}

// get file manager
let fileManager = NSFileManager.defaultManager()

// get the command line arguments
let arguments:Array<String>! = NSProcessInfo.processInfo().arguments as? Array<String>

// make sure the number of arguments is correct
if arguments?.count != 3 { println("usage: dirsync directory1 directory2"); exit(1) }

// create top level comparison
let comparison = FileComparison(directories: (arguments[1],arguments[2]))

// make sure the arguments passed are valid directories
if comparison.canCompare { comparison.processDirectories() } else { exit(1) }
END

echo "$SWIFTSCRIPT"
# /usr/bin/env xcrun swift -i <(echo "$SWIFTSCRIPT") -- "$@"

}
