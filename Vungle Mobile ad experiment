## Business Problem

Vungle wanted to evaluate whether a new mobile ad algorithm could improve their conversion performance compared to the existing ad mechanism? The objective was to increase post-ad conver. 
rates while maintaing user engagement and  minimizing negative impact on session behavior,

Groups            |    Description
-------------------------------------------------------------
Control group     |  The existing mobile ad algorithm
Treatment group   |   The new mobile ad algorithm

##  primary metrics

total impressions	   252,284,778  (*calculated* sum(impressions for control group and treatment group)
Avg eRPM A	          3.35        (*calculated* Average eRPM of control group)
Avg eRPM B	          3.46        (*calculated* Average eRPM of Treatment group)
Diff in ERPM(B-A)	     0.11       (*calculated* Difference of Avg (eRPM group A - eRPM group B)
	
Estimate of value of B	 28,230.67 (*calculated* impressions/1000* Diff in ERPM(B-A))




# Hypothesis Testing using metric eRPM in the datset

--**Null hypothesis(H0): **eRPM(B)- eRPM(A) = 0
--**Alt. hypothesis(H1): **eRPM(B)- eRPM(A) > 0

**Note: We did the t-test paired using the software and we got our output as mentioned below

> t.test(vungle_B, vungle_A, paired = T)

	Paired t-test

data:  vungle_B and vungle_A
t = 3.3251, df = 29, p-value = 0.002406
alternative hypothesis: true mean difference is not equal to 0
95 percent confidence interval:
 0.0430718 0.1807282
sample estimates:
mean difference 
         0.1119 


--**We reject the null**--

SE is lower in the paired t-test because the difference in eRPM per day varies less than eRPM itself
Can you say why?
This is because day-to-day differences in performance are due to two reasons:
Ø Difference in nature of algorithm 
Ø Each day is different from the other – this increases the SE of the difference of means estimator


####  next steps coming soon
