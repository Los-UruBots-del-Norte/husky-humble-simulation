FROM osrf/ros:humble-desktop-full

ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /home/husky
# Install dependencies
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y \
    curl wget git cmake libgl1-mesa-glx mesa-utils python3 python3-pip ros-humble-ament-cmake-python  && \
    rm -rf /var/lib/apt/lists/*   

# Install gazebo
RUN curl -sSL http://get.gazebosim.org | bash
RUN source /opt/ros/${ROS_DISTRO}/setup.bash
 
# Create workspace
RUN source /opt/ros/humble/setup.bash && \ 
    mkdir -p /home/husky/husky_ws/src && \
    cd /home/husky/husky_ws && \
    rosdep update && \
    rosdep install --from-paths src --ignore-src -r -y && \
    colcon build --symlink-install

RUN source /opt/ros/humble/setup.bash && \
    echo source /usr/share/gazebo/setup.bash >> ~/.bashrc && \
    echo source /home/husky/husky_ws/install/setup.bash >> ~/.bashrc

# Husky
RUN source /opt/ros/humble/setup.bash && \
    cd /home/husky/husky_ws/src && \
    git clone -b humble-devel https://github.com/Los-UruBots-del-Norte/husky.git && \
    cd /home/husky/husky_ws && \
    rosdep update && \
    rosdep install --from-paths src --ignore-src -r -y && \
    colcon build --symlink-install

RUN source ~/.bashrc