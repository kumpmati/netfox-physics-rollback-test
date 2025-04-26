# Physics rollback issue example

How to reproduce issue:

1. Run project and press 'Start' in the menu
2. Observe the speed of the bouncing balls before the players (red cubes) are spawned in
3. After 5 seconds the players are spawned, each containing a RollbackSynchronizer
4. The physics simulation speed now increases proportional to how many players there are.
The RollbackSynchronizer also breaks for clients, seemingly simulating faster than they are supposed to.


Example 1 (no ping):
![no ping](/no_ping.webm)

Example 2 (100ms ping using Clumsy):
![no ping](/100ms_ping.webm)
