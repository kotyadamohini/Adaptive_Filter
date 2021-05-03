# Adaptive_Filter
 Many digital signal processing applications (DSP) apllications require linear filters that can adapt to changes in the signals they process.Adaptive filters find an extensive use in several DSP applications including acoustic echo cancellation,signal de-noising,sonar signal processing,clutter rejection in radars and channel equilization for communications and networking systems.It is important for the adaptive filters that are implemented to have higher throughput.And also it very important to use less hardware.
So the best technique for this requirements is Distributed Arithmetic.
Generally,the algorithm that we use for weight adaptation is Least Mean Square algorithm(LMS).
           W[n+1]=W[n]+ne[n]X[n] ,Where,
           W[n+1] is adapted weight vector, 
           W[n] is previous weight vector,
           n is step size,
           e[n]=d[n]-Y[n],error between desired and obtained output,
           X[n] is input vector.
The weights are updated as long as error becomes zero.Overall this design is called DA based LMS Adaptive Filter.          
