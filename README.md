# ESE_Labo3
## Performance mesurement 
The mesured time of the tab copy is _36.23 us_, with system clock @16MHz
The mesured time of the tab copy is _2.7 us_, with system clock @216MHz

By aligning on 4 bytes, the speed mesured is _710 ns_

With the final optimisation, (Using 9 registers to copy the tab), the time low to _270 ns_

## Test of memcpy
Without compiler optimisation, the memcpy is taking _850 ns_ to copy
In every configurations of the compiler, the time is still _850 ns_, since memcpy is already compiled
By enabling the I-cache, we can lower te time to _560 ns_