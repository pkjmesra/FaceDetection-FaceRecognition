A plain simple sample project to demonstrate face detection using CoreImage APIs.
The same sample also demonstrates face recognition using Eigenfaces method (using Fisherfaces model. See http://www.cs.columbia.edu/~belhumeur/journal/fisherface-pami97.pdf)
.

How to use:
==========
1. Try Static Face Detection: Will allow you to choose a photo with a face from your 
photo library and will try & determine if it has eyes/mouth in the photo. If it has,
it will mark the eye and mouth positions on the image.

2.Try Live Feed Face Detection: Will allow you to use the front facing or rear facing camera to detect a face and place a mustache just below the nose of the detected face.

3.Try Live Feed Face Recognition: (You may have to relaunch the app, if you already 
used 1. and 2. above). It will allow you to train the model with different sets of
images of the same or different persons and then can help recognize a face that 
belongs to one of the sample training sets. It's advisable to take multiple sets
of different persons rather than the same person.

4. Try static Face Recognition: Yet to be done.
