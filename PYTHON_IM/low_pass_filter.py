#%%
from scipy.signal import butter, lfilter, freqz
cutoff=8 
fs=64 
order=5
nyq = 0.5 * fs
normal_cutoff = cutoff / nyq
b, a = butter(order, normal_cutoff, btype='low', analog=False)
print b
print a

