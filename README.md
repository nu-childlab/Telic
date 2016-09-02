# Telic
A collection of experiments programmed in Matlab R2015a

These experiments also use Psychtoolbox version 3.0.12. For more information, see [the github page](https://github.com/Psychtoolbox-3/Psychtoolbox-3).

#Design Notes: Telic 1-3, X and Y
##Polar Loop Calculations
The stimuli creation for these experiments involved plotting polar loops. From theta = 0 to theta = 2 * pi, a set of cartesian coordinates corresponding to the polar loop were generated. The polar loop would have between 4 and 9 loops. These coordinates were then scaled according to screen size.

The first set of stimuli used these points to generate dynamic animation events. An image of a star was moved along these points to create an animation of the star traversing the polar loops. Pauses in the star's movements were either equally spaced (all occuring at the center of the figure) or randomly distributed throughout the figure.

The second set of stimuli, the static image stimuli, included another step in their creation. After generating the set of points for the polar loop, a separate function would further manipulate them. Each section, defined by the points between two breaks (generated in the same way as the pauses), was transposed to the origin and rotated a random number of degrees. They would then be pushed out a distance equal to approximately twice the length of a petal, in the direction that the original petal pointed in (e.g. the first section of a four-loop figure would be pushed cardinally East, in the direction of the first petal of a four-polar-loop figure).

##Training Trials
Telic 3 and Telic X both used a set of training trials to introduce the stimuli. The training trials used polar loops with fewer petals; this was accomplished by drawing a 3-loop polar figure and only traversing one or two of the loops.

##Other Additions
Telic 1, Telic 2, and an earlier version of Telic 3 only run one of two conditions; you need to run the script twice and choose a different condition each time to get the full experiment. The version of Telic 3 uploaded here and all future Telic experiments run both conditions on the same script; at start you will be prompted to choose which condition should be run first.

#Polar Loop Experiments
##Telic 1
The initial experiment investigating the hypothesis of mass and count comparisons. Participants were asked to rate the similarity of pairs of animations or images on a scale of 1 to 7. Each condition had 40 trials, for 80 trials total.

##Telic 2
Instead of rating similarity, participants were asked to select which language they preferred to describe an image/animation. They saw only one image or animation per trial instead of pairs. Participants see each number of loops 6 times for each of two conditions (events or objects), for a total of 72 trials.

##Telic 3
This experiment returned to the 1-7 rating scale question from Telic 1, but added the language from Telic 2 to the questions. Each condition had 40 trials, for 80 trials total.

##Telic X
This experiment is almost identical to Telic 3; the only change is that the language used for the telic and atelic conditions is switched.

##Telic Y
This experiment is almost identical to Telic2; the only change is that the language for the questions used is different.

#Design Notes: Telic Wroclaw and Onwards
Beginning with Telic Wroclaw and continuing onwards, I've made a number of changes to improve the clarity and manipulability of this collection of experiments. Development of future experiments will be based on Wroclaw's structure.
##Ellipse Calculations
The polar loops used for previous experiments have been replaced with ellipses. One ellipse corresponds to one petal of a polar loop. This change allows the size of the loops to be more easily manipulated. After each ellipse is created, it is rotated such that each ellipse will be equally spaced from 0 to 360 degrees. They are then pushed out an amount so that one edge of the ellipse touches the origin, thus arranging the ellipses into a flower-like shape similar to the polar loops.

Additionally, the beginning point of the ellipse is not where it needs to be for the progression of the animation, so the list of points has to be moved slightly to make sure the shapes' movements start at the correct point of the ellipse. The rotation and spatial separation uses the same method as for polar loops.

##Training Trials
Telic Wroclaw and Wroclaw Prime used training trials, set up differently from previous training segments. These training trials used shapes with one, two, or three ellipses, each of which was applied to one timing condition. This resulted in a total of 6 training trials, with the shape of a star or heart randomly assigned to each.

##Other Additions
* The star image has been changed to a brighter red, and there is now a blue heart image. 
* The animation and image stimuli-creation code has been separated into functions. This makes the main experiment file clearer.
* The break creation function has been improved. The randomized breaks are generated with a different, more efficient method to ensure that the minimum space separates each break.
* The minimum number of frames between breaks was reduced from 20 to 10 to accomodate having shorter loop times
* The time spend pausing for breaks in the animation was reduced from .5 seconds to .25 seconds.
* The training functions have been condensed into a single function that draws a different sentence depending on the phase of the experiment
* The experiments now save data to a different location. It is saved to a folder within the Telic folder, for ease of access and so that creating a separate, distinct data folder in a specific location on the computer is no longer necessary.

#Ellipse Experiments
##Telic Wroclaw and Wroclaw Prime
Telic Wroclaw  and Telic Wroclaw Prime have not been run, and can be found at [the Telic Wroclaw github page](https://github.com/nu-childlab/Telic-Wroclaw). This experiment uses a set of anticorrelated timing values. When these values are used, the animations will move faster when there are more loops. While previously, a 9-loop animation would take loger than a 4-loop, the anticorrelated times make the 9-loop animation take less time than the 4-loop. This experiment contains 20 trials, with two animations per trial, over 2 conditions, for a total of 40 trials.

##Telic 2 Variations
Variations on Telic 2 have been developed, but are not finished running, and can be found at the [Telic 2 Variations github page](https://github.com/nu-childlab/Telic2-Variations).

Version 2v2 is in review. It will examine the effect of the spatial separation used for object stimuli by applying the same rotation and spatial gaps to the animation paths. The star will jump from path to path (not necessarily in clockwise order) and traverse sections of the path, similar to the object stimuli from the previous Telic experiments. As a note, the size of the gaps has decreased from previous experiments to ensure that the star does not move off-screen. Participants see each number of loops 6 times for each of two conditions (events or objects), for a total of 72 trials.

Version 2v3 is almost identical to version 2v2, but the starting point of the figure is randomized, so the natural condition has pieces of the same shape, but that shape is not necessarily an ellipse.

Version 2v4 is almost identical to version 2v3, but there is an additional break added to the natural condition, such that it contains n+1 pieces of equal length, where n is the number of loops in the figure.

##Telic Z
Telic Z has not begun development.

##Telic U
Telic U has not begun development.

##Telic W
Telic W has not begun development.

##Telic filled in
Telic filled in has not begun development.

##Telic non-rotated
Telic non-rotated has not begun development
