# R1.1  How many poses are needed to reliably determine the rotation matrix? Elaborate and explain.
* To reliably determine the rotation matrix we need to first **calibrate** root cell sensor and target cell sensor using acceleromter on it.
* For each cell we need to measure on all three axis and for each axis we need to measure on both positive and negative axis, so in total we need to measure 12 poses, 6 for each cell.

# R1.2 How do the singular values relate to an under defined, partially defined, fully defined,and over defined solution for the rotation matrix? Elaborate and explain

* A can be transform to B with rotation matrix R; 
  > AR=B

* Singular value decomposition can be applied to both A and B, we get
  > $A=U_A\Sigma_AV_A^T$

  > $B=U_B\Sigma_BV_B^T$
   
* The sigular value matrix represents streches on different axis. The number of singular value on diagonal axis of Sigma also represents the rank of matrix A and B.  
 
* If the rotation matrix is **fully defined**, this means A and B has the same rank. Also the number of elements on diagonal axis of $\Sigma_A$ and $\Sigma_B$ is the same. Same number of non-zero singular values.

* If the rotation matrix is **over defined**, this means A matrix has less rank than B. For example, there is no way transfer a 2D rotation to a 3D rotation. Also the number of elements on diagonal axis of $\Sigma_A$ is less than $\Sigma_B$. B has more non-zero singular values than A.

* If the rotation matrix is **partially defined** or **under defined**, this means A matrix has more rank than B. For example, there is many way transfer a 3D rotation to a 2D rotation. Also the number of elements on diagonal axis of $\Sigma_A$ is more than $\Sigma_B$. A has more non-zero singular values than B.
  



# 1.2 Bonus
* The solution can be find in pdf file (bonus.pdf).
