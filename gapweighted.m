function [score, transcript, V] = gapweighted(S,T,blosum,letters,u)
    i = length(S);
    j = length(T);
    %Initialising matrices
    V = zeros(i+1, j+1);
    rowMax = zeros(i+1, j+1);
    colMax = zeros(i+1, j+1);
    rowMaxEntry = zeros(i+1, j+1);
    colMaxEntry = zeros(i+1, j+1);
    V(1,2:end) = u;
    V(2:end,1) = u;
    rowMax(1,:) = 0;
    rowMax(:,1) = -inf;
    colMax(1,:) = -inf;
    colMax(:,1) = 0;
    rowMaxEntry(1,:) = 1;
    rowMaxEntry(:,1) = -inf;
    colMaxEntry(1,:) = -inf;
    colMaxEntry(:,1) = 1;
    alignmentmatrix = repmat({'0'}, [i+1 j+1]);
    for index = 1:j+1
        alignmentmatrix(1, index) = {repmat('2', [1,index-1])};
    end
    for index = 1:i+1
        alignmentmatrix(index, 1) = {repmat('1', [1,index-1])};
    end
    
    %Iterating
    for index1 = 2:i+1
        for index2 = 2:j+1
            [E, temp1] = max(u+[rowMax(index1,index2-1) V(index1,index2-1)]);
            [F, temp2] = max(u+[colMax(index1-1,index2) V(index1-1,index2)]);
            letterIndex1 = letters==S(index1-1);
            letterIndex2 = letters==T(index2-1);
            G = V(index1-1, index2-1)+blosum(letterIndex1, letterIndex2);
            [a,b] = max([E F G]);
            V(index1, index2) = a;
            if b == 1
                if temp1 == 1
                    maxIndex = rowMaxEntry(index1, index2-1);
                    diff = index2 - maxIndex;
                    alignmentmatrix(index1, index2) = {append(alignmentmatrix{index1, maxIndex}, repmat('2', [1,diff]))};
                else
                    alignmentmatrix(index1, index2) = {append(alignmentmatrix{index1, index2-1}, '2')};
                end
            elseif b == 2
                if temp2 == 1
                    maxIndex = colMaxEntry(index1-1, index2);
                    diff = index1 - maxIndex;
                    alignmentmatrix(index1, index2) = {append(alignmentmatrix{maxIndex, index2}, repmat('1', [1,diff]))};
                else
                    alignmentmatrix(index1, index2) = {append(alignmentmatrix{index1-1, index2}, '1')};
                end
            else
                if S(index1-1) == T(index2-1)
                    alignmentmatrix(index1, index2) = {append(alignmentmatrix{index1-1, index2-1}, '4')};                
                else
                    alignmentmatrix(index1, index2) = {append(alignmentmatrix{index1-1, index2-1}, '3')};
                end
            end
            %Updating rowMaxEntry and colMaxEntry
            if temp1 == 1
                rowMaxEntry(index1, index2) = rowMaxEntry(index1, index2-1);
                rowMax(index1, index2) = rowMax(index1, index2-1);
            else
                rowMaxEntry(index1, index2) = index2-1;
                rowMax(index1, index2) = V(index1, index2-1);
            end
            if temp2 == 1
                colMaxEntry(index1, index2) = colMaxEntry(index1-1, index2);
                colMax(index1, index2) = colMax(index1-1, index2);
            else
                colMaxEntry(index1, index2) = index1-1;
                colMax(index1, index2) = V(index1-1, index2);
            end
        end 
    end 
    score = V(i+1, j+1);
    transcript = alignmentmatrix(i+1, j+1);
end

