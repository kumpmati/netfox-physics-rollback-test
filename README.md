# Physics rollback issue example

When using NetworkRigidBody3D (synced using `StateSynchronizer`) without a `RollbackSynchronizer` present in the scene tree, all seems to work fine.

After a node using `RollbackSynchronizer` is spawned, the simulation speed increases. The speed increase seems to be proportional to the amount of RollbackSynchronizer nodes, meaning more players = more speedup.

Left window is client, right window is server:

[issue.webm](https://github.com/user-attachments/assets/bbb1f080-dd8d-4664-90b9-d804e0ae7411)
