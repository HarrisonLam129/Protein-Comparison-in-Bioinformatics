function [distance, transcript] = editdistance(S,T,transcript)
    i = length(S);
    j = length(T);
    if i == 0
        distance = j;
        transcript = repmat('2', [1,j]);
        return
    end
    if j == 0
        distance = i;
        transcript = repmat('1', [1,i]);
        return
    end
                
    indicator = isequal(S(i), T(j));
    if i >= 2 && j >= 2
        indicator2 = isequal(S(i-1), T(j-1));
        if indicator == 0
            if indicator2 == 0
                [dist1, trans1] = editdistance(S(1:i-1),T,transcript);
                [dist2, trans2] = editdistance(S,T(1:j-1),transcript);
                [distance, edit] = min([dist1+1 dist2+1]);
                if edit == 1
                    transcript = append(trans1, '1');
                elseif edit == 2
                    transcript = append(trans2, '2');
                end
            else
                [dist3, trans3] = editdistance(S(1:i-1),T(1:j-1),transcript);
                distance = dist3 + 1;
                transcript = append(trans3, '3');
            end
        else
            [dist4, trans4] = editdistance(S(1:i-1),T(1:j-1),transcript);
            distance = dist4;
            transcript = append(trans4, '4');
        end
    else
        if indicator == 0
            [dist1, trans1] = editdistance(S(1:i-1),T,transcript);
            [dist2, trans2] = editdistance(S,T(1:j-1),transcript);
            [dist3, trans3] = editdistance(S(1:i-1),T(1:j-1),transcript);
            [distance, edit] = min([dist1+1 dist2+1 dist3+1]);
            if edit == 1
                transcript = append(trans1, '1');
            elseif edit == 2
                transcript = append(trans2, '2');
            elseif edit == 3
                transcript = append(trans3, '3');
            end
        else
            [dist4, trans4] = editdistance(S(1:i-1),T(1:j-1),transcript);
            distance = dist4;
            transcript = append(trans4, '4');
        end
    end
end

    