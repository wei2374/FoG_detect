import numpy as np

def relabel(labels,metadata):
  Relabel = np.zeros(np.size(labels))
  print("in function relabel")
  length = np.size(labels,0)
  jStart=0
  windowsize = metadata["windowsize"]
  stepsize = metadata["stepsize"]
 
  
  while(jStart<length-windowsize):
    window = labels[jStart:(jStart+windowsize-1)]
    for i in range(windowsize):
      if(labels[i]==2):
        Relabel[jStart:(jStart+windowsize-1)] = 2
        break
      else:
        Relabel[jStart:(jStart+windowsize-1)] = window

    jStart = jStart+stepsize   
  
  return Relabel

  

  