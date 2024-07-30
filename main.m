S = 'SHESELLS';
T = 'SEASHELLS';

[distance, transcript] = editdistancematrix(S,T);
transcript = transcript{1};

alignment = repmat(' ', [3, length(transcript)]);

alignment(2,:) = [S zeros(1,length(transcript)-length(S))];
alignment(3,:) = [T zeros(1,length(transcript)-length(T))];

for i = 1:length(transcript)
    if transcript(i) == '1'
        alignment(1,i) = 'D';
        alignment(3,:) = append(alignment(3,1:i-1),' ',alignment(3,i:length(transcript)-1));
    elseif transcript(i) == '2'
        alignment(1,i) = 'I';
        alignment(2,:) = append(alignment(2,1:i-1),' ',alignment(2,i:length(transcript)-1));
    elseif transcript(i) == '3'
        alignment(1,i) = 'R';
    else
        alignment(1,i) = 'M';
    end
end


A = 'MGLSDGEWQLVLKVWGKVEGDLPGHGQEVLIRLFKTHPETLEKFDKFKGLKTEDEMKASADLKKHGGTVLTALGNILKKKGQHEAELKPLAQSHATKHKISIKFLEYISEAIIHVLQSKHSADFGADAQAAMGKALELFRNDMAAKYKEFGFQG';
B = 'MADFDAVLKCWGPVEADYTTMGGLVLTRLFKEHPETQKLFPKFAGIAQADIAGNAAISAHGATVLKKLGELLKAKGSHAAILKPLANSHATKHKIPINNFKLISEVLVKVMHEKAGLDAGGQTALRNVMGIIIADLEANYKELGFSG';

[distance, transcript] = editdistancematrix(A,B);
transcript = transcript{1};

alignment = repmat(' ', [3, length(transcript)]);

alignment(2,:) = [A zeros(1,length(transcript)-length(A))];
alignment(3,:) = [B zeros(1,length(transcript)-length(B))];

for i = 1:length(transcript)
    if transcript(i) == '1'
        alignment(1,i) = 'D';
        alignment(3,:) = append(alignment(3,1:i-1),' ',alignment(3,i:length(transcript)-1));
    elseif transcript(i) == '2'
        alignment(1,i) = 'I';
        alignment(2,:) = append(alignment(2,1:i-1),' ',alignment(2,i:length(transcript)-1));
    elseif transcript(i) == '3'
        alignment(1,i) = 'R';
    else
        alignment(1,i) = 'M';
    end
end


blosum = readmatrix('II-9-3-2022-blosum.txt');
blosum = blosum(:,2:end);
letters = ['C' 'S' 'T' 'P' 'A' 'G' 'N' 'D' 'E' 'Q' 'H' 'R' 'K' 'M' 'I' 'L' 'V' 'F' 'Y' 'W'];

[score, transcript] = editscoreblosum(A,B,blosum,letters);

transcript = transcript{1};

alignment = repmat(' ', [3, length(transcript)]);

alignment(2,:) = [A zeros(1,length(transcript)-length(A))];
alignment(3,:) = [B zeros(1,length(transcript)-length(B))];

for i = 1:length(transcript)
    if transcript(i) == '1'
        alignment(1,i) = 'D';
        alignment(3,:) = append(alignment(3,1:i-1),' ',alignment(3,i:length(transcript)-1));
    elseif transcript(i) == '2'
        alignment(1,i) = 'I';
        alignment(2,:) = append(alignment(2,1:i-1),' ',alignment(2,i:length(transcript)-1));
    elseif transcript(i) == '3'
        alignment(1,i) = 'R';
    else
        alignment(1,i) = 'M';
    end
end


C = 'MTSDCSSTHCSPESCGTASGCAPASSCSVETACLPGTCATSRCQTPSFLSRSRGLTGCLLPCYFTGSCNSPCLVGNCAWCEDGVFTSNEKETMQFLNDRLASYLEKVRSLEETNAELESRIQEQCEQDIPMVCPDYQRYFNTIEDLQQKILCTKAENSRLAVQLDNCKLATDDFKSKYESELSLRQLLEADISSLHGILEELTLCKSDLEAHVESLKEDLLCLKKNHEEEVNLLREQLGDRLSVELDTAPTLDLNRVLDEMRCQCETVLANNRREAEEWLAVQTEELNQQQLSSAEQLQGCQMEILELKRTASALEIELQAQQSLTESLECTVAETEAQYSSQLAQIQCLIDNLENQLAEIRCDLERQNQEYQVLLDVKARLEGEINTYWGLLDSEDSRLSCSPCSTTCTSSNTCEPCSAYVICTVENCCL';
D = 'MPYNFCLPSLSCRTSCSSRPCVPPSCHSCTLPGACNIPANVSNCNWFCEGSFNGSEKETMQFLNDRLASYLEKVRQLERDNAELENLIRERSQQQEPLLCPSYQSYFKTIEELQQKILCTKSENARLVVQIDNAKLAADDFRTKYQTELSLRQLVESDINGLRRILDELTLCKSDLEAQVESLKEELLCLKSNHEQEVNTLRCQLGDRLNVEVDAAPTVDLNRVLNETRSQYEALVETNRREVEQWFTTQTEELNKQVVSSSEQLQSYQAEIIELRRTVNALEIELQAQHNLRDSLENTLTESEARYSSQLSQVQSLITNVESQLAEIRSDLERQNQEYQVLLDVRARLECEINTYRSLLESEDCNLPSNPCATTNACSKPIGPCLSNPCTSCVPPAPCTPCAPRPRCGPCNSFVR';

[score, transcript] = gapweighted(C,D,blosum,letters,-12);
transcript = transcript{1};

alignment = repmat(' ', [3, length(transcript)]);

alignment(2,:) = [C zeros(1,length(transcript)-length(C))];
alignment(3,:) = [D zeros(1,length(transcript)-length(D))];

for i = 1:length(transcript)
    if transcript(i) == '1'
        alignment(1,i) = 'D';
        alignment(3,:) = append(alignment(3,1:i-1),' ',alignment(3,i:length(transcript)-1));
    elseif transcript(i) == '2'
        alignment(1,i) = 'I';
        alignment(2,:) = append(alignment(2,1:i-1),' ',alignment(2,i:length(transcript)-1));
    elseif transcript(i) == '3'
        alignment(1,i) = 'R';
    else
        alignment(1,i) = 'M';
    end
end


limit = estimate(2000,-3,3);
plot(limit);
xlabel('n');
ylabel('Estimate');


vsub = vsub(C,D,blosum,letters);

