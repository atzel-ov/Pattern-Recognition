function A = myLDA(Samples, Labels, NewDim)
% Input:    
%   Samples: The Data Samples 
%   Labels: The labels that correspond to the Samples
%   NewDim: The New Dimension of the Feature Vector after applying LDA

	%A=zeros(NumFeatures,NewDim);

    Sw = zeros(size(Samples,2),size(Samples,2));
    Sb = zeros(size(Samples,2),size(Samples,2));
    m0 = 0;
    
	[NumSamples NumFeatures] = size(Samples);
    NumLabels = length(Labels);
    if(NumSamples ~= NumLabels) then
        fprintf('\nNumber of Samples are not the same with the Number of Labels.\n\n');
        exit
    end
    Classes = unique(Labels);
    NumClasses = length(Classes);  %The number of classes

    %For each class i
	%Find the necessary statistics
    for i = 1:NumClasses
        %Calculate the Class Prior Probability
	    P(i)=(sum(Labels == i-1))/(NumSamples);
        %Calculate the Class Mean 
	    mu(i,:) = mean(Samples(Labels == i-1,:));
        %Calculate the Within Class Scatter Matrix
	    Sw= Sw + P(i)*cov(Samples(Labels == i-1,:));
        %Calculate the Global Mean
	    m0= m0 + mean(NumFeatures*mu(i,:));
    end


    for i = 1:NumClasses
        %Calculate the Between Class Scatter Matrix
	    Sb= Sb + P(i)*(mu(i,:)-m0)*(mu(i,:)-m0)';
    end
    

    Sw
    Sb
     
  
    %Eigen matrix EigMat=inv(Sw)*Sb
    EigMat = Sw\Sb;
    
    %Perform Eigendecomposition
    [Q,L] = eig(EigMat);    
    [~,ind] = sort(diag(L),'descend');

    %Select the NewDim eigenvectors corresponding to the top NewDim
    %eigenvalues (Assuming they are NewDim<=NumClasses-1)
	%% You need to return the following variable correctly.
	%A=zeros(NumFeatures,NewDim);  % Return the LDA projection vectors

    W = Q(:,ind(1:NewDim));
    
    A = W;






