# Telic
A collection of experiments programmed in Matlab R2015a

These experiments also use Psychtoolbox version 3.0.12. For more information, see https://github.com/Psychtoolbox-3/Psychtoolbox-3

#Telic 1
The initial experiment investigating the hypothesis of mass and count comparisons. The stimuli creation for these experiments involved plotting polar loops. From theta = 0 to theta = 2 * pi, a set of cartesian coordinates corresponding to the polar loop were generated. The polar loop would have between 4 and 9 loops. These coordinates were then scaled according to screen size, and an image of a star was moved along these points to create an animation of the star traversing the polar loops. Pauses in the star's movements were either equally spaced (all occuring at the center of the figure) or randomly distributed throughout the figure.

The static image stimuli included another step in their creation. After generating the set of points for the polar loop, a separate function would further manipulate them. Each section, defined by the points between two breaks (generated in the same way as the pauses), was transposed to the origin (the center of the screen) and rotated a random number of degrees. They would then be pushed out a distance equal to approximately twice the length of a petal, in the direction that the original petal pointed in (e.g. the first section of a four-loop figure would be pushed cardinally East, in the direction of the first petal of a four-polar-loop figure).

This experiment contained two conditions: events (animations) and objects (images). Each condition had 40 trials, for 80 trials total. Participants were asked to rate the similarity of pairs of animations or images on a scale of 1 to 7.

#Telic 2
This experiment used the same stimuli and structure as Telic 1. Instead of rating similarity, participants were asked to select which language they preferred to describe an image/animation.

#Telic 3
This experiment used the same stimuli as Telic 1 and 2. This was the first Telic experiment that added training trials to the start, which demonstrated the images and animations. The training trials used polar loops with fewer petals; this was accomplished by drawing a 3-loop polar figure and only traversing one or two of the loops. This experiment returned to the 1-7 rating scale question from Telic 1, but added the language from Telic 2 to the questions.

#Telic X
This experiment is almost identical to Telic 3; the only change is that the language used for the telic and atelic conditions is switched.

#Telic Y
This experiment is almost identical to Telic2; the only change is that the language for the questions used is different.

#Future Telic Experiments

Telic-Wroclaw is currently in development, and can be found at https://github.com/nu-childlab/Telic-Wroclaw
