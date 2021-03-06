## EE 454 Project 1
### Team Members:
Benjamin Cheng

Luke Garrett

Alan Kwong

Joshua Morgan

The layers for the CNN are stored in the “layers” subfolder within the project files. When running MATLAB, it’s important to **add all subfolders to the current path**. Alternatively, pull the layers out of the “layers” folder and place them in the same directory as the rest of the code. 

To run the demo, simply run: `demo_fast.m`

The project has 2 demo options: `demo_fast.m` and `demo_full.m` 

The only difference is that `demo_full` runs the existing CIFAR-10 dataset through the CNN to generate probabilities from scratch, while `demo_fast` uses the a file called `CNN_cifar_prob.mat` to retrieve the probabilities which were generated from the previous run of `demo_full` .
Either demo will produce the exact same results, but on our desktop copy of MATLAB `demo_full` took approximately 15 minutes to run while `demo_fast` took about 15 seconds.