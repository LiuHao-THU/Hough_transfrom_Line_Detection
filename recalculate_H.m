function final_H = recalculate_H(H)
x,y = size(H);
%calculate the line function and get the cross sec line seg of matrix
for i = 1:size(H,1)
    for j = 1:size(H,2)
        x1,y1 = H(i,j);
        %calculate the line seg
        if In_bound(x1,y1)
            %calculate the line seg
            for i = 1: length()



end