function [CandidateClassifiers, Weights, MSE, Nt, LNt] = TrainingProcedureOfCandidateClassifiers...
            (t, k, f, Bt, St, LSt, Tt, LTt)
        
    sigma = 10;
    C = 100;
   
   xdata1 = St;
   group1 = LSt;
   P1 = 0.1;
   [Train, Test] = crossvalind('HoldOut',group1, P1);
   Nt = xdata1(Train,:);
   LNt = group1(Train,1);
   Pt = xdata1(Test,:);
   LPt = group1(Test,1);
   
   [N,D] = size(Nt);
   
   IRt = numel(LNt)/numel(LPt);
   Weight = zeros(1,N);
   Weight(:,:) = 1/N;
   Weights = cell(1,k);
   if IRt <= f/k      
        for i=1:k

            ind = ceil(N*rand(N,1));
            Ri = Nt(ind,:);
            Yi = LNt(ind,:);

            svmStruct = svmtrain(Ri,Yi,...
            'showplot',0,'kernel_function','rbf','rbf_sigma',sigma,...
            'boxconstraint',C);
            Lable = svmclassify(svmStruct,Pt,'showplot',0);
            predict(i,:) = Lable';
            CandidateClassifiers{i} = svmStruct;
            Weights{i} = Weight;
            MSE{i} = sum(Lable ~= LPt)/numel(LPt);
        end

   else

        for i=1:k

            ind = ceil(N*rand(N,1));
            if (numel(LNt)*f/k) == numel(LPt)
                Gi = Nt(ind,:);
                Yi = LNt(ind,:);
            else
                Ri = Nt(ind,:);
                Yi = LNt(ind,:);
            end

            svmStruct = svmtrain(Ri,Yi,...
            'showplot',0,'kernel_function','rbf','rbf_sigma',sigma,...
            'boxconstraint',C);
            Lable = svmclassify(svmStruct,Nt,'showplot',0);
            predict(i,:) = Lable;
            CandidateClassifiers{i} = svmStruct;
            MSE{i} = sum(Lable ~= LNt)/numel(LNt);
            That = Lable';
            e = Weight * (LNt'~=That)';


            if e>0.5
                Weight(:,:) = 1/N;
                continue;
            end

            alpha(i) = (0.5) * log((1-e)/e);
            Weight = Weight .* exp((-alpha(i)) * (LNt'==That));
            Weight = Weight .* exp(alpha(i) * (LNt'~=That));
            Weight = Weight/sum(Weight);
            Weights{i} = Weight;
        end      
   end
          
end