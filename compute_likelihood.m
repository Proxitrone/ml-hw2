function likelihood = compute_likelihood(freq_prob,sample_data)
%COMPUTE_LIKELIHOOD Summary of this function goes here
%   Detailed explanation goes here
    likelihood = size(sample_data);
    for i=1:size(sample_data,1)
       likelihood(i) =  freq_prob(i, sample_data(i)+1);
    end
    
end

