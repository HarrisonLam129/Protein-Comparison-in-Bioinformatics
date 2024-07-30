function [distance, transcript] = editdistancematrix(S,T)
    i = length(S);
    j = length(T);
    distancematrix = zeros(i+1, j+1);
    distancematrix(1,:) = 0:j;
    distancematrix(:,1) = 0:i;
    alignmentmatrix = repmat({'0'}, [i+1 j+1]);
    for index = 1:j+1
        alignmentmatrix(1, index) = {repmat('2', [1,index-1])};
    end
    for index = 1:i+1
        alignmentmatrix(index, 1) = {repmat('1', [1,index-1])};
    end

    for index1 = 2:i+1
        for index2 = 2:j+1
            if S(index1-1) == T(index2-1)
                distancematrix(index1, index2) = distancematrix(index1-1, index2-1);
                alignmentmatrix(index1, index2) = {append(alignmentmatrix{index1-1, index2-1}, '4')};
            else
                [a, b] = min(1+[distancematrix(index1-1, index2) distancematrix(index1, index2-1) distancematrix(index1-1, index2-1)]);
                distancematrix(index1, index2) = a;
                if b == 1
                    alignmentmatrix(index1, index2) = {append(alignmentmatrix{index1-1, index2}, '1')};
                elseif b == 2
                    alignmentmatrix(index1, index2) = {append(alignmentmatrix{index1, index2-1}, '2')};
                else
                    alignmentmatrix(index1, index2) = {append(alignmentmatrix{index1-1, index2-1}, '3')};
                end
            end
        end 
    end 
    distance = distancematrix(i+1, j+1);
    transcript = alignmentmatrix(i+1, j+1);
end

