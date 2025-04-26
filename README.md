# Physics rollback issue example

When using NetworkRigidBody3D (synced using `StateSynchronizer`) without a `RollbackSynchronizer` present in the scene tree, all seems to work fine.

After a node using `RollbackSynchronizer` is spawned, the simulation speed increases. The speed increase seems to be proportional to the amount of RollbackSynchronizer nodes, meaning more players = more speedup.

This also breaks the `RollbackSynchronizer` logic on the spawned nodes if there is any ping between the client and server.


Left window is client, right window is server:

No ping: The physics speed increases but the player controller behaves normally

[no_ping.webm](https://github.com/user-attachments/assets/bbb1f080-dd8d-4664-90b9-d804e0ae7411)

100ms ping using Clumsy: Physics speed increases and the player controller breaks on the client.

[100ms_ping.webm](https://github.com/user-attachments/assets/2700149e-89eb-4e35-b889-2f1550fc7537)
