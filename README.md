# Telic
A collection of experiments programmed in Matlab R2015a

These experiments also use Psychtoolbox version 3.0.12. For more information, see https://github.com/Psychtoolbox-3/Psychtoolbox-3

#Telic 1
The initial experiment investigating the hypothesis of mass and count comparisons. The stimuli creation for these experiments involved plotting polar loops. From theta = 0 to theta = 2 * pi, a set of cartesian coordinates corresponding to the polar loop were generated. The polar loop would have between 4 and 9 loops. These coordinates were then scaled according to screen size, and an image of a star was moved along these points to create an animation of the star traversing the polar loops. Pauses in the star's movements were either equally spaced (all occuring at the center of the figure) or randomly distributed throughout the figure.

The static image stimuli included another step in their creation. After generating the set of points for the polar loop, a separate function would further manipulate them. Each section, defined by the points between two breaks (generated in the same way as the pauses), was transposed to the origin (the center of the screen) and rotated a random number of degrees. They would then be pushed out a distance equal to approximately twice the length of a petal, in the direction that the original petal pointed in (e.g. the first section of a four-loop figure would be pushed cardinally East, in the direction of the first petal of a four-polar-loop figure).

This experiment contained two conditions: events (animations) and objects (images). Each condition had 40 trials, for 80 trials total. Participants were asked to rate the similarity of pairs of animations or images on a scale of 1 to 7.

#Telic 2
This experiment used the same stimuli and structure as Telic 1. Instead of rating similarity, participants were asked to select which language they preferred to describe an image/animation.
