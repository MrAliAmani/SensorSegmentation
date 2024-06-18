function Noise = Gaussian_Noise(data)

    [R, C] = size(data);
    mu = mean(data);
    sigma = std(data);
    
    for i = 1:R
        for j = 1:C
            Noise(i, j) = ((2*pi*(sigma(1, j) ^ 2)) ^ (-1/2)) *...
                exp(-((data(i, j) - mu(1, j)) ^ 2) / (2 * (sigma(1, j) ^ 2)));
            
%             disp(['Pure Data (' num2str(i) ',' num2str(j) ') = ' num2str(data(i, j)) ' =====> Noisy Data (' num2str(i) ',' num2str(j) ') = ' num2str(Noise(i, j))]);
%             pause(0.1)
        end
    end
    
%     figure
%     plot(data,'r',Noise,'b','LineWidth',2) ;
%     title('Pure and Noisy Data') ;
%     xlabel('Number Of Data') ;
%     ylabel('Value') ;
%     legend('Pure Data','Noisy Data');
%     grid on

end