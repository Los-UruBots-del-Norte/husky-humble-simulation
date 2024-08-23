## Running a Husky simulation

### Requirements
- Ubuntu 20 or 22
- Docker
- Docker-compose
- X11

### X11 
To see Gazebo, run this command on a terminal first:

```bash
xhost +
```

### Env file
Create a .env file with this content:

```bash
DISPLAY=host.docker.internal:0
```

### How to Run Docker-compose
```bash
docker compose up
```

### Control the Husky
Execute this commands in order on a new terminal:

```bash
docker ps
```
Copy the id example ***a6c31d880b65*** and execute:

```bash
docker exec -it a6c31d880b65 /bin/bash
```

Simulation on Docker

```bash
source install/setup.bash
ros2 topic pub --once /husky_velocity_controller/cmd_vel_unstamped geometry_msgs/msg/Twist '{linear: {x: 0.5, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 0.0}}'
```