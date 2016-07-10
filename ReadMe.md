## Implentation for Regenerating Codes
1. Generator matrix depends only on the parameter of codes, not on the encoded message.
2. All elements of matrixes and messages are represented in galois field GF(2^exp).
3. Arithmatric is based on the prime polynomial of galois field.

#### MBR
* Implentation of exact regenerating for (n, k, d) MBR.
* There are two generator matrixes available: systemetical and non-systemetical generator matrix.
* The encoded message is defined as organized numbers [1, 2, ..., U].
* Failed node and helpers are generated randomly.
* Results of regenerating and non-systemetical decoding will be showed.

```
  function [MessageSize, CodedSize, RegeneratingBandwidth, DecodingBandwidth, diskIO] = MBR(Parameter)
```
Parameter of code is defined as below:
```
  Parameter = [n, k, d]
```
Return values of this function are:
  1. MessageSize: Size of original message.
  2. CodedSize: Size of coded code word.
  3. RegeneratingBandwidth: Bandwidth to regenerating a failed node.
  4. DecodingBandwidth: Bandwidth to decode the original message.
  5. diskIO: Disk-I/O during a regenerating process.
  
#### MSR
* Implentation of exact regenerating for (n, k, d >= 2k - 2) MSR.
* There is only non-systemetical generator matrix available.
* The encoded message is defined as organized numbers [1, 2, ..., U].
* Failed node and helpers are generated randomly.
* Result of regenerating and decoding will be showed.

```
  function [MessageSize, CodedSize, RegeneratingBandwidth, DecodingBandwidth, diskIO] = MSR(Parameter)
```
Parameter of code is defined as below:
```
  Parameter = [n, k, d]
```
Return values of this function are:
  1. MessageSize: Size of original message.
  2. CodedSize: Size of coded code word.
  3. RegeneratingBandwidth: Bandwidth to regenerating a failed node.
  4. DecodingBandwidth: Bandwidth to decode the original message.
  5. diskIO: Disk-I/O during a regenerating process.

#### MISER
* Implentation of interference alignment for (n = 2k, k, d = 2k - 1) MISER.
* There is only systemetical generator matrix available.
* The encoded message is defined as organized numbers [1, 2, ..., U].
* Failed node and helpers are generated randomly.
* Result of regenerating will be showed.

```
  function [MessageSize, CodedSize, RegeneratingBandwidth, diskIO] = MISER(Parameter)
```
Parameter of code is defined as below:
```
  Parameter = [n, k, d]
```
Return values of this function are:
  1. MessageSize: Size of original message.
  2. CodedSize: Size of coded code word.
  3. RegeneratingBandwidth: Bandwidth to regenerating a failed node.
  4. diskIO: Disk-I/O during a regenerating process.

#### Paralle Repaire
* Generator matrix is defined for each parameter at first time running. For later encoding of messages with same parameter, new generator matrix will not be created any more. 
* Whether the failed node is regenerated correctly or not, will be showed.

```
  function [regeneratingBandwidth, reconstructionBandwidth, regeneratingTime, reconstructionTime, optPoint, messageSize] = ParallelRepaire(codeType, Parameter)
```
Parameters are defined as below:
```
  codeType = 'MSR';
  Parameter = [n, k, d];
```
or
```
  codeType = 'MBR';
  Parameter = [n, k, d];
```
Return values of this function are:
  1. regeneratingBandwidth: Total bandwidth to parallel regenerating failed nodes.
  2. reconstructionBandwidth: Total bandwidth to MDS regenerating failed nodes.
  3. regeneratingTime: Total time to parallel regenerating failed nodes.
  4. reconstructionBandwidth: Total time to MDS regenerating failed nodes.
  5. optPoint: The optimal point for parallel and MDS regeneratings.
  6. messageSize: Size of original message

#### Test Cases
The values of parameters should be loaded, before running test cases. The predefined parameters are:
* From (7, 3, 4) to (7, 3, 6)
* From (15, 4, 6) to (15, 4, 14)
* From (20, 6, 10) to (20, 6, 19)
* From (30, 10, 18) to (30 10 , 29)
* From (60, 20, 38) to (60, 20, 59)
* (2k, k, 2k - 1) which k is from 2 to 7
Users can define parameters by themself, follow the pattern of (n, k, d >= 2k - 2) for E-MBR and E-MSR, (2k, k, 2k - 1) for MISER.

The available Test cases are:
  1. Testcase1: Ploting *Speicher %*, *Reparatur-Bandbreite %*, *Reparatur-Bandbreite* and *Dekodierungs-Bandbreite %* with different Reparatur-Localities d.
  1. Testcase2: Ploting *Reparatur-Bandbreite %* and *Zeit / s* for E-MBR and E-MSR.
  3. Testcase3: Ploting *Optimalpunkt* of E-MBR, E-MSR and E-RC with different Reparatur-Localities d.
  4. Testcase4: Ploting *Regenerating-Bandbreite* and *Disk-I/O* of E-MSR and MISER with different k.

