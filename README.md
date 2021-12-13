# Main Game  Features

## How to play?

=> click and drag x axis to balancing and move, drag left turn right, drag right turn left
=> click and slide up to jump, jump to get a coin
=> don't click then sit down and rest
=> go as far as you can to save the cat!

## copyright

All image resources were made by my ipad.

The font used makgeolli font distributed without a ticket in Pocheon, Gangwon-do.

[https://www.pocheon.go.kr/www/contents.do?key=5582](https://www.pocheon.go.kr/www/contents.do?key=5582)

## project instructions

![20211213_055808.jpg](Main%20Game%20Features%2069b2a1e23ef0485e8113d78f49eb991f/20211213_055808.jpg)

Scene (game) node acts as a repeater between objects and manages and updates the status of the game. In addition, there are state variables made of enum in players and games, and depending on these variables, the process can make the structure intuitive by making repetitions different depending on the state.

And you have to modify the me instead of using the icon to image the buttons. It can be easily applied if you set the me file to the desired concept later on, and put the theme file in and change the settings to override when using each object.

## pendulum equation

![Untitled](Main%20Game%20Features%2069b2a1e23ef0485e8113d78f49eb991f/Untitled.png)

![Untitled](Main%20Game%20Features%2069b2a1e23ef0485e8113d78f49eb991f/Untitled%201.png)

![Untitled](Main%20Game%20Features%2069b2a1e23ef0485e8113d78f49eb991f/Untitled%202.png)

Pendulum equation was used to implement a balance system. Before that, you have to find the direction of the ground with the sensor of the cell phone. The gyro sensor may know a north direction with a magnetic sensor, but the acceleration sensor may know a direction vector of gravity acceleration. This sensor uses a right coordinate system and has a y-axis above it. Using the y-axis and x-axis, find the angle to the ground at the angle of the vector and put it with my angle in the sin value of the formula to obtain the rotational force by its gravitational acceleration, and insert cos to obtain tension. It would be nice to create a system that bounces later in proportion to the direction and magnitude of this tension when it falls off the line. This force adds acceleration to the angular velocity and applies this velocity to the z-axis angle every frame. If this happens, the player can play a trick. By checking when the y-axis was not negative, it was found whether the cell phone was turned upside down.

## 3d Sprite

![Untitled](Main%20Game%20Features%2069b2a1e23ef0485e8113d78f49eb991f/Untitled%203.png)

Sprite is not clipped to the depth test. In other words, when the two sprites are overlapped in the form of x, they are not drawn in half, but are later drawn close to the camera. Then, when the player goes more than 1/2 of the wireline, the position of the wireline becomes closer to the camera and the player is drawn behind it, resulting in a visual error. In order to solve this problem, it is difficult to make a metal that is not lit on the quad message, put images one by one, and match the ratio. There is also a problem that the difference in the depth of the z-axis between the coin and the bird is not felt. In order to solve this problem, it is necessary to apply normal maps and lighting to the texture or model it with 3d objects to create a new one.

## STATE enum

By designating the state of the game and player with enum and allowing the process function to operate according to the state, the branch could be written without complications.

## AnimationPlayer

![Untitled](Main%20Game%20Features%2069b2a1e23ef0485e8113d78f49eb991f/Untitled%204.png)
