## Implentation for Regenerating Codes
1. Generator matrix depends only on the parameter of codes, not on the encoded message.
2. All elements of matrixes and messages are represented in galois field GF(2^exp).
3. Arithmatric is based on the prime polynomial in galois field.

#### MBR
* Implentation of exact regenerating for (n, k, d) MBR.
* There are two generator matrixes available: systemetical and non-systemetical generator matrix.
* The encoded message is defined as [1, 2, ..., U].
* Failed node and helpers are generated randomly.

```
  [codewordMatrix, repairedMessage] = MBR(Parameter)
```
Parameter of code is defined as below:
```
  Parameter = [n, k, d]
```

#### MSR
* Implentation of exact regenerating for (n, k, d >= 2k - 2) MSR.
* There is only non-systemetical generator matrix available.
* The encoded message is defined as [1, 2, ..., U].
* Failed node and helpers are generated randomly.

```
  [codewordMatrix, repairedMessage] = MSR(Parameter)
```
Parameter of code is defined as below:
```
  Parameter = [n, k, d]
```

#### main
* Generator matrix is defined for each parameter at first time. For flowing encoding of messages with same parameter, generated matrix will not be defined. 
* If the failed node is regenerated correctly will be showed.

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
