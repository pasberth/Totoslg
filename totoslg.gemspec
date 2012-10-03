# -*- ruby -*-
Gem::Specification.new do |s|
  s.name = "totoslg"
  s.version = File.read("VERSION")
  s.authors = ["pasberth"]
  s.description = ""
  s.summary = ""
  s.email = "pasberth@gmail.com"
  s.extra_rdoc_files = ["README.rst"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.homepage = "http://github.com/pasberth/Totoslg"
  s.require_paths = ["lib"]
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files = `git ls-files`.split("\n")
  s.test_files = []
  s.add_dependency "console_window"
  s.add_dependency "console_board"
  s.add_dependency "game_pencil"
end
