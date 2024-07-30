function [score, transcript] = editscoreblosum(S,T,blosum,letters)
    i = length(S);
    j = length(T);
    scorematrix = zeros(i+1, j+1);
    scorematrix(1,:) = -8*(0:j);
    scorematrix(:,1) = -8*(0:i);
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
                letterIndex = letters==S(index1-1);
                scorematrix(index1, index2) = scorematrix(index1-1, index2-1)+blosum(letterIndex, letterIndex);
                alignmentmatrix(index1, index2) = {append(alignmentmatrix{index1-1, index2-1}, '4')};
            else
                letterIndex1 = letters==S(index1-1);
                letterIndex2 = letters==T(index2-1);
                [a, b] = max([-8+scorematrix(index1-1, index2) -8+scorematrix(index1, index2-1) scorematrix(index1-1, index2-1)+blosum(letterIndex1, letterIndex2)]);
                scorematrix(index1, index2) = a;
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
    score = scorematrix(i+1, j+1);
    transcript = alignmentmatrix(i+1, j+1);
end


