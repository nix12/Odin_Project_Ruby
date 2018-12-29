require_relative 'Dungeon.rb'

my_dungeon = Dungeon.new("Fred Bloggs")

my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", { :west => :smallcave })
my_dungeon.add_room(:smallcave, " Small Cave", "a small, claustrophobic cave", { :east => :largecave })

my_dungeon.start(:largecave)

my_dungeon.go(:west)
