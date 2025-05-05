# Physics rollback test

By default this project has Rapier 3D + 2D enabled,
but you can change the physics engine to test Jolt and Godot physics.

## Getting started
1. Debug -> Customize run instances -> Enable multiple instances
2. Debug -> Turn on Visible collision shapes

When a `RigidBody` or `CharacterBody` enters or exits the green area,
it should print a line in the output panel.

## Known issues:
- CharacterBody collisions break when using Rapier physics and `rollback_space` is true
	- area doesn't register signals
	- players go through each other
- The following changes need to be applied to physics rollback to work (already applied in this project)
	- https://github.com/foxssake/netfox/pull/437#pullrequestreview-2801259392
	- https://github.com/foxssake/netfox/pull/437#discussion_r2073769842
