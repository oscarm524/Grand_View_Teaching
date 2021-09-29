## Reading the csv files
durant = read.csv(file = 'Durant_2011_2012.csv')
james = read.csv(file = 'James_2011_2012.csv')

## Defining an array to store results
results = array()

for(i in 1:1000){
   
   ## Simulating data 
   durant_sim_data = durant$AST[sample(dim(durant)[1], replace = T)]
   james_sim_data = james$AST[sample(dim(james)[1], replace = T)]
 
   ## Computing the difference in averages
   durant_avg = mean(durant_sim_data)
   james_sim_data = mean(james_sim_data)
   results[i] = durant_avg - james_sim_data

}

## Estimating the difference of averages
diff_avg = mean(results)

## Estimating the margin of error
ME = sd(results)
