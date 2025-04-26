# Physics rollback issue example

How to reproduce issue:

1. Run project and press 'Start' in the menu
2. Observe the speed of the bouncing balls before the players (red cubes) are spawned in
3. After 5 seconds the players are spawned, each containing a RollbackSynchronizer
4. The physics simulation speed now increases proportional to how many players there are.
The RollbackSynchronizer also breaks for clients, seemingly simulating faster than they are supposed to.


Example 1 (no ping):
[no_ping.webm](https://github.com/user-attachments/assets/bbb1f080-dd8d-4664-90b9-d804e0ae7411)

Example 2 (100ms ping using Clumsy):
[100ms_ping.webm](https://github.com/user-attachments/assets/2700149e-89eb-4e35-b889-2f1550fc7537)
